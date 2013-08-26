#
# Copyright 2013, Craig Tracey <craigtracey@gmail.com>
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
#
name    "glance"
version "0f3f716c5a415e5d52262f0d7a577aa13b114aef"
source  :git => "https://github.com/openstack/glance.git"

relative_path "glance"

env = {
  "PYTHONPATH"      => "#{install_dir}/../common/embedded/lib/ptyhon2.7/site-packages",
  "LD_LIBRARY_PATH" => "#{install_dir}/../common/embedded/lib"
}

build do
  command ["#{install_dir}/../common/embedded/bin/virtualenv",
    "-p #{install_dir}/../common/embedded/bin/python",
    "/opt/openstack/#{name}",
    "--system-site-packages"].join(" "), :env => env
  command "#{install_dir}/bin/python setup.py install", :env => env
end
