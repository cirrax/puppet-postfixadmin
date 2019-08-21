require 'spec_helper'

describe 'postfixadmin::cli::create_aliasdomain' do
  let :default_params do
    { domain: 'mytitle.ch',
      create_domain: true }
  end

  shared_examples 'postfixadmin::cli::create_aliasdomain shared examples' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_class('postfixadmin::cli::params') }

    it {
      is_expected.to contain_exec('postfixadmin create_aliasdomain ' + params[:domain])
        .with_command(%r{ aliasdomain add })
        .with_unless(%r{ aliasdomain view })
    }
  end

  context 'with defaults' do
    let(:title) { 'mytitle.ch' }
    let :params do
      default_params.merge(
        target_domain: 'mytarget.ch',
      )
    end

    it_behaves_like 'postfixadmin::cli::create_aliasdomain shared examples'

    it {
      is_expected.to contain_exec('postfixadmin create_aliasdomain ' + params[:domain])
        .with_command(%r{ mytitle.ch })
        .with_command(%r{ --target-domain mytarget.ch })
        .with_unless(%r{ mytitle.ch|})
    }

    it {
      is_expected.to contain_postfixadmin__cli__create_domain('mytitle.ch')
        .with_default_aliases(false)
    }
  end

  context 'with non defaults' do
    let(:title) { 'mytitle' }
    let :params do
      default_params.merge(
        domain: 'somewhere.ch',
        target_domain: 'mytarget.ch',
      )
    end

    it_behaves_like 'postfixadmin::cli::create_aliasdomain shared examples'

    it {
      is_expected.to contain_exec('postfixadmin create_aliasdomain ' + params[:domain])
        .with_command(%r{ somewhere.ch })
        .with_command(%r{ --target-domain mytarget.ch })
        .with_unless(%r{ somewhere.ch|})
    }
  end

  context 'with no create domain' do
    let(:title) { 'mytitle.ch' }
    let :params do
      default_params.merge(
        target_domain: 'mytarget.ch',
        create_domain: false,
      )
    end

    it_behaves_like 'postfixadmin::cli::create_aliasdomain shared examples'

    it {
      is_expected.not_to contain_postfixadmin__cli__create_domain('mytitle.ch')
    }
  end
end
