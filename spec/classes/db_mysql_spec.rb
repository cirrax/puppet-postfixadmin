require 'spec_helper'

describe 'postfixadmin::db::mysql' do
  let(:pre_condition) { ['include mysql::params'] }

  let :default_params do
    { dbname: 'postfixadmin',
      dbuser: 'postfixadmin',
      dbpass: 'CHANGEME',
      host: 'localhost' }
  end

  shared_examples 'postfixadmin::db::mysql shared examples' do
    it { is_expected.to compile.with_all_deps }

    it {
      is_expected.to contain_mysql__db(params[:dbname])
        .with_user(params[:dbuser])
        .with_host(params[:host])
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        let :params do
          default_params
        end

        it_behaves_like 'postfixadmin::db::mysql shared examples'
      end

      context 'with non  defaults' do
        let :params do
          default_params.merge(
            dbname: 'mydb',
            dbuser: 'myuser',
            dbpass: 'secret-password',
            host: 'myhost',
          )
        end

        it_behaves_like 'postfixadmin::db::mysql shared examples'
      end
    end
  end
end
