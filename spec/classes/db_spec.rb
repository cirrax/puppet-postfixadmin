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
     { :type   => 'mysql',
       :dbname => 'postfixadmin',
       :dbuser => 'postfixadmin',
       :dbpass => 'CHANGEME',
       :host   => 'localhost',
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
  end

end
