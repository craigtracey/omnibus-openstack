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
name    "numpy"
version "1.8.0"
source  :url => "http://downloads.sourceforge.net/project/numpy/NumPy/1.8.0/numpy-1.8.0.tar.gz",
  :md5 => "2a4b0423a758706d592abb6721ec8dcd"

#dependency "libxml2"
#dependency "libxslt"

relative_path "numpy-1.8.0"

env = {
#  "XML2_CONFIG" => "#{install_dir}/embedded/bin/xml2-config",
#  "XSLT_CONFIG" => "#{install_dir}/embedded/bin/xslt-config",
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
}

build do
  command ["#{install_dir}/embedded/bin/python",
    "setup.py",
    "build"].join(' '), :env => env
  command ["#{install_dir}/embedded/bin/python",
    "setup.py",
    "install"].join(' '), :env => env
end
