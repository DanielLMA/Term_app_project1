require "random-word"   #? puts RandomWord.adjs.next #practice random word
require "colorize"

require_relative "zombie_trail_modules/zt_destination_module"
require_relative "zombie_trail_classes/zt_player_class"

class Trail
  include Tavern #! next step try having all of inn in this ....so that exp and hp transfers over.

  def initialize
    @player = CharacterSpeedy.new
    # @player = CharacterRocky.new
    # @battle = Battle.new
    # introduction #!readd at end
    @trail_counter = 0
    @destination_counter = 0
    game_start
    game_middle
  end

  RandomEvent = [
    :smallzombie, :smallzombie, :item, #:walking, :walking, :walking
  ]

  def random_event
    RandomEvent.sample
  end

  def introduction #!readd at end
    "Welcome to Zombie Trail!\n".colorize(:black ).colorize( :background => :red).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
    sleep(0.3)
    "It is a most #{RandomWord.adjs.next} day for a #{RandomWord.adjs.next} stroll with zombies.".colorize(:white ).colorize( :background => :light_black).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
    sleep(0.3)
    "\nFirst thing's first. What is your name?".colorize(:white ).colorize( :background => :light_black).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
    sleep(0.1)
    puts "\n"
    name = gets.chomp
    "\nGreat, #{name}. Let's hit the trail...\n".colorize(:white ).colorize( :background => :light_black).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
    sleep(0.5)
  end

  # private #!
  def game_start
    while @trail_counter < 1
      trail_random_event = random_event
      trail_random_event
      sleep(1)
      @trail_counter += 1
      if trail_random_event == :smallzombie
        "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
        "\nYou encounter a #{RandomWord.adjs.next} zombie! \n".colorize(:green ).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
        sleep(0.7)
        @player.exp_add.zombie_attack
        sleep(0.7)
      elsif trail_random_event == :walking
        "--------------\n".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
        sleep(0.5)
        puts "You're walking".colorize(:blue )
        sleep(0.7)
        "--------------\n".colorize(:blue ).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
      else trail_random_event == :item
        "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
        "\nYou found an item!\n".colorize(:blue).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
        sleep (0.7)       
      end
      if @player.dead?
        "You died.".colorize(:black ).colorize( :background => :red).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
        sleep (1.0)
        break
      end
    end
    if @player.dead?
      skip
    else
      inn
    end
  end

  def game_middle
    if @player.dead?
      game_ending #!this will need to be a skip after add game_middle
    else
      "You're about to enter the Forbbiden Forest. Hope you brought your flashlight.\n".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
      sleep(1.0)
      #? while @player.living - This worked below to run only while player was living.
      while @trail_counter < 6
        #puts "\nOn the trail..." #!make this have more specs
        trail_random_event = random_event
        trail_random_event
        sleep(1)
        @trail_counter += 1
        if trail_random_event == :smallzombie
          "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
          "\nYou encounter a #{RandomWord.adjs.next} zombie! \n".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
          sleep(0.7)
          @player.exp_add.zombie_attack
          sleep(0.7)
        elsif trail_random_event == :walking
          "--------------\n".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
          sleep(0.5)
          puts "You're walking"
          sleep(0.7)
          "--------------\n".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
        else trail_random_event == :item
          "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
          "\nYou found an item!\n".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
          sleep (0.7)         
        end
        if @player.dead?
          "You died!".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
          sleep (1.0)
          break
        end
      end
      if @player.dead?
        skip
      else
        inn
      end
    end
  end

  def game_ending
    "Game Over\n".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
  end

  def skip #blank method to skip another method storyline
  end
end

Trail.new

