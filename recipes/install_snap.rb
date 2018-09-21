#
# Cookbook:: sturdy_ssm_agent
# Recipe:: install_snap
#
# Copyright:: 2018, Arvato Systems
# Copyright:: 2018, Patrick Robinson
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

package 'amazon-ssm-agent' do
  action :remove
end

execute 'snap install amazon-ssm-agent --classic' do
  not_if { ::Dir.exist?('/snap/amazon-ssm-agent') }
end

execute 'snap start --enable amazon-ssm-agent' do
  action :run
  not_if 'systemctl is-active --quiet snap.amazon-ssm-agent.amazon-ssm-agent.service'
end
