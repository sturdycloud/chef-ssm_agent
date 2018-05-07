#
# Cookbook:: sturdy_ssm_agent
# Attributes:: default
#
# Copyright:: 2017, Sturdy Networks
# Copyright:: 2017, Jonathan Serafini
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

default['ssm_agent'].tap do |config|
  # Attempt to detect the current region from Ohai
  # @since 0.1.0
  if node['ec2'] && node['ec2']['region'] # Chef 13+
    config['region'] = node['ec2']['region']
  else
    aws_az = node.fetch('ec2', {}).fetch('placement_availability_zone', nil)
    config['region'] = aws_az ? aws_az[0..-2] : 'us-east-1'
  end

  # Version of the package to download and install
  # @since 0.1.0
  config['package']['version'] = 'latest'

  # Url from which to download the ssm agent
  # @since 0.1.0
  config['package']['url'] = format(
    'https://amazon-ssm-%s.s3.amazonaws.com/%s/%s/%s',
    config['region'],
    config['package']['version'],
    value_for_platform_family('rhel' => 'linux_amd64',
                              'suse' => 'linux_amd64',
                              'amazon' => 'linux_amd64',
                              'debian' => 'debian_amd64',
                              'windows' => 'windows_amd64'),
    value_for_platform_family('rhel' => 'amazon-ssm-agent.rpm',
                              'suse' => 'amazon-ssm-agent.rpm',
                              'amazon' => 'amazon-ssm-agent.rpm',
                              'debian' => 'amazon-ssm-agent.deb',
                              'windows' => 'AmazonSSMAgent.msi')
  )

  # Path where the package is downloaded to
  # @since 0.1.0
  config['package']['path'] = ::File.join(
    Chef::Config['file_cache_path'],
    value_for_platform_family('rhel' => 'amazon-ssm-agent.rpm',
                              'suse' => 'amazon-ssm-agent.rpm',
                              'amazon' => 'amazon-ssm-agent.rpm',
                              'debian' => 'amazon-ssm-agent.deb',
                              'windows' => 'AmazonSSMAgent.msi')
  )

  # Checksum of the package
  # * Note: This is currently disabled due to the URL be a /latest/
  # @since 0.1.0
  config['package']['checksum'] = nil
  # value_for_platform_family(
  #  'rhel' => '15d8c8e6b2ecef39c37b2bed5ed68f68a9b511ba30d8d4d1f1ba3f49' \
  #            'cfc70f0f',
  #  'debian' => 'a48ff0126e113ef0d5a534c911b269d172e6ae08003a8bcda9723f' \
  #              '5052f18e58'
  # )

  # Name of the agent service
  # @since 0.1.0
  config['service']['name'] = case node['platform_family'] == 'windows'
                              when true
                                'AmazonSSMAgent'
                              else
                                'amazon-ssm-agent'
                              end

  # Actions to set the agent to
  # * Note: We set this to disable / start to provide faster boot times
  # @since 0.1.0
  config['service']['actions'] = %w(enable start)
end
