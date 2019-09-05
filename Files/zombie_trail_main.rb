require "random-word"   #? puts RandomWord.adjs.next #practice random word
require "colorize"
require 'io/console' 

require_relative "zombie_trail_modules/zt_destination_module"
require_relative "zombie_trail_classes/zt_player_class"

class Trail
  include Destination

  def initialize
    @player = CharacterSpeedy.new
    @trail_counter = 0
    @destination_counter = 0
    @name = nil
    @characters = {
      Bob: "You #{RandomWord.adjs.next} #{RandomWord.nouns.next}. Coming into this #{RandomWord.adjs.next} part of town. You better beat it before I use my #{RandomWord.nouns.next} on you.",
      Bertha: "I seemed to have lost my #{RandomWord.nouns.next}. I thought I set it by my #{RandomWord.nouns.next} but a #{RandomWord.adjs.next} came and stole it.",
      Dr_Important: "People around here are a little #{RandomWord.adjs.next}."
    }
    #four methods below called to run my program
    start_screen
    introduction
    game_start
    game_middle
    game_final
  end

  def introduction 

    "Welcome to Zombie Trail!\n".colorize(:black).colorize(:background => :red).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
    sleep(0.3)
    "It is a most #{RandomWord.adjs.next} day for a #{RandomWord.adjs.next} stroll with zombies.".colorize(:white).colorize(:background => :light_black).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
    sleep(0.3)
    "\nFirst thing's first. What is your name?".colorize(:white).colorize(:background => :light_black).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
    sleep(0.1)
    puts "\n"
    @name = gets.chomp
    "\nGreat, #{@name}. Let's hit the trail...\n".colorize(:white).colorize(:background => :light_black).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
    sleep(0.5)
  end
  #possibilities of interactions chosen at random during 
  Lvl1_RandomEvent = [
    :smallzombie, :smallzombie, :walking, :walking, :walking,
  ]
  def lvl1_random_event
    Lvl1_RandomEvent.sample
  end

  def game_start
    while @trail_counter < 0
      lvl1_trail_random_event = lvl1_random_event
      lvl1_trail_random_event
      sleep(1)
      @trail_counter += 1
      if lvl1_trail_random_event == :smallzombie
        "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
        "\nYou encounter a #{RandomWord.adjs.next} zombie! \n".colorize(:green).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
        sleep(0.7)
        @player.exp_add.zombie_attack
        sleep(0.7)
      elsif lvl1_trail_random_event == :walking
        "--------------\n".colorize(:blue).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
        sleep(0.5)
        puts "You're walking".colorize(:blue)
        sleep(0.7)
        "--------------\n".colorize(:blue).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
      else lvl1_trail_random_event == :item
        "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
        "\nYou found an item!\n".colorize(:blue).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
        sleep (0.7)       end
      if @player.dead?
        "You died.".colorize(:black).colorize(:background => :red).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
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
    :running, :running, :running, :smallzombie, :largezombie, :lost 
  ]

  def lvl2_random_event
    Lvl2_RandomEvent.sample
  end

  def game_middle
    # leached = false
    if @player.dead?
      skip #!this will need to be a skip after add game_middle
    else
      "You're about to enter the Forbbiden Forest. Hope you brought your flashlight.\n".colorize(:light_green).colorize(:background => :blue).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
      sleep(1.0)
      #? while @player.living - This worked below to run only while player was living.
      while @trail_counter < 10
        lvl2_trail_random_event = lvl2_random_event
        lvl2_trail_random_event
        sleep(1)
        @trail_counter += 1
        if lvl2_trail_random_event == :smallzombie
          "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
          "\nYou encounter a #{RandomWord.adjs.next} zombie! \n".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
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
          "\nYou found an item!\n".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
          sleep (0.7)
        elsif lvl2_trail_random_event == :lost 
          if @player.check_for_item("flashlight")
            puts "Good thing you got that flashlight from Dr_Important. You can see the path clearly."
          else 
            puts "Hey dope. Forgot to bring that flashlight...Looks like I landed back at the start. Argh!"
            @trail_counter = 0
          end
        else lvl2_trail_random_event == :largezombie
          "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
          "\nYou encounter a #{RandomWord.adjs.next} LARGE ZOMBIE! \n".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
          sleep(0.7)
          @player.exp_add.zombie_attack
          puts "LARGE ZOMBIE won't leave you alone!".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
          sleep(0.7)
          @player.exp_add.zombie_attack
          sleep(0.7)         end
        if @player.dead?
          "You died!".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
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

  def game_final
    leached = false
    if @player.dead?
      game_ending
    else
      "You need to swim to your freedom! This river is full of zombie leaches. Hope you brought something to keep 'em off!\n".colorize(:light_green).colorize(:background => :blue).each_char { |c| putc c; $stdout.flush; sleep 0.04 }
      sleep(1.0)
      #? while @player.living - This worked below to run only while player was living.
      while @trail_counter < 15
        lvl2_trail_random_event = lvl2_random_event
        lvl2_trail_random_event
        sleep(1)
        @trail_counter += 1
        if lvl2_trail_random_event == :smallzombie
          "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
          "\nYou encounter a #{RandomWord.adjs.next} zombie! \n".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
          sleep(0.7)
          @player.exp_add.zombie_attack
          sleep(0.7)
        elsif lvl2_trail_random_event == :running
          "---------------\n".colorize(:light_red).each_char { |c| putc c; $stdout.flush; sleep 0.02 }
          sleep(0.4)
          puts "You're swimming!".colorize(:light_red)
          sleep(0.4)
          "---------------\n".colorize(:light_red).each_char { |c| putc c; $stdout.flush; sleep 0.02 }
        elsif lvl2_trail_random_event == :item
          "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
          "\nYou found an item!\n".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
          sleep (0.7)
        elsif lvl2_trail_random_event == :leachingzombie
          "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
          "\nYou encounter a #{RandomWord.adjs.next} LEACHING ZOMBIE!!! \n".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
          @player.leached.leaching
          leached = true
          sleep (0.7)
        else lvl2_trail_random_event == :largezombie
          "..!".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
          "\nYou encounter a #{RandomWord.adjs.next} LARGE ZOMBIE! \n".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
          sleep(0.7)
          @player.exp_add.zombie_attack
          puts "LARGE ZOMBIE won't leave you alone!"
          @player.exp_add.zombie_attack
          sleep(0.7)         end
        if leached == true
          @player.leaching
        elsif @player.dead?
          "You died!".each_char { |c| putc c; $stdout.flush; sleep 0.04 }
          sleep (1.0)
          break
        else
        end
      end
      if @player.dead?
        skip
        game_ending
      else
        game_victory
      end
    end
  end

  def game_ending
    "Game Over\n".each_char { |c| putc c; $stdout.flush; sleep 0.5 }
  end

  def game_victory
    puts "You survived the Zombie Apocalypse! Off to the pub (coming soon in Zombie Trail 2.0)"
  end

  def skip
  end

  def start_screen
    puts " ---------WELCOME TO ZOMBIE TRAIL--------".colorize(:green)
    puts "                                (()))".colorize(:green)
    puts "                               /|x x|".colorize(:green)
    puts "                              /|( - )" .colorize(:green)
    puts "                      ___.-._/|/".colorize(:green)
    puts "                     /=`_'-'-'/  !!".colorize(:green)
    puts "                     |-{-_-_-}     !".colorize(:green)
    puts "                     (-{-_-_-}    !".colorize(:green)
    puts "                      |{_-_-_}   !".colorize(:green)
    puts "                       }-_-_-}".colorize(:green)
    puts "                       {-_|-_}".colorize(:green)
    puts "                       {-_|_-}".colorize(:green)
    puts "                       {_-|-_}".colorize(:green)
    puts "                       {_-|-_}".colorize(:green)
    puts "                   ____%%@ @%%_______".colorize(:green)
    puts "-----------press any key to continue------".colorize(:green)
    continue_story
  end

  def scenic_view
