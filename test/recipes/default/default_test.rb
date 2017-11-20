# # encoding: utf-8

# Inspec test for recipe sturdy_ssm_agent::default

# The Inspec reference, with examples and extensive documentation, can be
# found at https://docs.chef.io/inspec_reference.html

describe service('amazon-ssm-agent') do
  it { should be_running }
end
