#
# Copyright 2014, Craig Tracey <craigtracey@gmail.com>
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
name    "libdevicemapper"
default_version "2.02.98"

source  :url => "ftp://sources.redhat.com/pub/lvm2/LVM2.#{version}.tgz",
  :md5 => "1ce5b7f9981e1d02dfd1d3857c8d9fbe"

relative_path "LVM2.#{version}"

env = {
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
}

build do
  command "./configure --prefix=#{install_dir}/embedded"
  command "make install_device-mapper", :env => env
end
