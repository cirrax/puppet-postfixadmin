
require 'spec_helper'

describe 'postfixadmin' do
  let(:pre_condition) { ['include mysql::params'] }

  let :default_params do
    { ensure_database: false,
      ensure_vhost: false,
      ensure_postfix_queries: false,
      ensure_dovecot_queries: false,
      admins: {},
      domains: {},
      dovecot_classes: [],
      postfix_classes: [] }
  end

  shared_examples 'postfixadmin shared examples' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('postfixadmin::install') }
    it { is_expected.to contain_class('postfixadmin::config') }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        let :params do
          default_params
        end

        it_behaves_like 'postfixadmin shared examples'

        it { is_expected.not_to contain_class('postfixadmin::db') }
        it { is_expected.not_to contain_class('postfixadmin::vhost') }
        it { is_expected.not_to contain_class('postfixadmin::queries::postfix') }
        it { is_expected.not_to contain_class('postfixadmin::queries::dovecot') }
      end

      context 'with db' do
        let :params do
          default_params.merge(ensure_database: true)
        end

        it_behaves_like 'postfixadmin shared examples'

        it { is_expected.to contain_class('postfixadmin::db') }
        it { is_expected.not_to contain_class('postfixadmin::vhost') }
        it { is_expected.not_to contain_class('postfixadmin::queries::postfix') }
        it { is_expected.not_to contain_class('postfixadmin::queries::dovecot') }
      end

      # context 'with vhost' do
      #   let :params do
      #     default_params.merge( :ensure_vhost => true )
      #   end
      #   it_behaves_like 'postfixadmin shared examples'

      #   it { is_expected.to_not contain_class('postfixadmin::db') }
      #   it { is_expected.to contain_class('postfixadmin::vhost') }
      #   it { is_expected.to_not contain_class('postfixadmin::queries::postfix') }
      #   it { is_expected.to_not contain_class('postfixadmin::queries::dovecot') }
      # end

      context 'with postfix queries' do
        let :params do
          default_params.merge(ensure_postfix_queries: true)
        end

        it_behaves_like 'postfixadmin shared examples'

        it { is_expected.not_to contain_class('postfixadmin::db') }
        it { is_expected.not_to contain_class('postfixadmin::vhost') }
        it { is_expected.to contain_class('postfixadmin::queries::postfix') }
        it { is_expected.not_to contain_class('postfixadmin::queries::dovecot') }
      end

      context 'with dovecot queries' do
        let :params do
          default_params.merge(ensure_dovecot_queries: true)
        end

        it_behaves_like 'postfixadmin shared examples'

        it { is_expected.not_to contain_class('postfixadmin::db') }
        it { is_expected.not_to contain_class('postfixadmin::vhost') }
        it { is_expected.not_to contain_class('postfixadmin::queries::postfix') }
        it { is_expected.to contain_class('postfixadmin::queries::dovecot') }
      end
    end
  end
end
