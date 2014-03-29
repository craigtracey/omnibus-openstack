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

require 'omnibus'
require 'omnibus-openstack/cli/base'
require 'pathname'
require 'yaml'

module OmnibusOpenstack
  module CLI
    class Build < Base

      namespace :default

      desc "build", "Build us some OpenStack"
      option :manifest,
        :aliases => [:m],
        :type => :string,
        :default => nil,
        :required => true,
        :desc => "Manifest file to use"
      option :name,
        :aliases => [:n],
        :type => :string,
        :default => nil,
        :required => false,
        :desc => "Package name"
      option :install_path,
        :aliases => [:i],
        :type => :string,
        :default => nil,
        :required => false,
        :desc => "Install path"
      option :description,
        :aliases => [:d],
        :type => :string,
        :default => nil,
        :required => false,
        :desc => "Package description"
      option :version,
        :aliases => [:v],
        :type => :string,
        :default => nil,
        :desc => "Version for the resulting artifacts"
      option :cachedir,
        :aliases => [:c],
        :type => :string,
        :default => ".cache",
        :desc => "Directory to cache build elements to."
      def build()

        manifest = YAML.load_file((options[:manifest]))
        openstack_projects = manifest.keys

        if openstack_projects.empty?
          say("Manifest does not include any OpenStack projects to build", :yellow)
        end

        say("Let's start building #{openstack_projects.join(', ')}", :green)

        say("Caching to: #{options[:cachedir]}", :green)
        Omnibus::Config.cache_dir = File.join(options[:cachedir], "cache")
        Omnibus::Config.source_dir = File.join(options[:cachedir], "source")
        Omnibus::Config.build_dir = File.join(options[:cachedir], "build")
        Omnibus::Config.package_dir = File.join(options[:cachedir], "package")

        Omnibus::Config.project_root = project_root
        Omnibus.configure

        build_version = options[:version] || Omnibus::BuildVersion.new.semver

        project_files = Omnibus.project_files
        proj = Omnibus.project("openstack")
        proj.install_path(options[:install_path]) if !options[:install_path].nil?
        proj.package_name(options[:name]) if !options[:name].nil?
        proj.package_description(options[:description]) if !options[:description].nil?
        proj.build_version(build_version)

        os_projfile_name = File.join(project_root, "config/software/openstack-project.rb")
        os_projfile = Omnibus.software_map([os_projfile_name])["openstack-project"]

        openstack_projects.each do |osproject|

          project_data = manifest[osproject]
          override_ver = {}
          override_ver[osproject] = project_data['version'] if project_data.has_key?('version')

          dep_software = Omnibus::Software.load(os_projfile, proj, override_ver, osproject)
          dep_software.source({:git => project_data['source']['git']}) if project_data.has_key?('source')

          proj.library.component_added(dep_software)
          proj.dependency(osproject)
        end
        proj.build_me

      end
      default_task "build"

      no_commands {
        def parse_options_list(list)
          if list and !list.empty?
            list.split(',').map(&:strip)
          else
            nil
          end
        end

        def project_root()
          if spec = Gem::Specification.find_all_by_name('omnibus-openstack').first
            Pathname.new(spec.gem_dir)
          else
            Dir.getwd
          end
        end
      }

    end
  end
end
