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
name    "libsqlite"
version "3080200"

source  :url => "http://www.sqlite.org/2013/sqlite-autoconf-#{version}.tar.gz",
  :md5 => "f62206713e6a08d4ccbc60b1fd712a1a"

relative_path "sqlite-autoconf-#{version}"

env = {
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
}

build do
  command "./configure --prefix=#{install_dir}/embedded"
  command "make", :env => env
  command "make install"
end
