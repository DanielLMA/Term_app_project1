require 'test/unit'
require_relative "zombie_trail_classes/zt_player_class"

class CharacterSpeedyTest < Test::Unit::TestCase
    def setup
        @player = CharacterSpeedy.new
        @d = 0
        @o = 0
        @a = 1
        @hp = 10
        @exp = 0
        @items_bag = ["rusty razor"]
        @leaching = false
    end
    def test_exp_add
        @exp = @player.exp_add
        assert_equal(1, @exp)
    end
    def test_hp_sub
        @hp = @player.hp_sub
        assert_equal(9, @hp)
    end
    def test_hp_add
        @hp = @player.hp_add
        assert_equal(11, @hp)
    end
    def test_living
        @player.living
        assert_equal(10, @hp)
    end
end

