require 'spec_helper'

describe 'postfixadmin::cli::create_domain' do
  let :default_params do
     { :default_aliases => true,
     }
  end

  shared_examples 'postfixadmin::cli::create_domain shared examples' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class( 'postfixadmin::cli::params' ) }

    it { is_expected.to contain_exec( 'postfixadmin create_domain ' + params[:domain])
      .with_command(/ domain add /)
      .with_unless(/ domain view /)
    }
  end

  context 'with defaults' do
    let (:title) { 'mytitle.ch' }
    let :params do
      default_params.merge(
	:description => title,
	:domain      => title,
      )
    end
    it_behaves_like 'postfixadmin::cli::create_domain shared examples'

    it { is_expected.to contain_exec( 'postfixadmin create_domain ' + params[:domain])
      .with_command(/ --description 'mytitle.ch' /)
      .with_command(/ mytitle.ch /)
      .with_command(/ --default-aliases|/)
      .without_command(/--aliases/)
      .without_command(/--mailboxes/)
      .without_command(/--quota/)
      .without_command(/--maxquota/)
      .with_unless(/ mytitle.ch|/)
    }
  end

  context 'without default aliases' do
    let (:title) { 'mytitle.ch' }
    let :params do
      default_params.merge(
	:domain => title,
        :default_aliases => false,
      )
    end
    it_behaves_like 'postfixadmin::cli::create_domain shared examples'
    it { is_expected.to contain_exec( 'postfixadmin create_domain ' + params[:domain])
      .with_command(/ mytitle.ch /)
      .without_command(/--default-aliases/)
    }
  end

  context 'with non defaults' do
    let (:title) { 'mytitle.ch' }
    let :params do
      default_params.merge(
	:domain      => 'blah.ch',
	:description => 'Beschreibung',
      )
    end
    it_behaves_like 'postfixadmin::cli::create_domain shared examples'
    it { is_expected.to contain_exec( 'postfixadmin create_domain ' + params[:domain])
      .with_command(/ --description 'Beschreibung' /)
      .with_command(/ blah.ch /)
      .with_unless(/ blah.ch|/)
    }
  end

  context 'with quota etc' do
    let (:title) { 'mytitle.ch' }
    let :params do
      default_params.merge(
	:domain      => title,
	:description => title,
	:aliases     => 11,
	:mailboxes   => 22,
	:quota       => 33, 
	:maxquota    => 44,
      )
    end
    it_behaves_like 'postfixadmin::cli::create_domain shared examples'
    it { is_expected.to contain_exec( 'postfixadmin create_domain ' + params[:domain])
      .with_command(/ --aliases 11 /)
      .with_command(/ --mailboxes 22 /)
      .with_command(/ --quota 33 /)
      .with_command(/ --maxquota 44 /)
    }
  end
end
