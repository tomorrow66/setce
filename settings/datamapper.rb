configure :development do

  # Shows DataMapper queries alongside page requests:
  # DataMapper::Logger.new $stdout, :debug

  # Memory
  # DataMapper.setup :default, 'sqlite::memory:'

  # SQLite
  DataMapper.setup :default, "sqlite://#{Dir.pwd}/data/development.sqlite3"

  # MySQL
  # DataMapper.setup :default, 'mysql://username:password@host_url/database_name:port'

  # PostreSQL
  # DataMapper.setup :default, 'postgres://username:password@host_url/database_name:port'

end



configure :production do

  # Shows DataMapper queries alongside page requests:
  # DataMapper::Logger.new $stdout, :debug

  # Memory
  # DataMapper.setup :default, 'sqlite::memory:'

  # SQLite
  DataMapper.setup :default, "sqlite://#{Dir.pwd}/data/development.sqlite3"

  # MySQL
  # DataMapper.setup :default, 'mysql://username:password@host_url/database_name:port'

  # PostgreSQL
  # DataMapper.setup :default, 'postgres://username:password@host_url/database_name:port'

end