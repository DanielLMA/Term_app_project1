class CharacterSpeedy
    HP = 10
    attr_reader :hp, :exp
  
    def initialize
      @d = 0
      @o = 0
      @a = 1
      @hp = HP
      @exp = 0
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
      @hp == 0
    end
  
    def zombie_attack
      random_number = (rand 100)
      case
      when @d >= 2 && @o >= 0
        if random_number > 5 # ! Creating a 95% probability of failure
          :unhurt
          puts "You escaped unscathed. EXP is now #{@exp}"
        elsif random_number * (@a + 1.1) / 1 > 50
          :evaded
          puts "But you got away! Your agility saved you. EXP is now #{@exp}"
        else :hurt
          @hp -= 1
          puts "You were bit by the zombie. HP is now #{@hp}"       end
      when @d == 1 && @o >= 0
        if random_number > 50 # ! Creating a 50% probability of failure
          :unhurt
          puts "You escaped unscathed. EXP is now #{@exp}"
        elsif random_number * (@a + 1.1) / 1 > 50
          :evaded
          puts "But you got away! Your agility saved you. EXP is now #{@exp}"
        else :hurt
          @hp -= 1
          puts "You were bit by the zombie. HP is now #{@hp}"       end
      when @d == 0 && @o >= 0
        if random_number > 90 # ! Creating a 10% probability of failure
          :unhurt
          puts "You escaped unscathed. EXP is now #{@exp}"
        elsif random_number * (@a + 1.1) / 1 > 50
          :evaded
          puts "But you got away! Your agility saved you. EXP is now #{@exp}"
        else :hurt
          @hp -= 1
          puts "You were bit by the zombie. HP is now #{@hp}"       end
      end
    end
  end