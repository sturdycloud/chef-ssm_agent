#
# Cookbook:: sturdy_ssm_agent
# Attributes:: default
#
# Copyright:: 2017, Sturdy Networks
# Copyright:: 2017, Jonathan Serafini
# Copyright:: 2020, Keith Gable
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

# Save repeating the same node attribute
service_name = node['ssm_agent']['service']['name']

# Amazon SSM Agent logrotation
# @since 0.1.0
default['ssm_agent']['logrotate'].tap do |config|
  config['rotate'] = 7
  config['frequency'] = 'daily'

  # Support systemd distros natively
  config['postrotate'] = if node['init_package'] == 'systemd'
                           "systemctl restart #{service_name}"
                         else
                           "service #{service_name} restart"
                         end
end
