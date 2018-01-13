require 'spec_helper'


describe 'postfixadmin::queries::postfix' do
  let :default_params do
     { :dbname                  => 'postfixadmin',
       :dbuser                  => 'postfixadmin',
       :dbpass                  => 'CHANGEME',
       :hosts                   => ['localhost'],
       :dir                     => '/etc/dovecot/postfixadmin',
       :owner                   => 'root',
       :group                   => 'root',
       :mode                    => '0640',
     }
  end

  shared_examples 'postfixadmin::queries::postfix shared examples' do
    it { is_expected.to compile.with_all_deps }

    it { is_expected.to contain_file( params[:dir] )
      .with_ensure( 'directory' )
      .with_owner( params[:owner] )
      .with_group( params[:group] )
      .with_mode( '0750' )
    }

    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_alias_domain_catchall_maps.cf')
      .with_owner( params[:owner] )
      .with_group( params[:group] )
      .with_mode( params[:mode] )
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_alias_domain_maps.cf')
      .with_owner( params[:owner] )
      .with_group( params[:group] )
      .with_mode( params[:mode] )
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_alias_maps.cf')
      .with_owner( params[:owner] )
      .with_group( params[:group] )
      .with_mode( params[:mode] )
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_mailbox_limit_maps.cf')
      .with_owner( params[:owner] )
      .with_group( params[:group] )
      .with_mode( params[:mode] )
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_domains_maps.cf')
      .with_owner( params[:owner] )
      .with_group( params[:group] )
      .with_mode( params[:mode] )
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_mailbox_maps.cf')
      .with_owner( params[:owner] )
      .with_group( params[:group] )
      .with_mode( params[:mode] )
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_alias_domain_mailbox_maps.cf')
      .with_owner( params[:owner] )
      .with_group( params[:group] )
      .with_mode( params[:mode] )
    }
  end

  context 'with defaults' do
    let :params do
      default_params
    end
    it_behaves_like 'postfixadmin::queries::postfix shared examples'
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_alias_domain_catchall_maps.cf')
      .with_content(/^dbname   = postfixadmin$/)
      .with_content(/^user     = postfixadmin$/)
      .with_content(/^password = CHANGEME$/)
      .with_content(/^hosts    = localhost$/)
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_alias_domain_maps.cf')
      .with_content(/^dbname   = postfixadmin$/)
      .with_content(/^user     = postfixadmin$/)
      .with_content(/^password = CHANGEME$/)
      .with_content(/^hosts    = localhost$/)
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_alias_maps.cf')
      .with_content(/^dbname   = postfixadmin$/)
      .with_content(/^user     = postfixadmin$/)
      .with_content(/^password = CHANGEME$/)
      .with_content(/^hosts    = localhost$/)
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_mailbox_limit_maps.cf')
      .with_content(/^dbname   = postfixadmin$/)
      .with_content(/^user     = postfixadmin$/)
      .with_content(/^password = CHANGEME$/)
      .with_content(/^hosts    = localhost$/)
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_domains_maps.cf')
      .with_content(/^dbname   = postfixadmin$/)
      .with_content(/^user     = postfixadmin$/)
      .with_content(/^password = CHANGEME$/)
      .with_content(/^hosts    = localhost$/)
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_mailbox_maps.cf')
      .with_content(/^dbname   = postfixadmin$/)
      .with_content(/^user     = postfixadmin$/)
      .with_content(/^password = CHANGEME$/)
      .with_content(/^hosts    = localhost$/)
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_alias_domain_mailbox_maps.cf')
      .with_content(/^dbname   = postfixadmin$/)
      .with_content(/^user     = postfixadmin$/)
      .with_content(/^password = CHANGEME$/)
      .with_content(/^hosts    = localhost$/)
    }
  end

  context 'with non dir+permissions' do
    let :params do
      default_params.merge(
       :dir   => '/tmp',
       :owner => 'someone',
       :group => 'somegroup',
       :mode  => '4242'
      )
    end
    it_behaves_like 'postfixadmin::queries::postfix shared examples'
  end

  context 'with non defaults DB' do
    let :params do
      default_params.merge(
       :dbname => 'mydb',
       :dbuser => 'myuser',
       :dbpass => 'secret-password',
       :hosts  => ['myhost'],
      )
    end
    it_behaves_like 'postfixadmin::queries::postfix shared examples'
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_alias_domain_catchall_maps.cf')
      .with_content(/^dbname   = mydb$/)
      .with_content(/^user     = myuser$/)
      .with_content(/^password = secret-password$/)
      .with_content(/^hosts    = myhost$/)
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_alias_domain_maps.cf')
      .with_content(/^dbname   = mydb$/)
      .with_content(/^user     = myuser$/)
      .with_content(/^password = secret-password$/)
      .with_content(/^hosts    = myhost$/)
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_alias_maps.cf')
      .with_content(/^dbname   = mydb$/)
      .with_content(/^user     = myuser$/)
      .with_content(/^password = secret-password$/)
      .with_content(/^hosts    = myhost$/)
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_mailbox_limit_maps.cf')
      .with_content(/^dbname   = mydb$/)
      .with_content(/^user     = myuser$/)
      .with_content(/^password = secret-password$/)
      .with_content(/^hosts    = myhost$/)
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_domains_maps.cf')
      .with_content(/^dbname   = mydb$/)
      .with_content(/^user     = myuser$/)
      .with_content(/^password = secret-password$/)
      .with_content(/^hosts    = myhost$/)
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_mailbox_maps.cf')
      .with_content(/^dbname   = mydb$/)
      .with_content(/^user     = myuser$/)
      .with_content(/^password = secret-password$/)
      .with_content(/^hosts    = myhost$/)
    }
    it { is_expected.to contain_file( params[:dir] + '/mysql_virtual_alias_domain_mailbox_maps.cf')
      .with_content(/^dbname   = mydb$/)
      .with_content(/^user     = myuser$/)
      .with_content(/^password = secret-password$/)
      .with_content(/^hosts    = myhost$/)
    }
  end
end
