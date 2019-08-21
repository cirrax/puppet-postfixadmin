require 'spec_helper'

describe 'postfixadmin::domain' do
  let :default_params do
    { target_domain: '',
      cli_parameters: {} }
  end

  shared_examples 'postfixadmin::domain shared examples' do
    it { is_expected.to compile.with_all_deps }
  end
  context 'with defaults' do
    let(:title) { 'mytitle.ch' }
    let :params do
      default_params
    end

    it_behaves_like 'postfixadmin::domain shared examples'

    it { is_expected.to contain_postfixadmin__cli__create_domain('mytitle.ch') }
    it { is_expected.not_to contain_postfixadmin__cli__create_aliasdomain('mytitle.ch') }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        let(:title) { 'mytitle.ch' }
        let :params do
          default_params.merge(
            target_domain: 'mytarget.ch',
          )
        end

        it_behaves_like 'postfixadmin::domain shared examples'

        it { is_expected.to contain_postfixadmin__cli__create_aliasdomain('mytitle.ch') }
        it { is_expected.not_to contain_postfixadmin__cli__create_aliasdomain('mytarget.ch') }
        it { is_expected.not_to contain_postfixadmin__cli__create_domain('myttitle.ch') }
        it { is_expected.not_to contain_postfixadmin__cli__create_domain('mytarget.ch') }
      end
    end
  end
end
