class CharacterSpeedy
    HP = 10
    attr_accessor :hp, :exp, :d, :o, :a, :leaching, :items_bag
  
    def initialize
      @d = 0
      @o = 0
      @a = 1
      @hp = HP
      @exp = 0
      @items_bag = []
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
        puts "!You've leveled up!".colorize(:yellow)
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

    def add_item(name)
      @items_bag << name
    end

    def add_random_item
      random_item = RandomWord.adjs.next
      @items_bag << random_item
      puts "It's a rare #{random_item}".colorize(:blue)
    end

    def check_for_item(name)
      @items_bag.include?(name)
    end

    def leached
      @leaching = true
      self
    end

    def leaching
      if @leaching == true 
        if @items_bag.include?("rusty_razor") 
          sleep(0.5)
        puts "You have a rusty razor. Use it to slice off the leaching zombie? Yes or No?".colorize(:blue)
        sleep(0.5)
        answer = gets.chomp
        if answer == "Yes"
          puts "You cut it off! Good work, lad.".colorize(:blue)
          sleep(0.3)
          @leaching = false
        else 
          @hp -= 1
          puts "Okay. Your funeral!".colorize(:blue)
          puts "You've got a leach zombie attached! -1 HP. HP: #{@hp}".colorize(:blue)
          sleep(0.3)
        end
      else
        @hp -= 1
        sleep(0.4)
        puts "Leaching zombie is sucking your blood! -1 HP. HP: #{@hp}".colorize(:blue)
        sleep(0.3)
      end
    else 
    end
    end
  
    def zombie_attack
      random_number = (rand 100)
      case
      when @d >= 2 || @o >= 2
        if random_number > 10 # Creating a 90% probability of failure
          :unhurt
          puts "You escaped unscathed. EXP is now #{@exp}".colorize(:blue)
        elsif random_number * (@a + 1.1) / 1 > 90
          :evaded
          puts "But you got away! Your agility saved you. EXP is now #{@exp}".colorize(:blue)
        else :hurt
          @hp -= 1
          puts "You were bit by the zombie. HP is now #{@hp}".colorize(:red )       end
      when @d == 1 || @o >= 1
        if random_number > 80 # Creating a 20% probability of failure
          :unhurt
          puts "You escaped unscathed. EXP is now #{@exp}".colorize(:blue)
        elsif random_number * (@a + 1.1) / 1 > 80
          :evaded
          puts "But you got away! Your agility saved you. EXP is now #{@exp}".colorize(:blue)
        else :hurt
          @hp -= 1
          puts "You were bit by the zombie. HP is now #{@hp}".colorize(:red )       end
      when @d == 0 && @o >= 0
        if random_number > 75 # Creating a 25% probability of failure
          :unhurt
          puts "You escaped unscathed. EXP is now #{@exp}".colorize(:blue)
        elsif random_number * (@a + 1.1) / 1 > 70
          :evaded
          puts "But you got away! Your agility saved you. EXP is now #{@exp}".colorize(:blue)
        else :hurt
          @hp -= 1
          puts "You were bit by the zombie. HP is now #{@hp}".colorize(:red )      
        end
      end
    end

  end
