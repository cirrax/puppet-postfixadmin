require 'spec_helper'


describe 'postfixadmin::db' do
  let :facts do
    {
      :operatingsystemrelease => 'test',
      :osfamily               => 'Debian',
      :operatingsystem        => 'Debian',
      :lsbdistcodename        => 'Debian',
    }
  end

  let :default_params do
     { :dbtype       => 'mysql',
       :dbname       => 'postfixadmin',
       :dbuser       => 'postfixadmin',
       :dbpass       => 'CHANGEME',
       :host         => 'localhost',
       :dbconfig_inc => '/etc/postfixadmin/dbconfig.inc.php',
     }
  end

  shared_examples 'postfixadmin::db shared examples' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class( 'postfixadmin::db::mysql' )
    }
  end

  context 'with defaults' do
    let :params do
      default_params
    end

    it_behaves_like 'postfixadmin::db shared examples'
    it { is_expected.to contain_file( params[:dbconfig_inc] )
      .with_owner('root')
      .with_group('www-data')
      .with_mode('0640')
    }
  end

  context 'without dbconfig file' do
    let :params do
      default_params.merge(
        :dbconfig_inc => '',
      )
    end

    it_behaves_like 'postfixadmin::db shared examples'
    it { is_expected.to_not contain_file( '/etc/postfixadmin/dbconfig.inc.php' ) }
  end
end
