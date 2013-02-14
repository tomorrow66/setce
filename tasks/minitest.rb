desc 'Run MiniTest on /tests'
task :minitest do
  require 'minitest/autorun'
  unless ENV['file']
    Dir["./tests/**/*.rb"].each {|file| require file}
  else
    if File.exists? "./tests/#{ENV['file']}.rb"
      require "./tests/#{ENV['file']}.rb"
    else
      puts ''
      puts 'I can\'t find that test. Maybe there\'s a typ0?'
      puts ''
    end
  end
end