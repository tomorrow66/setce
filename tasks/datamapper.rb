desc 'Builds the app from scratch'
task :build => ['dm:setup'] do
  exec 'rackup'
end

namespace :dm do

  desc 'Creates a new seeded database'
  task :setup => ['dm:migrate', 'dm:seed']

  desc 'Auto upgrades the database, non-descructive'
  task(:upgrade) { DataMapper.auto_upgrade! }

  desc 'Auto migrates the database, destructive'
  task(:migrate) { DataMapper.auto_migrate! }

  desc 'Seeds the database'
  task(:seed) { require "#{Dir.pwd}/data/seeds.rb" }

  desc 'Alters the data'
  task(:transmogrify) { require "#{Dir.pwd}/data/transmogrify.rb" }

end