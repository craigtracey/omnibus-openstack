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
name    "libffi"
version "3.0.13"

source  :url => "ftp://sourceware.org/pub/libffi/libffi-3.0.13.tar.gz"
  :md5 => "45f3b6dbc9ee7c7dfbbbc5feba571529"

relative_path "libffi-#{version}"

env = {
  "LD_RUN_PATH" => "#{install_dir}/embedded/lib",
}

build do
  command "./configure --prefix=#{install_dir}/embedded"
  command "make", :env => env
  command "make install"
end
