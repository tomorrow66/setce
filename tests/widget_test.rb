class WidgetTest < MiniTest::Unit::TestCase
  
  def test_made_by
    my_gadget = Widget.new
  	assert_equal my_gadget.made_by, 'Acme Corp.'
  end
  
end