default['ssm_agent'].tap do |config|
  # Attempt to detect the current region from Ohai
  # @since 0.1.0
  aws_az = node.fetch('ec2', {}).fetch('placement_availability_zone')
  config['region'] = aws_az ? aws_az[0..-2] : 'us-east-1'

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
                              'amazon' => 'linux_amd64',
                              'debian' => 'debian_amd64'),
    value_for_platform_family('rhel' => 'amazon-ssm-agent.rpm',
                              'amazon' => 'amazon-ssm-agent.rpm',
                              'debian' => 'amazon-ssm-agent.deb')
  )

  # Path where the package is downloaded to
  # @since 0.1.0
  config['package']['path'] = ::File.join(
    Chef::Config['file_cache_path'],
    value_for_platform_family('rhel' => 'amazon-ssm-agent.rpm',
                              'amazon' => 'amazon-ssm-agent.rpm',
                              'debian' => 'amazon-ssm-agent.deb')
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
  config['service']['name'] = 'amazon-ssm-agent'

  # Actions to set the agent to
  # * Note: We set this to disable / start to provide faster boot times
  # @since 0.1.0
  config['service']['actions'] = %w(disable start)
end
