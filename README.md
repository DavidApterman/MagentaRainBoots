# MagentaRainBoots - V.T.L.F.C.U.H.C
## David Apterman, Jesse Sit, Henry Zheng 

<h1> Overview </h1>
  V.T.L.F.C.U.H.C (Vegetative Terrestrial Life Forms Combating Undead Human Crusaders) is our representation of the classic Plants vs. Zombies. Coded in Processing, our project presents a field onto which the user can place plants to combat incoming zombies. Players are greeted with a welcome screen, featuring a start and an info button. The information screen tells the user about the types of zombies they will be facing and is followed by the instruction screen, which tells the user how to place their plants. Clicking start will simply begin the game.
  </br></br>
<h1> How It Works </h1>  
  The user is able to place plants by clicking on marked squares on the field. These squares correspond to a 2D-Array, a data structure that allows simple iteration to make sure all plants get displayed, and allows us to easily access plants on a row-specific basis. Plant type is selected at the top, where users will click on the type of the plant they wish to place, and then click the screen. After they've clicked the plant name, it will be displayed in the top-left as a confirmation of what they are placing. There are also reset and remove buttons at the top, for canceling your choice or removing a plant from the field, respectively. Note: A user cannot place a plant if they lack the sunlight to do so. 
  </br></br>
  Some of the plants fire projectiles (displayed as small ellipses in the game). The project uses ALHeaps to check collisions between the forward most projectile and the zombie barrelling down the row to improve efficiency. </br>
  In addition, the zombies themselves are sorted, based off their x-coordinate. This was originally unnecessary, but became needed when we wanted to develop zombies with different speeds/complexity. The project uses MergeSort to update which zombie is in "front".

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
