require 'spec_helper'


describe 'postfixadmin::cli::create_admin' do
  let :default_params do
     { :admin      => 'mytitle',
       :password   => '',
       :superadmin => false,
     }
  end

  shared_examples 'postfixadmin::cli::create_admin shared examples' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class( 'postfixadmin::cli::params' ) }

    it { is_expected.to contain_exec( 'postfixadmin create_admin ' + params[:admin])
      .with_command(/ admin add /)
      .with_unless(/ admin view /)
    }
  end

  context 'with defaults' do
    let (:title) { 'mytitle' }
    let :params do
      default_params
    end
    it_behaves_like 'postfixadmin::cli::create_admin shared examples'

    it { is_expected.to contain_exec( 'postfixadmin create_admin ' + params[:admin])
      .with_command(/ mytitle /)
      .without_command(/--superadmin/)
      .with_unless(/ mytitle|/)
    }
  end

  context 'with non defaults' do
    let (:title) { 'mytitle' }
    let :params do
      default_params.merge(
	:admin    => 'someotheradmin',
	:password => 'secret',
      )
    end
    it_behaves_like 'postfixadmin::cli::create_admin shared examples'
    it { is_expected.to contain_exec( 'postfixadmin create_admin ' + params[:admin])
      .with_command(/ someotheradmin /)
      .with_command(/ --password secret --password2 secret/)
      .with_unless(/ someotheradmin|/)
    }
  end

  context 'with superadmin' do
    let (:title) { 'mytitle' }
    let :params do
      default_params.merge(
	:superadmin    => true,
      )
    end
    it_behaves_like 'postfixadmin::cli::create_admin shared examples'

    it { is_expected.to contain_exec( 'postfixadmin create_admin ' + params[:admin])
      .with_command(/--superadmin/)
    }
  end

end

