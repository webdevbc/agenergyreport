require 'test_helper'

class CountyTest < ActiveSupport::TestCase

  test "should not save county without content" do
    county = County.new
    assert_not county.save, "Saved the county without any name, state, etc."
  end
    
end
