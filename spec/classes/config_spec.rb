require 'spec_helper'

describe 'postfixadmin::config' do

  let :default_params do
      { :config_file => '/etc/postfixadmin/config.local.php',
        :configs     => {},
        :owner       => 'root',
        :group       => 'www-data',
        :mode        => '0640',
      }
  end

  shared_examples 'postfixadmin::config shared examples' do

    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_file( params[:config_file] )
        .with_owner( params[:owner] )
        .with_group( params[:group] )
        .with_mode( params[:mode] )
    }
  end

  context 'with defaults' do
    let :params do
      default_params
    end
    it_behaves_like 'postfixadmin::config shared examples'
  end

  context 'with non defaults' do
    let :params do
      default_params.merge(
        :config_file => '/tmp/test',
        :owner       => 'someone',
        :group       => 'somegroup',
        :mode        => '4242',
      )
    end
    it_behaves_like 'postfixadmin::config shared examples'
  end

end
