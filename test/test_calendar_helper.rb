require 'test/unit'
require File.expand_path(File.dirname(__FILE__) + "/../lib/calendar_helper")

class CalendarHelperTest < Test::Unit::TestCase

  include CalendarHelper
  
  
  def test_simple
    assert_match %r{August}, calendar_with_defaults
  end


  def test_required_fields
    assert_raises(ArgumentError) {
      calendar
    }
    assert_raises(ArgumentError) {
      calendar :year => 1
    }
    assert_raises(ArgumentError) {
      calendar :month => 1
    }    
  end


  def test_css_classes
    # Sending these fields should change the CSS class applied in the output
    # :other_month_class is not implemented yet
    [:table_class, :month_name_class, :day_name_class, :day_class].each do |key|
      assert_css_class_for_key key.to_s, key
    end
  end

  
  def test_abbrev
    assert_match %r{>Mon<}, calendar_with_defaults(:abbrev => (0..2))
    assert_match %r{>M<}, calendar_with_defaults(:abbrev => (0..0))
    assert_match %r{>Monday<}, calendar_with_defaults(:abbrev => (0..-1))
  end


  def test_block
    # Even days are special
    assert_match %r{class="special_day">2<}, calendar(:year => 2006, :month => 8) { |d|
      if d.mday % 2 == 0
        [d.mday, {:class => 'special_day'}]
      end
    }
  end


private


  def assert_css_class_for_key(css_class, key)
    assert_match %r{class="#{css_class}"}, calendar_with_defaults(key => css_class)
  end


  def calendar_with_defaults(options={})
    options = { :year => 2006, :month => 8 }.merge options
    calendar options
  end

end
