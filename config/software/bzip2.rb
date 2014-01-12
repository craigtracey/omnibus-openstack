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
name    "bzip2"
version "1.0.6"
source  :url => "http://www.bzip.org/1.0.6/bzip2-1.0.6.tar.gz",
  :md5 => "00b516f4704d4a7cb50a1d97e6e8e15b"

relative_path "bzip2-#{version}"

build do
  command "make -f Makefile-libbz2_so"
  command "make install PREFIX=#{install_dir}/embedded"
end
