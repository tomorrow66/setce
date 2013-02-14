namespace :log do

  desc 'Clears a log file'
  task :clear do
    if ENV['file']
      Log.clear ENV['file']
    else
      puts 'Please specify a log file to clear: rake log:clear file=messages'
    end
  end

end