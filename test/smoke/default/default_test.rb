# # encoding: utf-8

# Inspec test for recipe vault_chef::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/


describe user('vault'), :skip do
  it { should exist }
end

describe group('vault'), :skip do
  it { should exist }
end

describe http('http://10.0.10.10:8200/v1/sys/health') do
  its('status') { should cmp 501 }
  its('body') { should match '"initialized":false.*' }
end

describe systemd_service('vault') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end
