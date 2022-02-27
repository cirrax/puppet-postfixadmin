module Puppet::Parser::Functions
  newfunction(:postfixadmin_generate_pw, type: :rvalue, doc: <<-DOC) do |_args|
    @summary
    computes a random password string

    @return [String] a random password string
    DOC
    charset = (0..9).to_a + ('A'..'Z').to_a + ('a'..'z').to_a
    (0...10).map { charset.to_a[rand(charset.size)] }.join
  end
end
