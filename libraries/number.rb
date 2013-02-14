module ScreenSizedNum

  def dollarize
    num = self
    "$%.2f" % num.to_f
  end

  def even?
    self%2 == 0
  end

  def odd?
    self%2 != 0
  end

  def truncate_to_decimal dec = 1
    num = self
    rounded = "%.#{dec}f" % num.to_f
    rounded = rounded.to_s.split('.').first if rounded.to_s.end_with?('0')
    rounded.to_f
  end

end

Fixnum.class_eval { include ScreenSizedNum }
Float.class_eval  { include ScreenSizedNum }