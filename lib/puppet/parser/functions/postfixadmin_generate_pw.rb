module Puppet::Parser::Functions
  newfunction(:postfixadmin_generate_pw, :type => :rvalue) do |args|
    # computes a random password string
    charset = (0..9).to_a + ('A'..'z').to_a
    (0...10).map{ charset.to_a[rand(charset.size)] }.join
  end
end
