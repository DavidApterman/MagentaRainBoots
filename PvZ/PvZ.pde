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
int sunlight = 500;                                                                                     //starting sunlight (currently high for testing)
int plantclicked = 0;                                                                                   //stores type of plant after user selection to place correct breed
boolean start = false;                                                                                  //start screen display boolean
boolean info = false;

//Do not disturb (for now)
//ALHeap projectile1 = new ALHeap();
//ALHeap projectile2 = new ALHeap();
//ALHeap projectile3 = new ALHeap();
//ALHeap projectile4 = new ALHeap();
//ALHeap projectile5 = new ALHeap();

//~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



//mini "draw" method for each row, uses row-specific variables to ensure equivalent/compact running for each row
void drawRow(ArrayList<Projectile> heap, ArrayList<Zombie> off, ArrayList<Zombie> on, ArrayList<Zombie> next, int rowNum) {
  Plant p = null;

  if (time % 300 == 0) { //maintain rate of zombies
    if (!off.isEmpty()) {
      on.add(off.remove(0)); //if there are more zombies to spawn, by all means
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
    } else if (p != null && p.getX() + 25 >= on.get(x).getX() - 25 && p.getX() <= on.get(x).getX()) {    //detects plant-zombie collision
      p.setHealth(on.get(x).getDamage() );
      on.get(x).display();
    } else {                                                                                            //moves zombies forward
      on.get(x).move();
    }

    for (int i = 0; i < heap.size(); i++) {
      if (x < on.size() &&
        heap.get(i).getX() + 5 >= on.get(x).getX() - 25 &&
        heap.get(i).getX() + 5 <= on.get(x).getX() - 20) {  //checks collision between shot and zombie
        on.get(x).setHealth(heap.get(i).getDamage()); //damage zombies

        if (on.get(x).getState() == 0) {   //if a zombie is dead, off it goes off the screen and to zombie heaven
          next.add(on.get(x)); //add to nextfield
          on.remove(on.get(x)); //remove zombies after death
          if (on.isEmpty()) { //for changes in # of zombies1_onfield during runtime
            return;
          }
        }
        heap.remove(i);  //removes projectiles from heap if they hit a zombie
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
  for (int i = 0; i < 4; i++) {//adds zombies to row 1
    Zombie test = new Zombie(800, 95);
    zombies1_offfield.add(test);
  }
  for (int i = 0; i < 4; i++) {//adds zombies to row 2
    Zombie test2 = new Zombie(800, 215);
    zombies2_offfield.add(test2);
  }
  for (int i = 0; i < 4; i++) {//adds zombies to row 3
    Zombie test3 = new Zombie(800, 335);
    zombies3_offfield.add(test3);
  }
  for (int i = 0; i < 4; i++) {//adds zombies to row 4
    Zombie test4 = new Zombie(800, 455);
    zombies4_offfield.add(test4);
  }
  for (int i = 0; i < 4; i++) {//adds zombies to row 5
    Zombie test5 = new Zombie(800, 575);
    zombies5_offfield.add(test5);
  }
}

void draw() {
  ArrayList<Projectile> arr = null;
  frameRate(45); //sets basic parameters
  if (start == false) {//start screen
    background(0, 0, 0);
    display();
  } else {//everything else (game)
    background(25, 150, 25); 
    display();
    time += 1;
    if (time%300 == 0 && sunspots.size() < 5) {
      sunspots.add(new Sunlight(random(800), 0));
    }
    for (Sunlight x : sunspots) {  
      x.move();
    }

    for (int i = 0; i < plants.length; i++) {
      for (int j = 0; j < plants[i].length; j++) {
        if (plants[i][j] != null && plants[i][j].getState() == 0) { //removes dead plant from the field 
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
  if (start == true) { //runs game for each row
    drawRow(projectile1, zombies1_offfield, zombies1_onfield, zombies1_nextfield, 0); 
    drawRow(projectile2, zombies2_offfield, zombies2_onfield, zombies2_nextfield, 1); 
    drawRow(projectile3, zombies3_offfield, zombies3_onfield, zombies3_nextfield, 2); 
    drawRow(projectile4, zombies4_offfield, zombies4_onfield, zombies4_nextfield, 3); 
    drawRow(projectile5, zombies5_offfield, zombies5_onfield, zombies5_nextfield, 4);
  }
}

void display() { 
  if (info == true) {
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
  } else if (start == false) {
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
    text("||", 93, 25);
    text("plant", 128, 25);
    text("||", 193, 25);
    text("sunflower", 208, 25);
    text("||", 293, 25);
  }
}
void mouseClicked() {
  if (info == true) {
    if (mouseX >= 625 && mouseX <= 775 && mouseY >= 5 && mouseY <= 80) { 
      start = true;    
      info = false;
    }
  } else if (start == false) {//checks if start button clicked 
    if (mouseX >= 300 && mouseX <= 500 && mouseY >= 280 && mouseY <= 380) {
      start = true;
    }
    if (mouseX >= 300 && mouseX <= 500 && mouseY >= 450 && mouseY <= 550) {
      info = true;
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

    if (plantclicked != 0) {  //checks if plant placement option selected , places appropriate plant 
      int r = (mouseY - 60) / 120;
      int c = mouseX / 100;
      if (plantclicked == 1) {
        plants[r][c] = new Peashooter(c*100+25, r*120+95);
      } else if (plantclicked == 2) {
        plants[r][c] = new Sunflower(c*100+25, r*120+95);
      }
      plantclicked = 0;
      sunlight -= 50;
    }
    if (sunlight >= 50 && mouseX >= 93 && mouseX <= 193 && mouseY >= 10 && mouseY <= 35 ) { //detects click on peashooter button
      System.out.println("plant hit");
      plantclicked = 1;
    } else if ( sunlight >= 50 && mouseX >= 193 && mouseX <= 293 && mouseY >= 10 && mouseY <= 35 ) { //detects click on sunflower button
      System.out.println("sunflower hit");
      plantclicked = 2;
    }
  }
}  