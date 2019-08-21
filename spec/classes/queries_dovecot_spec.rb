require 'spec_helper'

describe 'postfixadmin::queries::dovecot' do
  let :default_params do
    { dbname: 'postfixadmin',
      dbuser: 'postfixadmin',
      dbpass: 'CHANGEME',
      host: 'localhost',
      mysql_flags: [],
      dir: '/etc/dovecot/postfixadmin',
      owner: 'root',
      group: 'root',
      mode: '0640',
      default_password_scheme: 'MD5-CRYPT',
      mboxpath: '',
      uid: '',
      gid: '',
      quota: true }
  end

  shared_examples 'postfixadmin::queries::dovecot shared examples' do
    it { is_expected.to compile.with_all_deps }

    it {
      is_expected.to contain_file(params[:dir])
        .with_ensure('directory')
        .with_owner(params[:owner])
        .with_group(params[:group])
        .with_mode('0750')
    }

    it {
      is_expected.to contain_file(params[:dir] + '/mysql_dovecot-sql.conf.ext')
        .with_owner(params[:owner])
        .with_group(params[:group])
        .with_mode(params[:mode])
    }

    it {
      is_expected.to contain_file(params[:dir] + '/mysql_dovecot-dict-quota.conf.ext')
        .with_owner(params[:owner])
        .with_group(params[:group])
        .with_mode(params[:mode])
    }
  end

  context 'with defaults' do
    let :params do
      default_params
    end

    it_behaves_like 'postfixadmin::queries::dovecot shared examples'

    it {
      is_expected.to contain_file(params[:dir] + '/mysql_dovecot-sql.conf.ext')
        .with_content(%r{dbname=postfixadmin})
        .with_content(%r{user=postfixadmin})
        .with_content(%r{password=CHANGEME})
        .with_content(%r{host=localhost})
    }
    it {
      is_expected.to contain_file(params[:dir] + '/mysql_dovecot-dict-quota.conf.ext')
        .with_content(%r{dbname=postfixadmin})
        .with_content(%r{user=postfixadmin})
        .with_content(%r{password=CHANGEME})
        .with_content(%r{host=localhost})
    }
  end

  context 'with non dir+permissions' do
    let :params do
      default_params.merge(
        dir: '/tmp',
        owner: 'someone',
        group: 'somegroup',
        mode: '4242',
      )
    end

    it_behaves_like 'postfixadmin::queries::dovecot shared examples'
  end

  context 'with non defaults DB' do
    let :params do
      default_params.merge(
        dbname: 'mydb',
        dbuser: 'myuser',
        dbpass: 'secret-password',
        host: 'myhost',
      )
    end

    it_behaves_like 'postfixadmin::queries::dovecot shared examples'
    it {
      is_expected.to contain_file(params[:dir] + '/mysql_dovecot-sql.conf.ext')
        .with_content(%r{dbname=mydb})
        .with_content(%r{user=myuser})
        .with_content(%r{password=secret-password})
        .with_content(%r{host=myhost})
    }
    it {
      is_expected.to contain_file(params[:dir] + '/mysql_dovecot-dict-quota.conf.ext')
        .with_content(%r{dbname=mydb})
        .with_content(%r{user=myuser})
        .with_content(%r{password=secret-password})
        .with_content(%r{host=myhost})
    }
  end
end
