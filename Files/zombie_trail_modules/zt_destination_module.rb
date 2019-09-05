require "random-word"   #? puts RandomWord.adjs.next #practice random word
require "colorize"

#! TO DO e.g. BUY, SELL, PRACTICE, CHAT, ETC see OTdestination.rb. Account for erros in typing responses. 
module Destination
  def destination
    exclamation = ["Hot diggity!", "Momma Mia!", "Boy oh boy!", "Luck O' di Irish, maytee", "Woooohooooo!", "Strike me pink!"]
    roulette_array = ["Red", "Black"]
    coin_toss_array = ["Heads", "Tails"]
    roulette_counter = 0
    flip_counter = 0
    zombie_approach_counter = 0
    if @destination_counter == 0
      "\n#{exclamation.sample}! You made it to the tavern alive, #{@name}. What would you like to do?".colorize(:cyan ).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
      sleep(0.5)
    else
      "\n#{exclamation.sample}!! You survived, #{@name}! You're at the docks! What would you like to do?".colorize(:cyan ).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
      sleep(0.5)
    end
    "\n(C)hat with locals. (L)ook around. (G)amble. (B)ack to the trail.".colorize(:cyan ).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
    answer = gets.chomp
    while answer
      zombie_approach_counter += 1
      if answer == "C"
        puts "Who would you like to talk to?".colorize(:cyan ) #! LIST CHARACTERS HERE ON THE HASHES
        puts @characters.map {|key, value| key}
        character_answer = gets.chomp
        @characters.fetch(character_answer.to_sym) 
        if character_answer == "Dr_Important" && @destination_counter == 0 
          @player.add_item("flashlight")
          puts "Here's a flashlight I used for my zombie operating experiments. There's zombie blood all over it, but she'll be right, eh?"
        elsif character_answer == "Dr_Important" && @destination_counter == 1
          @player.add_item("rusty razor")
          puts "Here's a rusty razor from my operating room. May come in handy on your quest, eh?"
        else
        end
      elsif answer == "L"
        puts "That's a pretty view".colorize(:cyan ) #! ASCII GOES HERE. MAkE $ OF STEPS DETERMINE THE VIEW
      elsif answer == "G"
        puts "Gambling you say? #{exclamation.sample} Do you want to play (C)oin toss for more exp or russian (R)oulette or hp?".colorize(:cyan )
        gambling_answer = gets.chomp #! FIND WAY TO GET SIMILAR ANSWERS that are close to ct or rr
        if gambling_answer == "Coin toss"
          puts "Coin toss it is. #{exclamation.sample}".colorize(:cyan )
          if flip_counter >= 3
            puts "No more coin tosses today! Calm down there bub.".colorize(:cyan )
          else puts "heads or tails?".colorize(:cyan )
            while coin_toss_answer = gets.chomp
            coin_toss_flip = coin_toss_array.sample
            "..!".each_char { |c| putc c; sleep 0.5 }
            if coin_toss_answer == coin_toss_flip
              @player.exp_add
              puts "Got it! \nIt was #{coin_toss_flip} Exp is now #{@player.exp}.".colorize(:cyan )
            elsif coin_toss_answer != coin_toss_flip
              puts "Wrong. \nIt was #{coin_toss_flip}.".colorize(:cyan )
            end
            puts "Flip again? Y or N".colorize(:cyan )
            flip_counter += 1
            flip_again = gets.chomp
            if flip_again == "Y"
              if flip_counter > 5
                puts "Sorry. Max number of flips.".colorize(:cyan )
                break
              else puts "Heads or Tails?"             end
            elsif flip_again == "N"
              puts "Good choice. Back to the lobby.".colorize(:cyan )
              break
            end
          end           end
        elsif gambling_answer == "Roulette"
          if roulette_counter >= 5
            puts "Nice try. No more roulette today.".colorize(:cyan )
          else puts "#{exclamation.sample} You like taking risks. My kind of person. (R)ed or (B)lack.".colorize(:cyan )
            while roulette_answer = gets.chomp
            "..!".each_char { |c| putc c; sleep 0.5 }
            roulette_spin = roulette_array.sample #! CAN TRY TO GET ODD/EVEN FOR EVEN MORE GAIN
            if roulette_answer == roulette_spin
              @player.hp_add #! unless value = 10, then stay at 10. Check pp with Ben.
              puts "Got it!\n It was #{roulette_spin}.\n Gain an hp: #{@player.hp}hp".colorize(:cyan )
            elsif roulette_answer != roulette_spin
              @player.hp_sub
              puts "Wrong!\n It was #{roulette_spin}.\n Lose an hp: #{@player.hp}hp".colorize(:cyan )
              if @player.hp == 0
                puts "You died!".colorize(:cyan )
                break
              end
            end
            puts "Spin again? Y or N".colorize(:cyan )
            roulette_counter += 1
            spin_again = gets.chomp
            if spin_again == "Y"
              if roulette_counter > 5
                puts "Sorry, max spins reached.\nYou are most #{RandomWord.adjs.next}!".colorize(:cyan )
                break
              else
                puts "red or black?".colorize(:cyan )
              end
            elsif spin_again == "N"
              puts "Good choice. Back to the lobby.".colorize(:cyan )
              break
            end
          end           end
        end
      elsif answer == "B"
        puts "Okay. Back to the trail.".colorize(:cyan )
        break
      else
        puts "Don't comprehend what you're saying. What would you like to do?(C)hat with locals. (L)ook around. (G)amble. (B)ack to the trail".colorize(:cyan )
        answer = gets.chomp
      end
      if @player.hp == 0
        break
      elsif zombie_approach_counter == 3 
        "There's a faint sound of zombies...\n".colorize(:green).each_char { |c| putc c; $stdout.flush; sleep 0.04 } 
        sleep (0.5)
        "Better hurry it up in here, lad!\n".colorize(:green ).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
        sleep (0.5)
        puts "What would you like to do?(C)hat with locals. (L)ook around. (G)amble. (B)ack to the trail\n".colorize(:cyan )
        answer = gets.chomp 
      elsif zombie_approach_counter == 6 
        puts "*BANG*".colorize(:red )
        sleep(1.0)
        "The zombies broke in. Run!!!\n".colorize(:red ).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
        sleep(1.0)
        break
      else
      puts "What now?: (C)hat with locals. (L)ook around. (G)amble. (B)ack to the trail".colorize(:cyan )
      answer = gets.chomp
      end
    end
    @destination_counter += 1
  end
end
