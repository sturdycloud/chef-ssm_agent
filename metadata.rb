name 'sturdy_ssm_agent'
maintainer 'Sturdy Networks'
maintainer_email 'devops@sturdy.cloud'
license 'Apache-2.0'
description 'Amazon EC2 Simple Systems Manager (SSM) agent'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
issues_url 'https://github.com/sturdycloud/sturdy_ssm_agent-cookbook/issues'
source_url 'https://github.com/sturdycloud/sturdy_ssm_agent-cookbook'
version '1.1.0'

chef_version '>= 12.1' if respond_to?(:chef_version)
%w(amazon redhat debian ubuntu suse).each do |p|
  supports p
end

depends 'logrotate'