puts "                                   /\\ "
puts "                              /\\  //\\\\\ "
puts "                       /\\    //\\\///  \\\\\        /\\\ "
puts "                      //\\\\  ///\\\//    \\\\  /\\  //\\\\ "
puts "         /\\          /  ^ \\/^ ^/^  ^  ^ \\/^ \\/  ^ \\ "
puts "        / ^\\    /\\  / ^   /  ^/ ^ ^ ^   ^\\ ^/  ^^  \\ "
puts "       /^   \\  / ^\\/ ^ ^   ^ / ^  ^    ^  \\/ ^   ^  \\       * "
puts "      /  ^ ^ \\/^  ^\\ ^ ^ ^   ^  ^   ^   ____  ^   ^  \\     /|\\ "
puts "     / ^ ^  ^ \\ ^  _\\___________________|  |_____^ ^  \\   /||o\\ "
puts "    / ^^  ^ ^ ^\\  /______________________________\\ ^ ^ \\ /|o|||\\ "
puts "   /  ^  ^^ ^ ^  /________________________________\\  ^  /|||||o|\\ "
puts "  /^ ^  ^ ^^  ^    ||___|___||||||||||||___|__|||      /||o||||||\\       | "
puts " / ^   ^   ^    ^  ||___|___||||||||||||___|__|||          | |           | " 
puts "/ ^ ^ ^  ^  ^  ^   ||||||||||||||||||||||||||||||oooooooooo| |ooooooo  | "
puts "ooooooooooooooooooooooooooooooooooooooooooooooooooooooooo"
  end

                                                                                                        
  def continue_story                                                                                                     
    #puts "Press any key to continue"
    STDIN.getch                                                                                                              
    puts "                         \r" # extra space to overwrite in case next sentence is short                                                                                                              
  end       

end

Trail.new

