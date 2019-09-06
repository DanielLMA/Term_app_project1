require "random-word"   
require "colorize"
require 'io/console' 

require_relative "zombie_trail_modules/zt_destination_module"
require_relative "zombie_trail_classes/zt_player_class"
require_relative "zombie_trail_modules/zt_art"

#class that is run to start the trail. Methods called in the initializer are the parts of the game. 
class Trail
  include Destination
  include Art

  #initializing where the game play is run.
  def initialize
    @player = CharacterSpeedy.new
    @trail_counter = 0
    @destination_counter = 0
    @name = nil
    @characters = {
      Bob: "Hey there, stranger. Coming into this #{RandomWord.adjs.next} part of town. You better beat it before it.\n",
      Bertha: "I seemed to have lost my #{RandomWord.nouns.next}. I reckon a #{RandomWord.nouns.next} came and stole it.\n",
      Dr_Important: "People around here are a little #{RandomWord.adjs.next}.\n"
    }
    #five methods called to run my program.
    start_screen
    introduction
    game_start
    game_middle
    game_final
  end

  #method from gem that continues after any key is pressed
  def continue_story                                                                                                     
    #puts "Press any key to continue"
    STDIN.getch                                                                                                              
    puts "                         \r" # extra space to overwrite in case next sentence is short                                                                                                              
  end       

  #First method initialized for storyline 
  def introduction   
    "Welcome to Zombie Trail!\n".colorize(:black).colorize(:background => :red).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
    sleep(0.3)
    "It is a most #{RandomWord.adjs.next} day for a #{RandomWord.adjs.next} stroll with zombies.".colorize(:white).colorize(:background => :light_black).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
    sleep(0.3)
    ""
    "\nFirst thing's first. What is your name?".colorize(:white).colorize(:background => :light_black).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
    sleep(0.1)
    puts "\n"
    @name = gets.chomp
    "\nGreat, #{@name}. Let's hit the trail...\n".colorize(:white).colorize(:background => :light_black).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
    sleep(0.5)
  end

  #array for events in first part of trail
  Lvl1_RandomEvent = [
    :item, :smallzombie, :smallzombie, :walking, :walking
  ]
  #method to pull random value from above array
  def lvl1_random_event
    Lvl1_RandomEvent.sample
  end

  #First trail run in storyline 
  def game_start
    while @trail_counter < 5 #counter to decide length of the trail. 
      lvl1_trail_random_event = lvl1_random_event
      lvl1_trail_random_event
      sleep(1)
      @trail_counter += 1
      if lvl1_trail_random_event == :smallzombie
        "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
        "\nYou encounter a #{RandomWord.adjs.next} zombie! \n".colorize(:green).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
        sleep(0.7)
        @player.exp_add.zombie_attack #call method from player class to add exp and initiate zombie_attack method
        sleep(0.7)
      elsif lvl1_trail_random_event == :walking
        "--------------\n".colorize(:blue).each_char { |c| putc c; $stdout.flush; sleep 0.02 }
        sleep(0.5)
        puts "You're walking".colorize(:blue)
        sleep(0.7)
        "--------------\n".colorize(:blue).each_char { |c| putc c; $stdout.flush; sleep 0.02 }
      else lvl1_trail_random_event == :item
        "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
        "\nYou found an item!\n".colorize(:blue).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
        sleep(0.5)
        @player.add_random_item #call method from player class to add a random item to an array 
        sleep (0.7)       
      end
      if @player.dead?
        "You died.".colorize(:black).colorize(:background => :red).each_char { |c| putc c; $stdout.flush; sleep 0.1 }
        sleep (1.0)
        break
      end
    end
    if @player.dead?
      skip
    else
      destination
    end
  end

  Lvl2_RandomEvent = [
    :item, :running, :running, :smallzombie, :largezombie, :lost 
  ]

  def lvl2_random_event
    Lvl2_RandomEvent.sample
  end

  #Second trail storyline
  def game_middle
    if @player.dead?
      skip
    else
      "You're about to enter the Forbbiden Forest. Hope you brought your flashlight.\n".colorize(:light_green).colorize(:background => :blue).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
      sleep(1.0)
      while @trail_counter < 10
        lvl2_trail_random_event = lvl2_random_event
        lvl2_trail_random_event
        sleep(1)
        @trail_counter += 1
        if lvl2_trail_random_event == :smallzombie
          "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
          "\nYou encounter a #{RandomWord.adjs.next} zombie! \n".colorize(:light_red).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
          sleep(0.7)
          @player.exp_add.zombie_attack
          sleep(0.7)
        elsif lvl2_trail_random_event == :running
          "---------------\n".colorize(:light_red).each_char { |c| putc c; $stdout.flush; sleep 0.02 }
          sleep(0.4)
          puts "You're running!".colorize(:light_red)
          sleep(0.4)
          "---------------\n".colorize(:light_red).each_char { |c| putc c; $stdout.flush; sleep 0.02 }
        elsif lvl2_trail_random_event == :item
          "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
          "\nYou found an item!\n".colorize(:blue).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
          sleep(0.5)
          @player.add_random_item
          sleep (0.7)
        elsif lvl2_trail_random_event == :lost 
          if @player.check_for_item("flashlight")
            "Your flashlight is coming in handy.\n".colorize(:blue).each_char { |c| putc c; $stdout.flush; sleep 0.02 }
          else 
            "You don't have a flashlight! You've lost the path...\n".colorize(:blue).each_char { |c| putc c; $stdout.flush; sleep 0.02 }
            @trail_counter = 0
          end
        else lvl2_trail_random_event == :largezombie
          "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
          "\nYou encounter a #{RandomWord.adjs.next} LARGE ZOMBIE! \n".colorize(:yellow).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
          sleep(0.7)
          @player.exp_add.zombie_attack
          "LARGE ZOMBIE won't leave you alone!\n".colorize(:yellow).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
          sleep(0.7)
          @player.exp_add.zombie_attack
          sleep(0.7)         
        end
        if @player.dead?
          "You died!".colorize(:red).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
          sleep (2.0)
          break
        else
        end
      end
      if @player.dead?
        skip
      else
        destination
      end
    end
  end

  Lvl3_RandomEvent = [
    :item, :swimming, :swimming, :smallzombie, :largezombie, :leachingzombie
  ]

  def lvl3_random_event
    Lvl3_RandomEvent.sample
  end

  #3rd trail storyline 
  def game_final
    leached = false
    if @player.dead?
      game_ending
    else
      "You need to swim to your freedom! This river is full of zombie leaches. Hope you brought something to keep 'em off!\n".colorize(:light_green).colorize(:background => :blue).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
      sleep(1.0)
      #? while @player.living - This worked below to run only while player was living.
      while @trail_counter < 15
        lvl3_trail_random_event = lvl3_random_event
        lvl3_trail_random_event
        sleep(1)
        @trail_counter += 1
        if @player.dead?
          "You died!\n".colorize(:red).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
          sleep (1.0)
          break
        end
        if lvl3_trail_random_event == :smallzombie
          "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
          "\nYou encounter a #{RandomWord.adjs.next} zombie! \n".colorize(:green).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
          sleep(0.7)
          @player.exp_add.zombie_attack
          sleep(0.7)
        elsif lvl3_trail_random_event == :swimming
          "----------------\n".colorize(:blue).each_char { |c| putc c; $stdout.flush; sleep 0.02 }
          sleep(0.4)
          puts "You're swimming!".colorize(:blue)
          sleep(0.4)
          "----------------\n".colorize(:blue).each_char { |c| putc c; $stdout.flush; sleep 0.02 }
        elsif lvl3_trail_random_event == :item
          "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
          "\nYou found an item!\n".colorize(:blue).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
          sleep(0.5)
          @player.add_random_item
          sleep (0.7)
        elsif lvl3_trail_random_event == :leachingzombie
          "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
          "\nYou encounter a #{RandomWord.adjs.next} LEACHING ZOMBIE!!! \n".colorize(:green).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
          @player.leached.leaching
          leached = true
          sleep (0.7)
        else lvl3_trail_random_event == :largezombie
          "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
          "\nYou encounter a #{RandomWord.adjs.next} LARGE ZOMBIE! \n".colorize(:yellow).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
          sleep(0.7)
          @player.exp_add.zombie_attack
          "LARGE ZOMBIE won't leave you alone!\n".colorize(:yellow).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
          sleep(0.7)
          @player.exp_add.zombie_attack
          sleep(0.7)         
        end
        if leached == true 
          @player.leaching
        else
        end
      end
      if @player.dead?
        game_ending
      else
        game_victory
      end
    end
  end

  #Death screen 
  def game_ending
    "Game Over\n".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
  end

  #Victory screen. Final method if player survives all methods
  def game_victory
    "You made it!!!!!!\n".colorize(:blue).each_char { |c| putc c; $stdout.flush; sleep 0.1 }
    sleep(2.0)
    scenic_view
    sleep(0.7)
    "\n!You survived the Zombie Apocalypse! Off to the pub (coming soon in Zombie Trail 2.0)\n".colorize(:black).colorize(:background => :red).each_char { |c| putc c; $stdout.flush; sleep 0.06 }
  end

  #put this in as another option for an if function in order to choose an alternate route if the player dies. May be redundant 
  def skip
  end                                                                                           

end

#Starting a new Trail class 
Trail.new

