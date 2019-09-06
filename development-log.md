**Status update 3/9/19**

Halfway through my program, I have the functionality for my character class that is used in the Trail class. I have 2 of my three "trails" and have a module for my destination where the player moves to after completing the first two trail methods. I need to add items and functions for use of these items. Also, a way for certain zombies (picked from an array) that can cause damage in different ways, including with decreasing HP with each turn. 

**Status update 4/9/19**

I hit a major snag when I tried to add a feature to allow for an instance variable in the 'CharacterSpeedy' class that was a boolean. The value is initialized and set to false, changing to true when, in the Trail class within the game_final method (The 3rd method in which the player is on the "trail"), a :leachingzombie is encountered. I was able to solve this when I called a method from CharacterSpeedy to switch the @leaching instance variable to true. I was then able to give the user the option to remove the leaching zombie (turn the @leaching boolean variable to false) if they have the "rusty razor" in their @items_bag array, but also choose to use it. I think that my code is not completely DRY, however, as I needed to add a boolean variable to the game_final method in Trail that sets to true after the first :leachingzombie is encountered, after which time the leaching method must be continuously called in CharacterSpeedy. 

