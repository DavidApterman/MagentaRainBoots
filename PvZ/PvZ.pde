//import java.util.*;

ArrayList<Zombie> zombies1_offfield = new ArrayList<Zombie>();                                         //all zombies for level
ArrayList<Zombie> zombies1_onfield = new ArrayList<Zombie>();                                          //all zombies currently on screen
ArrayList<Zombie> zombies1_nextfield = new ArrayList<Zombie>();

ArrayList<Zombie> zombies2_offfield = new ArrayList<Zombie>();                                         //all zombies for level
ArrayList<Zombie> zombies2_onfield = new ArrayList<Zombie>();                                          //all zombies currently on screen
ArrayList<Zombie> zombies2_nextfield = new ArrayList<Zombie>();


ArrayList<Zombie> zombies3_offfield = new ArrayList<Zombie>();                                         //all zombies for level
ArrayList<Zombie> zombies3_onfield = new ArrayList<Zombie>();                                          //all zombies currently on screen
ArrayList<Zombie> zombies3_nextfield = new ArrayList<Zombie>();


ArrayList<Zombie> zombies4_offfield = new ArrayList<Zombie>();                                         //all zombies for level
ArrayList<Zombie> zombies4_onfield = new ArrayList<Zombie>();                                          //all zombies currently on screen
ArrayList<Zombie> zombies4_nextfield = new ArrayList<Zombie>();


ArrayList<Zombie> zombies5_offfield = new ArrayList<Zombie>();                                         //all zombies for level
ArrayList<Zombie> zombies5_onfield = new ArrayList<Zombie>();                                          //all zombies currently on screen
ArrayList<Zombie> zombies5_nextfield = new ArrayList<Zombie>();

ArrayList<Sunlight> sunspots = new ArrayList<Sunlight>();                                              //holds dropping Sunlight packets

Plant[][] plants = new Plant[5][8];                                                                    //stores all plants on field in 2D grid

//store projectiles for each row
ArrayList<Projectile> projectile1 = new ArrayList<Projectile>();  
ArrayList<Projectile> projectile2 = new ArrayList<Projectile>();
ArrayList<Projectile> projectile3 = new ArrayList<Projectile>();
ArrayList<Projectile> projectile4 = new ArrayList<Projectile>();
ArrayList<Projectile> projectile5 = new ArrayList<Projectile>();
int time = 0;                                                                                           //global timer for game
int r1time = (int)random(-500, -200);
int r2time = (int)random(-500, -200);
int r3time = (int)random(-500, -200);
int r4time = (int)random(-500, -200);
int r5time = (int)random(-500, -200);
int sunlight = 250;                                                                                     //starting sunlight (currently high for testing)
int plantclicked = 0;                                                                                   //stores type of plant after user selection to place correct breed
boolean start = false;                                                                                  //start screen display boolean
boolean info = false;
boolean levelDone = false;
int levelNum = 0;
boolean levelClick = true;
//Do not disturb (for now)
//ALHeap projectile1 = new ALHeap();
//ALHeap projectile2 = new ALHeap();
//ALHeap projectile3 = new ALHeap();
//ALHeap projectile4 = new ALHeap();
//ALHeap projectile5 = new ALHeap();

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



//mini "draw" method for each row, uses row-specific variables to ensure equivalent/compact running for each row
void drawRow(ArrayList<Projectile> heap, ArrayList<Zombie> off, ArrayList<Zombie> on, ArrayList<Zombie> next, int timer, int rowNum) {
  Plant p = null;

  if (timer % 900 == 0 || timer % 900 == 300 || timer % 900 == 600) { //maintain rate of zombies
    if (!off.isEmpty()) {
      on.add(off.remove(0)); //if there are more zombies to spawn, by all means
      System.out.println("zombie spawn");
    }
  }

  for (int i = 0; i < plants[rowNum].length; i++) {  //sets target plant p to point to the furthest plant in the row
    if (plants[rowNum][i] != null) {
      p = plants[rowNum][i];
    }
  }

  for (int x = 0; x < on.size(); x++) { //checks if a zombie has reached the end of the row, which would cause a game over
    if (on.get(x).getX() <= -25) { //if true, zombie reached end
      on.get(x).display();
      textSize(32);
      text("game over", 350, 300);
      noLoop();
    } 
    else if(on.get(x).getState() == 2 && p != null && p.getX() + 25 >= on.get(x).getX() - 25 && p.getX() <= on.get(x).getX()) {
      on.get(x).setState(1);
      on.get(x).setX(p.getX() - 20);
    }
    else if (p != null && p.getX() + 25 >= on.get(x).getX() - 25 && p.getX()-20 <= on.get(x).getX()) {    //detects plant-zombie collision
      if (p.getType() == 4) {
        p.setState(0);
        next.add(on.remove(x));
      } else {
        p.setHealth(on.get(x).getDamage() );
        on.get(x).display();
      }
    } else {                                                                                            //moves zombies forward
      on.get(x).move();
    }

    for (int i = 0; i < heap.size(); i++) {
      if (x < on.size() &&
        heap.get(i).getX() + 5 >= on.get(x).getX() - 25 &&
        heap.get(i).getX() + 5 <= on.get(x).getX() - 20) {  //checks collision between shot and zombie
        on.get(x).setHealth(heap.get(i).getDamage()); //damage zombies

        if (on.get(x).getState() == 0) {   //if a zombie is dead, off it goes off the screen and to zombie heaven
          next.add(on.remove(x)); //add to nextfield
          //remove zombies after death
          if (on.isEmpty()) { //for changes in # of zombies1_onfield during runtime
            return;
          }
        }
        heap.remove(i);  //removes projectiles from heap if they hit a zombie
        i--;
      }
    }
  }
  for (Projectile j : heap ) {
    j.display();        //display projectiles AFTER calculating collisions
  }
}


