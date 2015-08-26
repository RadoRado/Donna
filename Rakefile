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
    ruby 'tests/routes/*_test.rb'
  end
end
