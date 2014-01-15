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

### THIS IS A GENERIC PYTHON VIRTUALENV BUILDING CONFIG!!! ###

version "master"
source  :git => "https://github.com/openstack/#{name}.git"

relative_path "#{name}"

env = {
  "PYTHONPATH"      => "#{install_dir}/embedded/lib/python2.7/site-packages",
  "LD_LIBRARY_PATH" => "#{install_dir}/embedded/lib"
}

build do
  command ["#{install_dir}/embedded/bin/virtualenv",
    "-p #{install_dir}/embedded/bin/python",
    "/opt/openstack/#{name}",
    "--system-site-packages"].join(" "), :env => env
  command "#{install_dir}/#{name}/bin/python setup.py install", :env => env
end
