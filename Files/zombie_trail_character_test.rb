require 'test/unit'
require_relative "zombie_trail_classes/zt_player_class"

#Testing 4 parameters from the Character class
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
    #testing that exp adds correctly
    def test_exp_add
        @exp = @player.exp_add
        assert_equal(1, @exp)
    end
    #testing that hp subtracts by 1
    def test_hp_sub
        @hp = @player.hp_sub
        assert_equal(9, @hp)
    end
    #testing that hp adds by 1 correctly
    def test_hp_add
        @hp = @player.hp_add
        assert_equal(11, @hp)
    end
    #testing that player is living 
    def test_living
        @player.living
        assert_equal(10, @hp)
    end
end

# TODO Create other characters (e.g. Strong class, evasive class, etc)