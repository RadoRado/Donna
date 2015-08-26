require 'rake/testtask'
require 'sinatra/activerecord/rake'

namespace :db do
  task :load_config do
    require './app'
  end
end

namespace :test do
  desc 'Run tests on routes'

  task :routes do
    ENV['RACK_ENV'] = 'test'
    Rake::Task["db:drop"].invoke
    Rake::Task["db:migrate"].invoke
    ruby 'tests/routes/*_test.rb'
  end
end
