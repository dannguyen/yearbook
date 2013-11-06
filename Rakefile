# encoding: utf-8
$:.unshift File.dirname(File.expand_path './lib', __FILE__)

require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "yearbook"
  gem.homepage = "http://github.com/dannguyen/yearbook"
  gem.license = "MIT"
  gem.summary = %Q{Easy face-cropping}
  gem.description = %Q{Easy face-cropping}
  gem.email = "dansonguyen@gmail.com"
  gem.authors = ["dannguyen"]
  gem.files.exclude 'spec/fixtures/images/*.jpg' # exclude temporary directory

  # dependencies defined in Gemfile
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec
