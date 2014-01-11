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
name    "db"
version "5.3.21"

source  :url => "http://download.oracle.com/berkeley-db/db-#{version}.tar.gz",
  :md5 => "3fda0b004acdaa6fa350bfc41a3b95ca"

relative_path "db-#{version}/build_unix"

env = {
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
}

build do
  command "../dist/configure --enable-sql --prefix=#{install_dir}/embedded"
  command "make", :env => env
  command "make install"
end
