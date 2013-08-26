#
# Copyright:: Copyright (c) 2013 Craig Tracey <craigtracey@gmail.com>
# License:: Apache License, Version 2.0
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

require 'logger'
require 'omnibus'
require 'omnibus-openstack/version'
require 'omnibus-openstack/cli/base'
require 'omnibus-openstack/cli/build'
require 'pathname'

module OmnibusOpenstack
  module CLI
    class Application < Base

      def initialize(*args)
        super
      end

      register(Build, 'build', 'build', 'Build us some OpenStack.')
      tasks["build"].options = OmnibusOpenstack::CLI::Build.class_options

      class_option :debug,
        :aliases => [:d],
        :type => :boolean,
        :desc => "Enable debug logging"

      desc "version", "Display version information"
      def version
        say("OmnibusOpenstack: #{OmnibusOpenstack::VERSION}", :yellow)
      end

      def self.start(*args)
        begin
          super
        rescue => e
          error_msg = "Something bad just happened."
          error_msg << "\n\nError raised was:\n\n\t#{$!}"
          error_msg << "\n\nBacktrace:\n\n\t#{e.backtrace.join("\n\t")}"
          if e.respond_to?(:original) && e.original
            error_msg << "\n\nOriginal Error:\n\n\t#{e.original}"
            error_msg <<
              "\n\nOriginal Backtrace:\n\n\t#{e.original.backtrace.join("\n\t")}"
          end
          Thor::Base.shell.new.say(error_msg, :red)
          exit 1
        end
      end

    end
  end
end
