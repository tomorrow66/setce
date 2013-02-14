helpers do

  def active path
    path = Array[path] unless path.kind_of? Array
    match = false
    path.each {|p| match = true if request.path_info.include? p }
    'active' if match
  end

  def alert
    unless session[:alert].nil?
      msg = session[:alert]
      session[:alert] = nil
      "<div id='alert'>#{msg}</div>"
    end
  end

  def hidden
    'display: none;'
  end

end