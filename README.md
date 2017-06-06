# MagentaRainBoots - V.T.L.F.C.U.H.C
## David Apterman, Jesse Sit, Henry Zheng 

  V.T.L.F.C.U.H.C is our representation of Plants vs. Zombies coded in Processing. The project presents a field onto which the user can place plants to combat incoming zombies. Currently there is a welcome screen with a start button and an info button (in-game description). If you click on the info button, then the instruction button also shows up. This is for those that don't know how to play our game. Else, if you think you're a pro and want to go straight into the game, be our guests and click on the start button.
  
  The user is able to place plants, which immediately fire (generate) projectiles. The project uses ALHeaps and MergeSort to check collisions between plant projectiles and zombies to implement the user's defense. The user also can see how much sunlight he currently holds, much like the game.
  
  Currently, you can place plants by pressing on a type of plant on the top and then clicking somewhere on the field. While you have clicked on a type of plant, the currently held type is displayed in the top right corner. There is also a reset button below it to reset the currently held type.

  There is also a remove option where you press on the remove text at the top of the screen and click on a plant. It will remove the plant from the field, much like in the game.

  Currently, we have 4 different types of plants: peashooters, sunflowers, wallnuts, and chompers. The peashooter is your normal, average plant. The sunflower is your friend. It produces sunlight so that you can plant more plants! The wallnut is your best line of defense with a ton of health. Last but not least, the chomper is your last resort if you want to kill a zombie instantly- but be careful, the chomper also dies with the zombie (suicide bomber???). These plants cost 50, 50, 100, and 100 sunlight, respectively.
  
### Launch instructions
    
1. Enter you terminal and cd into the location that you want to have this game
2. Enter this command to clone our repo
```
git clone git@github.com:DavidApterman/MagentaRainBoots.git
```
3. Go into the folder called PvZ using this command
```
cd PvZ/
```
4. Run the program
```
processing PvZ.pde
```