//******************************************************************************\\                                                      
////////////////////////// WARNING: ENTERING MERGE SORT \\\\\\\\\\\\\\\\\\\\\\\\\\
ArrayList<Zombie> merge(ArrayList<Zombie> a, ArrayList<Zombie> b ) {

  ArrayList<Zombie> retArr = new ArrayList<Zombie>(); //( a.size() + b.size() )

  //init position markers for each input array
  int aPos = 0;
  int bPos = 0;

  int pos = 0; //position marker for return array

  while ( aPos < a.size() && bPos < b.size() ) {
    if ( a.get(aPos).getX() < b.get(bPos).getX() ) {  
      retArr.set(pos, a.get(aPos));
      aPos++;
    } else {
      retArr.set(pos, b.get(bPos));
      bPos++;
    }
    pos++;
  }
  //at least one input array has been exhausted
  if ( bPos >= b.size() )
    for (; pos < retArr.size(); pos++ ) {
      retArr.set(pos, a.get(aPos)); 
      aPos++;
    } else
    for (; pos < retArr.size(); pos++ ) {
      retArr.set(pos, b.get(bPos)); 
      bPos++;
    }

  return retArr;
}//end merge()


/******************************************************
 * ArrayList<Zombie> sort(ArrayList<Zombie> arr) 
 ******************************************************/
ArrayList<Zombie>  sort( ArrayList<Zombie>  arr ) {

  //if dataset is 1 element, then dataset is sorted
  if ( arr.size() <= 1 ) 
    return arr;

  //else, halve dataset and recurse on each half
  int leftLen = arr.size() / 2;
  ArrayList<Zombie> leftHalf = new ArrayList<Zombie>() ;
  ArrayList<Zombie> rightHalf = new ArrayList<Zombie>() ;

  for ( int i=0; i<arr.size(); i++ ) {
    if ( i < leftLen )
      leftHalf.set(i, arr.get(i));
    else
      rightHalf.set(i-leftLen, arr.get(i));
  }

  return merge( sort(leftHalf), sort(rightHalf) );
}

////////////////////////// WARNING: LEAVING MERGE SORT \\\\\\\\\\\\\\\\\\\\\\\\\\
//******************************************************************************\\ 


void setup() {
  size(800, 660); //generates board
  background(25, 150, 25); //sets board color 
  for (int i = 0; i < random(4); i++) {//adds zombies to row 1
    //Zombie test = new Zombie(800, 95);
    Jumper j1 = new Jumper(800,95);
    zombies1_offfield.add(j1);
    //zombies1_offfield.add(test);
  }
  for (int i = 0; i < random(4); i++) {//adds zombies to row 2
    Zombie test2 = new Zombie(800, 215);
    zombies2_offfield.add(test2);
  }
  for (int i = 0; i < random(4); i++) {//adds zombies to row 3
    Zombie test3 = new Zombie(800, 335);
    zombies3_offfield.add(test3);
  }
  for (int i = 0; i < random(4); i++) {//adds zombies to row 4
    Zombie test4 = new Zombie(800, 455);
    zombies4_offfield.add(test4);
  }
  for (int i = 0; i < random(4); i++) {//adds zombies to row 5
    Zombie test5 = new Zombie(800, 575);
    zombies5_offfield.add(test5);
  }
  //testing purposes
  /*plants[0][0] = new Peashooter(25,95);
   plants[1][0] = new Peashooter(25,215);
   plants[2][0] = new Peashooter(25,335);
   plants[3][0] = new Peashooter(25,455);
   plants[4][0] = new Peashooter(25,575);*/
}

