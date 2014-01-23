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
name "openstack-common-python"

env = {
  "CFLAGS"  => ["-I#{install_dir}/embedded/include",
                "-I#{install_dir}/embedded/include/libxml2",
                "-I#{install_dir}/embedded/include/libxslt"].join(" "),
  "LDFLAGS" => "-L#{install_dir}/embedded/lib",
  "PATH"    => "#{install_dir}/embedded/bin:#{ENV["PATH"]}"
}

build do
  command "#{install_dir}/embedded/bin/pip install distribute --upgrade", :env => env
  command "#{install_dir}/embedded/bin/pip install virtualenv", :env => env
  command "#{install_dir}/embedded/bin/pip install pbr", :env => env
  command "#{install_dir}/embedded/bin/pip install d2to1", :env => env
  command "#{install_dir}/embedded/bin/pip install bz2file", :env => env
  command "#{install_dir}/embedded/bin/pip install mysql-python", :env => env
  command "#{install_dir}/embedded/bin/pip install pysqlite", :env => env
  command "#{install_dir}/embedded/bin/pip install python-memcached", :env => env
  command "#{install_dir}/embedded/bin/pip install bz2file", :env => env
  command "#{install_dir}/embedded/bin/pip install numpy", :env => env
end
