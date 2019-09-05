module Art
  def start_screen
    puts " --------------ZOMBIE TRAIL--------------".colorize(:green)
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
    puts "---------press any key to continue--------".colorize(:green)
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
puts "  /^ ^  ^ ^^  ^    ||___|___||||||||||||___|__|||      /||o||||||\\     | "
puts " / ^   ^   ^    ^  ||___|___||||||||||||___|__|||          | |         | " 
puts "/ ^ ^ ^  ^  ^  ^   ||||||||||||||||||||||||||||||oooooooooo| |ooooooo  | "
puts "ooooooooooooooooooooooooooooooooooooooooooooooooooooooooo"
  end
end