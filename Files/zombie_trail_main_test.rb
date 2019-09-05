require 'test/unit'
require_relative "zombie_trail_main"

class CustomerTest < Test::Unit::TestCase
    def test_add
        total = add(1,2)
        assert_equal(3, total)
      end
end