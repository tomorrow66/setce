module ScreenSizedDateTime

  def self.included base
    base.extend ClassMethods
  end

  module ClassMethods
    def from_fields year, month, day
      Chronic.parse("#{year}-#{month}-#{day}")
    end
  end

  def display format = :date
    case format
    when :date
      string = "%A %b %d, %Y"
    when :day
      string = "%b %d, %Y"
    when :day_with_time
      string = "%b %d, %Y at %I:%M%P"
    when :american_day
      string = "%m/%d/%y"
    end
    self.strftime string
  end

  def to_fields field
    date_field = ""

    date_field << "<select name='#{field}_month' id='#{field}_month'>"
    (1..12).each do |m|
      date_field << "<option value='#{m}' #{'selected' if m == self.strftime('%m').to_i}>#{m}</option>"
    end
    date_field << "</select>"

    date_field << "<select name='#{field}_day' id='#{field}_day'>"
    (1..31).each do |d|
      date_field << "<option value='#{d}' #{'selected' if d == self.strftime('%d').to_i}>#{d}</option>"
    end
    date_field << "</select>"

    date_field << "<select name='#{field}_year' id='#{field}_year'>"
    (2007..Chronic.parse('3 years from now').strftime('%Y').to_i).each do |y|
      date_field << "<option value='#{y}' #{'selected' if y == self.strftime('%Y').to_i}>#{y}</option>"
    end
    date_field << "</select>"

    date_field
  end

end

Date.class_eval     { include ScreenSizedDateTime }
DateTime.class_eval { include ScreenSizedDateTime }
Time.class_eval     { include ScreenSizedDateTime }