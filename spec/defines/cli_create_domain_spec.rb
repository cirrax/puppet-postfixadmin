require 'spec_helper'

describe 'postfixadmin::cli::create_domain' do
  let :default_params do
    { default_aliases: true }
  end

  shared_examples 'postfixadmin::cli::create_domain shared examples' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('postfixadmin::cli::params') }

    it {
      is_expected.to contain_exec('postfixadmin create_domain ' + params[:domain])
        .with_command(%r{ domain add })
        .with_unless(%r{ domain view })
    }
  end
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        let(:title) { 'mytitle.ch' }
        let :params do
          default_params.merge(
            description: title,
            domain: title,
          )
        end

        it_behaves_like 'postfixadmin::cli::create_domain shared examples'

        it {
          is_expected.to contain_exec('postfixadmin create_domain ' + params[:domain])
            .with_command(%r{ --description 'mytitle.ch' })
            .with_command(%r{ mytitle.ch })
            .with_command(%r{ --default-aliases|})
            .without_command(%r{--aliases})
            .without_command(%r{--mailboxes})
            .without_command(%r{--quota})
            .without_command(%r{--maxquota})
            .with_unless(%r{ mytitle.ch|})
        }
      end

      context 'without default aliases' do
        let(:title) { 'mytitle.ch' }
        let :params do
          default_params.merge(
            domain: title,
            default_aliases: false,
          )
        end

        it_behaves_like 'postfixadmin::cli::create_domain shared examples'
        it {
          is_expected.to contain_exec('postfixadmin create_domain ' + params[:domain])
            .with_command(%r{ mytitle.ch })
            .without_command(%r{--default-aliases})
        }
      end

      context 'with non defaults' do
        let(:title) { 'mytitle.ch' }
        let :params do
          default_params.merge(
            domain: 'blah.ch',
            description: 'Beschreibung',
          )
        end

        it_behaves_like 'postfixadmin::cli::create_domain shared examples'
        it {
          is_expected.to contain_exec('postfixadmin create_domain ' + params[:domain])
            .with_command(%r{ --description 'Beschreibung' })
            .with_command(%r{ blah.ch })
            .with_unless(%r{ blah.ch|})
        }
      end

      context 'with quota etc' do
        let(:title) { 'mytitle.ch' }
        let :params do
          default_params.merge(
            domain: title,
            description: title,
            aliases: 11,
            mailboxes: 22,
            quota: 33,
            maxquota: 44,
          )
        end

        it_behaves_like 'postfixadmin::cli::create_domain shared examples'
        it {
          is_expected.to contain_exec('postfixadmin create_domain ' + params[:domain])
            .with_command(%r{ --aliases 11 })
            .with_command(%r{ --mailboxes 22 })
            .with_command(%r{ --quota 33 })
            .with_command(%r{ --maxquota 44 })
        }
      end
    end
  end
end
