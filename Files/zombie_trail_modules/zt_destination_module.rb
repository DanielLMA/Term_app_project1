
# A large unwieldy loop. It started small and grew. Kept it this way to help manage a large loop but would be better if 
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
      sleep(0.7)
    end
    puts "\n (1)(C)hat with locals.\n (2) (L)ook around.\n (3) (G)amble.\n (4) (S)tatus check.\n (5) (I)tem bag check.\n (6) (B)ack to the trail.".colorize(:cyan )
    answer = gets.chomp
    while answer
      zombie_approach_counter += 1
      if answer == "C" || "1" || "Chat" || "c"
        puts "Who would you like to talk to?".colorize(:cyan ) 
        puts @characters.map {|key, value| key}
        answer = gets.chomp
        @characters.fetch(answer.to_sym).colorize(:cyan ).each_char { |c| putc c; $stdout.flush; sleep 0.02 }
        sleep (0.5)
        if answer == "Dr_Important" && @destination_counter == 0 
          @player.add_item("flashlight")
          "Here's a flashlight. There's zombie blood all over it, but she'll be right, eh?\n".colorize(:cyan ).each_char { |c| putc c; $stdout.flush; sleep 0.02 }
        sleep(0.5)
        elsif answer == "Dr_Important" && @destination_counter == 1
          @player.add_item("rusty_razor")
          "Here's a rusty razor from my operating room. May come in handy, eh?\n".colorize(:cyan ).each_char { |c| putc c; $stdout.flush; sleep 0.02 }
          sleep(0.5)
        else
        end
      elsif answer == "L" || "l" || "2" || "Look" || "look"
        scenic_view
        puts "#{exclamation.sample} That's a pretty view".colorize(:cyan )
      elsif answer == "G" || "g" || "3" || "Gamble" || "gamble"
        puts "Gambling you say? #{exclamation.sample} Do you want to play (C)oin toss for more exp or russian (R)oulette or hp?".colorize(:cyan )
        gambling_answer = gets.chomp 
        if gambling_answer == "Coin toss"
          puts "Coin toss it is. #{exclamation.sample}".colorize(:cyan )
          if flip_counter >= 3
            puts "No more coin tosses today! Calm down there bub.".colorize(:cyan )
          else puts "Heads or Tails?".colorize(:cyan )
            while coin_toss_answer = gets.chomp
            coin_toss_flip = coin_toss_array.sample
            "..!".each_char { |c| putc c; sleep 0.5 }
            if coin_toss_answer == coin_toss_flip
              @player.exp_add
              puts "Got it! \nIt was #{coin_toss_flip} Exp is now #{@player.exp}.".colorize(:cyan )
            elsif coin_toss_answer != coin_toss_flip
              puts "Wrong. \nIt was #{coin_toss_flip}.".colorize(:cyan )
            end
            puts "Flip again? (1) Y or (2) N".colorize(:cyan )
            flip_counter += 1
            flip_again = gets.chomp
            if flip_again == "Y" || 1 || "y"
              if flip_counter > 5
                puts "Sorry. Max number of flips.".colorize(:cyan )
                break
              else puts "Heads or Tails?".colorize(:cyan )             
              end
            elsif flip_again == "N" || 2 || "n"
              puts "Good choice. Back to the lobby.".colorize(:cyan )
              break
            end
          end           
        end
        elsif gambling_answer == "Roulette"
          if roulette_counter >= 5
            puts "Nice try. No more roulette today.".colorize(:cyan )
          else puts "#{exclamation.sample} You like taking risks. My kind of person. (R)ed or (B)lack.".colorize(:cyan )
            while roulette_answer = gets.chomp
            "..!".each_char { |c| putc c; sleep 0.5 }
            roulette_spin = roulette_array.sample 
            if roulette_answer == roulette_spin
              @player.hp_add 
              puts "Got it!\n It was #{roulette_spin}.\n Gain an hp: #{@player.hp}hp".colorize(:cyan )
            elsif roulette_answer != roulette_spin
              @player.hp_sub
              puts "Wrong!\n It was #{roulette_spin}.\n Lose an hp: #{@player.hp}hp".colorize(:red )
              if @player.hp == 0
                puts "You died!".colorize(:cyan )
                break
              end
            end
            puts "Spin again?\n (1) Y\n (2) N".colorize(:cyan )
            roulette_counter += 1
            spin_again = gets.chomp
            if spin_again == "Y" || "y" || "1"
              if roulette_counter > 5
                puts "Sorry, max spins reached.\nYou are most #{RandomWord.adjs.next}!".colorize(:cyan )
                break
              else
                puts "Red or Black?".colorize(:cyan )
              end
            elsif spin_again == "N" || "2" || "n"
              puts "Good choice. Back to the lobby.".colorize(:cyan )
              break
            end
          end           end
        end
      elsif answer == "B"
        puts "Okay. Back to the trail.".colorize(:cyan )
        sleep(0.5)
        break
      elsif answer == "S"
        puts "Your stats: EXP = #{@player.exp}, HP = #{@player.hp}. Def/Off/Agi levels: #{@player.d}/#{@player.o}/#{@player.a}"
      elsif answer == "I"
        puts "You've got #{@player.items_bag} in your bag."
      else
        puts "Don't comprehend. What would you like to do?\n(1)(C)hat with locals.\n (2) (L)ook around.\n (3) (G)amble.\n (4) (S)tatus check.\n (5) (I)tem bag check.\n (6) (B)ack to the trail.l".colorize(:cyan )
        answer = gets.chomp
      end
      if @player.hp == 0 #For if a player dies while playing Russian Roulette. 
        break
      elsif zombie_approach_counter == 5 #restricts amount of time player can spend at destination. 
        "There's a faint sound of zombies...\n".colorize(:green).each_char { |c| putc c; $stdout.flush; sleep 0.03 } 
        sleep (0.5)
        "Better hurry it up in here, lad!\n".colorize(:green ).each_char { |c| putc c; $stdout.flush; sleep 0.02 }
        sleep (0.5)
      elsif zombie_approach_counter == 10 
        puts "*BANG*".colorize(:red )
        sleep(1.0)
        "The zombies broke in. Run!!!\n".colorize(:red ).each_char { |c| putc c; $stdout.flush; sleep 0.03 }
        sleep(1.0)
        break
      else
      puts "What now?: \n(1)(C)hat with locals.\n (2) (L)ook around.\n (3) (G)amble.\n (4) (S)tatus check.\n (5) (I)tem bag check.\n (6) (B)ack to the trail.".colorize(:cyan )
      answer = gets.chomp
      end
    end
    @destination_counter += 1
  end
end
