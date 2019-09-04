require "random-word"   #? puts RandomWord.adjs.next #practice random word

#! TO DO e.g. BUY, SELL, PRACTICE, CHAT, ETC see OTdestination.rb. Account for erros in typing responses. 
module Tavern
  def inn
    exclamation = ["Hot diggity!", "Momma Mia!", "Boy oh boy!", "Luck O' di Irish, maytee", "Woooohooooo!", "Strike me pink!"]
    roulette_array = ["Red", "Black"]
    coin_toss_array = ["Heads", "Tails"]
    roulette_counter = 0
    flip_counter = 0
    if @destination_counter == 0
      "\n#{exclamation.sample}!! You made it to the tavern alive. What would you like to do?".each_char { |c| putc c; $stdout.flush; sleep 0.03 }
      sleep(0.8)
    else
      "\n#{exclamation.sample}!! You survived! You're at the docks! What would you like to do?".each_char { |c| putc c; $stdout.flush; sleep 0.03 }
    end
    @destination_counter += 1
    "\n(C)hat with locals. (L)ook around. (G)amble. (B)ack to the trail.".each_char { |c| putc c; $stdout.flush; sleep 0.03 }
    answer = gets.chomp
    while answer
      if answer == "C"
        puts "Who would you like to talk to?" #! LIST CHARACTERS HERE ON THE HASHES
      elsif answer == "L"
        puts "That's a pretty view" #! ASCII GOES HERE. MAkE $ OF STEPS DETERMINE THE VIEW
      elsif answer == "G"
        puts "Gambling you say? #{exclamation.sample} Do you want to play (C)oin toss for more exp or russian (R)oulette or hp?"
        gambling_answer = gets.chomp #! FIND WAY TO GET SIMILAR ANSWERS that are close to ct or rr
        if gambling_answer == "Coin toss"
          puts "Coin toss it is. #{exclamation.sample}"
          if flip_counter >= 3
            puts "No more coin tosses today! Calm down there bub."
          else puts "heads or tails?"
            while coin_toss_answer = gets.chomp
            coin_toss_flip = coin_toss_array.sample
            "..!".each_char { |c| putc c; sleep 0.5 }
            if coin_toss_answer == coin_toss_flip
              @player.exp_add
              puts "Got it! \nIt was #{coin_toss_flip} Exp is now #{@player.exp}."
            elsif coin_toss_answer != coin_toss_flip
              puts "Wrong. \nIt was #{coin_toss_flip}."
            end
            puts "Flip again? Y or N"
            flip_counter += 1
            flip_again = gets.chomp
            if flip_again == "Y"
              if flip_counter > 5
                puts "Sorry. Max number of flips"
                break
              else puts "heads or tails"               end
            elsif flip_again == "N"
              puts "Good choice. Back to the lobby."
              break
            end
          end           end
        elsif gambling_answer == "Roulette"
          if roulette_counter >= 5
            puts "Nice try. No more roulette today."
          else puts "#{exclamation.sample} You like taking risks. My kind of person. (R)ed or (B)lack."
            while roulette_answer = gets.chomp
            "..!".each_char { |c| putc c; sleep 0.5 }
            roulette_spin = roulette_array.sample #! CAN TRY TO GET ODD/EVEN FOR EVEN MORE GAIN
            if roulette_answer == roulette_spin
              @player.hp_add #! unless value = 10, then stay at 10. Check pp with Ben.
              puts "Got it!\n It was #{roulette_spin}.\n Gain an hp: #{@player.hp}hp"
            elsif roulette_answer != roulette_spin
              @player.hp_sub
              puts "Wrong!\n It was #{roulette_spin}.\n Lose an hp: #{@player.hp}hp"
              if @player.hp == 0
                puts "You died!"
                break
              end
            end
            puts "Spin again? Y or N"
            roulette_counter += 1
            spin_again = gets.chomp
            if spin_again == "Y"
              if roulette_counter > 5
                puts "Sorry, max spins reached.\nYou are most #{RandomWord.adjs.next}!"
                break
              else
                puts "red or black?"
              end
            elsif spin_again == "N"
              puts "Good choice. Back to the lobby."
              break
            end
          end           end
        end
      elsif answer == "B"
        puts "Okay. Back to the trail."
        break
      else
        puts "Don't comprehend what you're saying. What would you like to do?(C)hat with locals. (L)ook around. (G)amble. (B)ack to the trail"
        answer = gets.chomp
      end
      if @player.hp == 0
        break
      else
      puts "What now?: (C)hat with locals. (L)ook around. (G)amble. (B)ack to the trail"
      answer = gets.chomp
      end
    end
  end
end