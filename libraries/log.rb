module Log

  def self.message msg
    File.open('log/messages.log', 'a+') { |f| f.write("\n#{msg}\n") }
  end

  def self.write_errors request
    if env['sinatra.error']
      File.open("log/#{ENV['RACK_ENV']}.log", 'a+') do |f|
        f.write("\n#{ENV['sinatra.error']}\n")
        f.write("  #{Time.now} #{ENV['SERVER_PROTOCOL']} #{request.port} #{request.request_method} #{request.url}\n")
      end
    end
  end

  def self.write_requests_and_errors request
    File.open("log/#{ENV['RACK_ENV']}.log", 'a+') do |f|
      f.write("\n#{ENV['sinatra.error']}\n") if ENV['sinatra.error']
      f.write("  #{Time.now} #{ENV['SERVER_PROTOCOL']} #{request.port} #{request.request_method} #{request.url}\n")
      f.write("\n") if ENV['sinatra.error']
    end
  end

  def self.clear file
    if File.exists? "log/#{file}.log"
      File.delete "log/#{file}.log"
      File.open "log/#{file}.log", 'w+'
    end
  end

end