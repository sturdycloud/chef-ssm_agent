#
# Cookbook:: sturdy_ssm_agent
# Recipe:: install
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

# Download the installer
# @since 0.1.0
remote_file 'amazon-ssm-agent' do
  path node['ssm_agent']['package']['path']
  source node['ssm_agent']['package']['url']
  checksum node['ssm_agent']['package']['checksum']
  mode 0644
end

# Install the package
# @since 0.1.0
package 'amazon-ssm-agent' do # ~FC109
  source node['ssm_agent']['package']['path']
  provider value_for_platform_family(
    'rhel' => Chef::Provider::Package::Yum,
    'suse' => Chef::Provider::Package::Zypper,
    'amazon' => Chef::Provider::Package::Yum,
    'debian' => Chef::Provider::Package::Dpkg,
    'windows' => Chef::Provider::Package::Windows
  )
end

# Ensure service state
# @since 0.1.0
service node['ssm_agent']['service']['name'] do
  provider Chef::Provider::Service::Upstart if node['platform'].include? 'amazon'
  action node['ssm_agent']['service']['actions']
end
