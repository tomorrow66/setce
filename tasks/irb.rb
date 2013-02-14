desc 'Loads the application into an IRB session'
task :irb do
  require 'irb'
  ARGV.clear
  IRB.start
end