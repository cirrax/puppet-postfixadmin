require 'spec_helper'

describe 'postfixadmin::install' do
  let :default_params do
    {  package_name: 'postfixadmin',
       package_ensure: 'installed',
       packages: [] }
  end

  shared_examples 'postfixadmin::install shared examples' do
    it { is_expected.to compile.with_all_deps }

    it {
      is_expected.to contain_package('postfix-admin')
        .with_name(params[:package_name])
        .with_ensure(params[:package_ensure])
    }

    it {
      params[:packages].each do |package|
        is_expected.to contain_package(package)
          .with_tag('postfixadmin-packages')
          .with_ensure(params[:package_ensure])
      end
    }
  end

  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      context 'with defaults' do
        let :params do
          default_params
        end

        it_behaves_like 'postfixadmin::install shared examples'
      end

      context 'with non defaults' do
        let :params do
          default_params.merge(
            package_name: 'somepackage',
            packages: ['additional', 'packages'],
          )
        end

        it_behaves_like 'postfixadmin::install shared examples'
      end
    end
  end
end
