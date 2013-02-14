String.class_eval do

  def titleize
    title = ''
    self.split(' ').each {|s| title << s.capitalize + ' ' }
    title
  end

  def truncate word_count = 100, end_string = '...'
    return if self == nil
    words = self.split()
    words[0..(word_count-1)].join(' ') + (words.length > word_count ? end_string : '')
  end

end