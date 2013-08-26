# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omnibus-openstack/version'

Gem::Specification.new do |s|
  s.name        = 'omnibus-openstack'
  s.version     = OmnibusOpenstack::VERSION
  s.date        = '2013-08-13'
  s.description = "A full-stack packaging system for OpenStack"
  s.summary     = s.description
  s.authors     = ["Craig Tracey"]
  s.email       = 'craigtracey@gmail.com'
  s.homepage    = 'http://github.com/craigtracey/omnibus-openstack'
  s.license     = 'Apache 2.0'
  s.files       = Dir.glob("{bin,config,lib}/**/*")
  s.executables = ['omnibus-openstack']
  s.add_runtime_dependency 'omnibus'
end