void resetLevel() {
  while ( !zombies1_nextfield.isEmpty() ) {
    zombies1_nextfield.remove(0);
    zombies1_offfield.add( new Zombie(800, 95, 100 + (levelNum * 15)));
  }
  while ( !zombies2_nextfield.isEmpty() ) {
    zombies2_nextfield.remove(0);
    zombies2_offfield.add( new Zombie(800, 215, 100 + (levelNum * 15)));
  }
  while ( !zombies3_nextfield.isEmpty() ) {
    zombies3_nextfield.remove(0);
    zombies3_offfield.add( new Zombie(800, 335, 100 + (levelNum * 15)));
  }
  while ( !zombies4_nextfield.isEmpty() ) {
    zombies4_nextfield.remove(0);
    zombies4_offfield.add( new Zombie(800, 455, 100 + (levelNum * 15)));
  }
  while ( !zombies5_nextfield.isEmpty() ) {
    zombies5_nextfield.remove(0);
    zombies5_offfield.add( new Zombie(800, 575, 100 + (levelNum * 15)));
  }
  for (int x = 1; x <= random(2); x++) {
    zombies1_offfield.add( new Zombie(800, 95, 100 + (levelNum * 15)));
  }
  for (int x = 1; x <= random(2); x++) {
    zombies2_offfield.add( new Zombie(800, 215, 100 + (levelNum * 15)));
  }
  for (int x = 1; x <= random(2); x++) {
    zombies3_offfield.add( new Zombie(800, 335, 100 + (levelNum * 15)));
  }
  for (int x = 1; x <= random(2); x++) {
    zombies4_offfield.add( new Zombie(800, 455, 100 + (levelNum * 15)));
  }
  for (int x = 1; x <= random(2); x++) {
    zombies5_offfield.add( new Zombie(800,575, 100 + (levelNum * 15)));
  }
}

void draw() {
  ArrayList<Projectile> arr = null;
  frameRate(40); //sets basic parameters
  if (!start) {//start screen
    background(0, 0, 0);
    display();
  } else {//everything else (game)
    background(25, 150, 25); 
    display();
    time ++;
    r1time += (int)random(0, 4);
    r2time += (int)random(0, 4);
    r3time += (int)random(0, 4);
    r4time += (int)random(0, 4);
    r5time += (int)random(0, 4);
    if (time%300 == 0 && sunspots.size() < 5) {
      sunspots.add(new Sunlight(random(800), 0));
    }
    for (Sunlight x : sunspots) {  
      x.move();
    }

    for (int i = 0; i < plants.length; i++) {
      for (int j = 0; j < plants[i].length; j++) {
        if (plants[i][j] != null && plants[i][j].getState() == 0) { //removes dead plant from the field 
          if(i == 0) {
            for(int n = 0; n < projectile1.size(); n++) {
              if(projectile1.get(n).getSignature() == plants[i][j].getX() ) {
                projectile1.remove(n);
                n--;
              }
            }
          }
          if(i == 1) {
            for(int n = 0; n < projectile2.size(); n++) {
              if(projectile2.get(n).getSignature() == plants[i][j].getX() ) {
                projectile2.remove(n);
                n--;
              }
            }
          }
          if(i == 2) {
            for(int n = 0; n < projectile3.size(); n++) {
              if(projectile3.get(n).getSignature() == plants[i][j].getX() ) {
                projectile3.remove(n);
                n--;
              }
            }
          }
          if(i == 3) {
            for(int n = 0; n < projectile4.size(); n++) {
              if(projectile4.get(n).getSignature() == plants[i][j].getX() ) {
                projectile4.remove(n);
                n--;
              }
            }
          }
          if(i == 4) {
            for(int n = 0; n < projectile5.size(); n++) {
              if(projectile5.get(n).getSignature() == plants[i][j].getX() ) {
                projectile5.remove(n);
                n--;
              }
            }
          }             
          plants[i][j] = null;
        }
        if (plants[i][j] != null) {//move projectiles
          plants[i][j].move();

          if (plants[i][j].getType() == 1) {  //takes projectiles from peashooters into heap
            arr = ((Peashooter)(plants[i][j])).getProjectiles();
          }
          if (arr != null && i == 0 && time % 30 == 0 ) {
            projectile1.add(arr.get(arr.size()-1) );
          } else if (arr!= null && i == 1 && time % 30 == 0) {
            projectile2.add(arr.get(arr.size()-1) );
          } else if (arr != null && i == 2 && time % 30 == 0) {
            projectile3.add(arr.get(arr.size()-1) );
          } else if (arr != null && i == 3 && time % 30 == 0) {
            projectile4.add(arr.get(arr.size()-1) );
          } else if (arr != null && i == 4 && time % 30 == 0) {
            projectile5.add(arr.get(arr.size()-1) );
          }
        }
      }
    }
  }
  if (levelDone || !levelClick) {
    projectile1 = new ArrayList<Projectile>();
    projectile2 = new ArrayList<Projectile>();
    projectile3 = new ArrayList<Projectile>();
    projectile4 = new ArrayList<Projectile>();
    projectile5 = new ArrayList<Projectile>();
    background(0);
    textSize(72);
    fill(255);
    text("level " + levelNum + " done", 175, 250);
    noLoop();
    levelDone = false;
    resetLevel();
  }

  if (start && !levelDone) { //runs game for each row
    drawRow(projectile1, zombies1_offfield, zombies1_onfield, zombies1_nextfield, r1time, 0); 
    drawRow(projectile2, zombies2_offfield, zombies2_onfield, zombies2_nextfield, r2time, 1); 
    drawRow(projectile3, zombies3_offfield, zombies3_onfield, zombies3_nextfield, r3time, 2); 
    drawRow(projectile4, zombies4_offfield, zombies4_onfield, zombies4_nextfield, r4time, 3); 
    drawRow(projectile5, zombies5_offfield, zombies5_onfield, zombies5_nextfield, r5time, 4);
    if (zombies1_offfield.isEmpty() && zombies1_onfield.isEmpty() && 
      zombies2_offfield.isEmpty() && zombies2_onfield.isEmpty() && 
      zombies3_offfield.isEmpty() && zombies3_onfield.isEmpty() && 
      zombies4_offfield.isEmpty() && zombies4_onfield.isEmpty() && 
      zombies5_offfield.isEmpty() && zombies5_onfield.isEmpty()) { 
      levelDone = true;
      levelClick = false;
      levelNum++;
    }
  }
}


