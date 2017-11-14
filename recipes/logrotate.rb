logrotate_app 'amazon-ssm-agent' do
  path %w(
    /var/log/amazon/ssm/amazon-ssm-agent.log
    /var/log/amazon/ssm/errors.log
  )
  rotate node['ssm_agent']['logrotate']['rotate']
  frequency node['ssm_agent']['logrotate']['frequency']
  options node['ssm_agent']['logrotate']['options'] if node['ssm_agent']['logrotate']['options']
  postrotate node['ssm_agent']['logrotate']['postrotate']
  template_mode '0644'
end
