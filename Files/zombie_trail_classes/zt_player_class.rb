class CharacterSpeedy
    HP = 10
    attr_accessor :hp, :exp, :leaching
  
    def initialize
      @d = 0
      @o = 0
      @a = 1
      @hp = HP
      @exp = 0
      @items_bag = ["rusty razor"]
      @leaching = false
    end
  
    def living
      @hp > 0
    end
  
    def exp_add
      @exp += 1
      if @exp % 10 == 0
        @d += 1
        @o += 1
        @a += 1
        puts "!You've leveled up!"
      end
      self
    end
  
    def hp_add
      @hp += 1
    end
  
    def hp_sub
      @hp -= 1
    end
  
    def dead?
      @hp <= 0
    end

    def leached
      @leaching = true
      self
    end

    def leaching
      if @leaching == true 
        if @items_bag.include?("rusty razor") 
        puts "You have a rusty razor. Use it to slice off the leaching zombie? Yes or No?"
        answer = gets.chomp
        if answer == "Yes"
          puts "You cut the bastard off! Good work, lad."
          @leaching = false
        else 
          @hp -= 1
          puts "Okay. Your funeral!"
          puts "You've got a leach zombie attached! -1 HP. HP: #{@hp}"
        end
      else
        @hp -= 1
        puts "You don't have a razor to cut the leaching zombie off! -1 HP. HP: #{@hp}"
      end
    else 
    end
    end
  
    def zombie_attack
      random_number = (rand 100)
      case
      when @d >= 2 && @o >= 0
        if random_number > 5 # ! Creating a 95% probability of failure
          :unhurt
          puts "You escaped unscathed. EXP is now #{@exp}".colorize(:blue)
        elsif random_number * (@a + 1.1) / 1 > 50
          :evaded
          puts "But you got away! Your agility saved you. EXP is now #{@exp}".colorize(:blue)
        else :hurt
          @hp -= 1
          puts "You were bit by the zombie. HP is now #{@hp}".colorize(:red )       end
      when @d == 1 && @o >= 0
        if random_number > 50 # ! Creating a 50% probability of failure
          :unhurt
          puts "You escaped unscathed. EXP is now #{@exp}".colorize(:blue)
        elsif random_number * (@a + 1.1) / 1 > 50
          :evaded
          puts "But you got away! Your agility saved you. EXP is now #{@exp}".colorize(:blue)
        else :hurt
          @hp -= 1
          puts "You were bit by the zombie. HP is now #{@hp}".colorize(:red )       end
      when @d == 0 && @o >= 0
        if random_number > 90 # ! Creating a 10% probability of failure
          :unhurt
          puts "You escaped unscathed. EXP is now #{@exp}".colorize(:blue)
        elsif random_number * (@a + 1.1) / 1 > 50
          :evaded
          puts "But you got away! Your agility saved you. EXP is now #{@exp}".colorize(:blue)
        else :hurt
          @hp -= 1
          puts "You were bit by the zombie. HP is now #{@hp}".colorize(:red )      
        end
      end
    end

  end