void display() { 
  if (info) {
    textSize(18);    
    fill(255);    
    text("You play a homeowner in the midst of a zombie apocalypse.", 100, 100);    
    text("Your name is Al and you are an avid plant grower.", 100, 150);    
    text("You sing to plants and somehow get them to grow immediately.", 100, 200);    
    text("However, you need sunlight to grow these plants.", 100, 250);    
    text("It's a good thing you have a sunflower plant then!", 100, 300);    
    text("Sunlight also falls from the sun, so be sure to pick them up.", 100, 350);    
    text("Your other plants shoot projectiles that damage the zombies.", 100, 400);    
    fill(256, 0, 0);    
    text("Your goal is to kill all of the zombies to protect yourself", 100, 490);    
    text("from the zombies getting into your house and eating your brains.", 100, 520);    
    fill(255);    
    text("Good luck, and may the odds be ever in your favor.", 100, 600);    
    rect(625, 5, 150, 75, 15);    
    fill(0);    
    text("Start", 680, 50);
  } else if (!start) {
    rect(300, 280, 200, 100, 15);
    rect(300, 450, 200, 100, 15);
    fill(0);
    textSize(18);
    text("Start", 380, 335);
    text("Info", 383, 505);
    fill(255);
    textSize(72);    
    text("V.T.L.F.C.U.H.C.", 130, 150);
  } else {
    //line separation of field and store
    fill(150); 
    stroke(0);
    line(0, 60, 800, 60);

    //line separating rows for field
    stroke(255);
    line(0, 180, 800, 180);
    line(0, 300, 800, 300);
    line(0, 420, 800, 420);
    line(0, 540, 800, 540);

    //line separating columns for field
    line(100, 60, 100, 660);
    line(200, 60, 200, 660);
    line(300, 60, 300, 660);
    line(400, 60, 400, 660);
    line(500, 60, 500, 660);
    line(600, 60, 600, 660);
    line(700, 60, 700, 660);

    //sunlight statistic showing
    fill(0);
    textSize(18);
    text("sunlight", 15, 25);
    text(sunlight, 30, 50);
    text("cost:", 120, 50);
    text("||", 93, 25);
    text("||", 93, 50);
    text("peashooter", 190, 25);
    text("50", 225, 50);
    text("||", 293, 25);
    text("sunflower", 308, 25);
    text("50", 338, 50);
    text("||", 393, 25);
    text("wallnut", 418, 25);
    text("100", 430, 50);
    text("||", 493, 25);
    text("chomper", 512, 25);
    text("100", 530, 50);
    text("||", 593, 25);
    text("||", 593, 50);
    text("remove", 613, 38);
    text("||", 685, 25);
    text("||", 685, 50);
    text("reset", 727, 50);
    if (plantclicked == 0) {
      text("none", 728, 25);
    } else if (plantclicked == -1) {
      text("remove", 717, 25);
    } else if (plantclicked == 1) {
      text("peashooter", 700, 25);
    } else if (plantclicked == 2) {
      text("sunflower", 708, 25);
    } else if (plantclicked == 3) {
      text("wallnut", 718, 25);
    } else if (plantclicked == 4) {
      text("chomper", 710, 25);
    }
  }
}
void mouseClicked() {
  if (info) {
    if (mouseX >= 625 && mouseX <= 775 && mouseY >= 5 && mouseY <= 80) { 
      start = true;    
      info = false;
    }
  } else if (!start) {//checks if start button clicked 
    if (mouseX >= 300 && mouseX <= 500 && mouseY >= 280 && mouseY <= 380) {
      start = true;
    }
    if (mouseX >= 300 && mouseX <= 500 && mouseY >= 450 && mouseY <= 550) {
      info = true;
    }
  } else if (levelClick == false) {
    if (mouseX > 0 && mouseY > 0) {
      levelClick = true;
      loop();
    }
  } else {  //checks if dropped Sunlight hit 
    for (int i = 0; i < sunspots.size(); i++) {
      if (sunspots.get(i).hit(mouseX, mouseY)) {
        sunlight += 25;
        sunspots.remove(i);
      }
    }
    for (int r = 0; r < plants.length; r++) {  //checks if Sunflower generated Sunlight hit
      for (Plant x : plants[r]) {
        if ( x != null && x.getType() == 2) {
          for (int i = 0; i < ((Sunflower)x).getDropped().size(); i++) {
            if ( ((Sunflower)x).getDropped().get(i).hit(mouseX, mouseY)) {
              sunlight += 10;
              ((Sunflower)x).getDropped().remove(i);
            }
          }
        }
      }
    }
    int r = (mouseY - 60) / 120;
    int c = mouseX / 100;
    if (plantclicked == -1 && plants[r][c] != null && get(mouseX, mouseY) != color(255, 215, 0)) {
      plants[r][c].setState(0);
      plantclicked = 0;
    } 
    if (plantclicked != 0 && mouseY > 60 && get(mouseX, mouseY) == color(25, 150, 25)) {  //checks if plant placement option selected , places appropriate plant 
      if (plants[r][c] == null) {
        if (plantclicked == 1) {
          plants[r][c] = new Peashooter(c*100+25, r*120+95);
          sunlight -= 50;
        } else if (plantclicked == 2) {
          plants[r][c] = new Sunflower(c*100+25, r*120+95);
          sunlight -= 50;
        } else if (plantclicked == 3) {
          plants[r][c] = new Wallnut(c*100+25, r*120+95);
          sunlight -= 100;
        } else if (plantclicked == 4) {
          plants[r][c] = new Chomper(c*100+25, r*120+95);
          sunlight -= 100;
        }
        plantclicked = 0;
      }
    }
    if (mouseX >= 727 && mouseX <= 780 && mouseY >= 35 && mouseY <= 60 ) {
      System.out.println("reset");
      plantclicked = 0;
    } else if (mouseX >= 600 && mouseX <= 690 && mouseY >= 10 && mouseY <= 60) {
      System.out.println("remove");
      plantclicked = -1;
    } else if (sunlight >= 50 && mouseX >= 190 && mouseX <= 290 && mouseY >= 10 && mouseY <= 35 ) { //detects click on peashooter button
      System.out.println("peashooter hit");
      plantclicked = 1;
    } else if ( sunlight >= 50 && mouseX >= 300 && mouseX <= 400 && mouseY >= 10 && mouseY <= 35 ) { //detects click on sunflower button
      System.out.println("sunflower hit");
      plantclicked = 2;
    } else if ( sunlight >= 50 && mouseX >= 400 && mouseX <= 500 && mouseY >= 10 && mouseY <= 35 ) { //detects click on wallnut button
      System.out.println("wallnut hit");
      plantclicked = 3;
    } else if ( sunlight >= 50 && mouseX >= 500 && mouseX <= 600 && mouseY >= 10 && mouseY <= 35 ) { //detects click on wallnut button
      System.out.println("chomper hit");
      plantclicked = 4;
    }
  }
} 