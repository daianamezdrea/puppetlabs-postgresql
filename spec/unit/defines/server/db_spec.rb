# frozen_string_literal: true

require 'spec_helper'

describe 'postgresql::server::db', type: :define do
  let :facts do
    {
      os: {
        family: 'Debian',
        name: 'Debian',
        release: { 'full' => '8.0', 'major' => '8' },
      },
      kernel: 'Linux',
      id: 'root',
      path: '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin',
    }
  end

  let :title do
    'test'
  end

  context 'without dbname param' do
    let :params do
      {
        user: 'test',
        password: 'test',
        owner: 'tester',
      }
    end

    let :pre_condition do
      "class {'postgresql::server':}"
    end

    it { is_expected.to contain_postgresql__server__db('test') }
    it { is_expected.to contain_postgresql__server__database('test').with_owner('tester') }
    it { is_expected.to contain_postgresql__server__role('test').that_comes_before('Postgresql::Server::Database[test]') }
    it { is_expected.to contain_postgresql__server__database_grant('GRANT test - ALL - test') }
  end

  context 'dbname' do
    let :params do
      {
        dbname: 'testtest',
        user: 'test',
        password: 'test',
        owner: 'tester',
      }
    end

    let :pre_condition do
      "class {'postgresql::server':}"
    end

    it { is_expected.to contain_postgresql__server__database('testtest') }
  end
end
