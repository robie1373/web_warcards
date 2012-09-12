#!/usr/bin/env rake
require "bundler/gem_tasks"
require 'rake/testtask'
require 'bundler'
Bundler::GemHelper.install_tasks(opts = {:name => 'web_warcards_app'})

task :default => :spec

Rake::TestTask.new do |t|
  t.libs.push '.'
  t.test_files = FileList['spec/**/*_spec.rb']
  t.verbose    = true
end

  #:name => 'web_warcards_app' #install_tasks
