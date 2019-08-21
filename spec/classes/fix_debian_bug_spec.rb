require 'spec_helper'

describe 'postfixadmin::fix_debian_bug' do
  it { is_expected.to compile.with_all_deps }
end
