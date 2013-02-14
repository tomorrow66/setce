MOBILE_USER_AGENT_PATTERNS = [
  /iPhone/,
  /Android.*AppleWebKit/
]

helpers do

  def mobile_request?
    MOBILE_USER_AGENT_PATTERNS.any? {|r| request.env['HTTP_USER_AGENT'] =~ r}
  end

  def mobile_file file
    if File.exists?("#{settings.views}/#{file}#{@device}.html")
      view_file = "#{file}#{@device}"
    else
      view_file = file
    end
  end

  def view view_file, options = { layout: 'layout', locals: {} }
    unless options[:layout] || options[:layout] == false
      options[:layout] = 'layout'
    end
    
    if options[:layout] == false
      layout = false
    else 
      layout = mobile_file(options[:layout]).to_sym
    end
    
    erb mobile_file(view_file).to_sym, layout: layout, locals: options[:locals]
  end

end

before do
  mobile_request? ? @device = '.mobile' : @device = ''
end