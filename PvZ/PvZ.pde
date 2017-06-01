//import java.util.*;

ArrayList<Zombie> zombies1_offfield = new ArrayList<Zombie>(); //all zombies for level
ArrayList<Zombie> zombies1_onfield = new ArrayList<Zombie>();  //all zombies currently on screen
ArrayList<Zombie> zombies1_nextfield = new ArrayList<Zombie>();


ArrayList<Zombie> zombies2_offfield = new ArrayList<Zombie>(); //all zombies for level
ArrayList<Zombie> zombies2_onfield = new ArrayList<Zombie>();  //all zombies currently on screen
ArrayList<Zombie> zombies2_nextfield = new ArrayList<Zombie>();


ArrayList<Zombie> zombies3_offfield = new ArrayList<Zombie>(); //all zombies for level
ArrayList<Zombie> zombies3_onfield = new ArrayList<Zombie>();  //all zombies currently on screen
ArrayList<Zombie> zombies3_nextfield = new ArrayList<Zombie>();


ArrayList<Zombie> zombies4_offfield = new ArrayList<Zombie>(); //all zombies for level
ArrayList<Zombie> zombies4_onfield = new ArrayList<Zombie>();  //all zombies currently on screen
ArrayList<Zombie> zombies4_nextfield = new ArrayList<Zombie>();


ArrayList<Zombie> zombies5_offfield = new ArrayList<Zombie>(); //all zombies for level
ArrayList<Zombie> zombies5_onfield = new ArrayList<Zombie>();  //all zombies currently on screen
ArrayList<Zombie> zombies5_nextfield = new ArrayList<Zombie>();

ArrayList<Sunlight> sunspots = new ArrayList<Sunlight>(); 

Plant[][] plants = new Plant[5][8];
//ALHeap projectile1 = new ALHeap();
//ALHeap projectile2 = new ALHeap();
//ALHeap projectile3 = new ALHeap();
//ALHeap projectile4 = new ALHeap();
//ALHeap projectile5 = new ALHeap();
ArrayList<Projectile> projectile1 = new ArrayList<Projectile>();
ArrayList<Projectile> projectile2 = new ArrayList<Projectile>();
ArrayList<Projectile> projectile3 = new ArrayList<Projectile>();
ArrayList<Projectile> projectile4 = new ArrayList<Projectile>();
ArrayList<Projectile> projectile5 = new ArrayList<Projectile>();
int time = 0;
int sunlight = 500;
boolean plantclicked = false;
boolean start = false;

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

void drawRow(ArrayList<Projectile> heap, ArrayList<Zombie> off, ArrayList<Zombie> on, ArrayList<Zombie> next) {


  if (time % 300 == 0) { //maintain rate of zombies
    if (!off.isEmpty()) {
      on.add(off.remove(0)); //if there are more zombies to spawn, by all means
    }
  }
  
    for (int i = 0; i < plants[rowNum].length; i++) {
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
    else if (p != null && p.getX() + 25 >= on.get(x).getX() - 25) {
      p.setHealth(on.get(x).getDamage() );
      on.get(x).display();
      }
      else {
      on.get(x).move();
    }
    // System.out.println(heap.peekMin() );
    for (int i = 0; i < heap.size(); i++) {
      if (x < on.size() &&
        heap.get(i).getX() + 5 >= on.get(x).getX() - 25 &&
        heap.get(i).getX() + 5 <= on.get(x).getX() - 20) {  //checks collision between shot and zombie
        //System.out.println("projectiles size: " + testp.getProjectiles().size());
        System.out.println("collision detected ");
        on.get(x).setHealth(heap.get(i).getDamage()); //damage zombies
        //System.out.println(zombies1_onfield.get(x).getHealth());  //s.o.p
        //System.out.println(zombies1_onfield.get(x).getState());
        if (on.get(x).getState() == 0) {   //if a zombe is dead, off it goes off the screen and to zombie heaven
          next.add(on.get(x)); //add to nextfield
          on.remove(on.get(x)); //remove zombies after death
          if (on.isEmpty()) { //for changes in # of zombies1_onfield during runtime
            return;
          }
        }
        heap.remove(i);
        // System.out.println(heap.removeMin()); //projectile is removed from screen
        //   System.out.println("projectile removed");
      }
    }
  }
  for (Projectile j : heap ) {
    j.display();
  }
}

void setup() {
  size(800, 660); //generates board
  background(25, 150, 25); //sets board color 
  for (int i = 0; i < 4; i++) {
    Zombie test = new Zombie(800, 95);
    zombies1_offfield.add(test);
  }
  for (int i = 0; i < 4; i++) {
    Zombie test2 = new Zombie(800, 215);
    zombies2_offfield.add(test2);
  }
  for (int i = 0; i < 4; i++) {
    Zombie test3 = new Zombie(800, 335);
    zombies3_offfield.add(test3);
  }
  for (int i = 0; i < 4; i++) {
    Zombie test4 = new Zombie(800, 455);
    zombies4_offfield.add(test4);
  }
  for (int i = 0; i < 4; i++) {
    Zombie test5 = new Zombie(800, 575);
    zombies5_offfield.add(test5);
  }
}

void draw() {
  frameRate(60); //sets basic parameters
  if (start == false) {
    background(0, 0, 0);
    display();
  } else {
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
      if (plants[i][j] != null && plants[i][j].getState() == 0) {
        plants[i][j] = null;
      }
      if (plants[i][j] != null) {//move projectiles
        plants[i][j].move();
          //System.out.println("plant moved");
          ArrayList<Projectile> arr = plants[i][j].getProjectiles();
          if (i == 0 && time % 30 == 0) {
            projectile1.add(arr.get(arr.size()-1) );
            // System.out.println(time);
            //System.out.println("projectile added to heap");
          }
          if (i == 1 && time % 30 == 0) {
            projectile2.add(arr.get(arr.size()-1) );
          } else if (i == 2 && time % 30 == 0) {
            projectile3.add(arr.get(arr.size()-1) );
          } else if (i == 3 && time % 30 == 0) {
            projectile4.add(arr.get(arr.size()-1) );
          } else if (i == 4 && time % 30 == 0) {
            projectile5.add(arr.get(arr.size()-1) );
          }
        }
      }
    }
  }
  if (start == true) {
    drawRow(projectile1, zombies1_offfield, zombies1_onfield, zombies1_nextfield); 
    drawRow(projectile2, zombies2_offfield, zombies2_onfield, zombies2_nextfield); 
    drawRow(projectile3, zombies3_offfield, zombies3_onfield, zombies3_nextfield); 
    drawRow(projectile4, zombies4_offfield, zombies4_onfield, zombies4_nextfield); 
    drawRow(projectile5, zombies5_offfield, zombies5_onfield, zombies5_nextfield);
  }






  /*
      if (//x < zombies1_onfield.size() &&
   testp.getProjectiles().get(0).getX() + 5 >= zombies1_onfield.get(x).getX() - 25 &&
   testp.getProjectiles().get(0).getX() + 5 <= zombies1_onfield.get(x).getX() - 20) {  //checks collision between shot and zombie
   //System.out.println("projectiles size: " + testp.getProjectiles().size());
   zombies1_onfield.get(x).setHealth(testp.getProjectiles().get(i).getDamage()); //damage zombies
   //System.out.println(zombies1_onfield.get(x).getHealth());  //s.o.p
   //System.out.println(zombies1_onfield.get(x).getState());
   if (zombies1_onfield.get(x).getState() == 0) {   //if a zombe is dead, off it goes off the screen and to zombie heaven
   zombies1_nextfield.add(zombies1_onfield.get(x)); //add to nextfield
   zombies1_onfield.remove(zombies1_onfield.get(x)); //remove zombies after death
   if (zombies1_onfield.isEmpty()) { //for changes in # of zombies1_onfield during runtime
   return;
   }
   }
   testp.getProjectiles().remove(i); //projectile is removed from screen
   }
   */


  //System.out.println(width);
  //System.out.println(test.y);
}

void display() { 
  if (start == false) {
    rect(300,280, 200, 100, 15);
    //fill(200);
    text("Start", 400, 315);
  } 
  else {
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
    text("sunlight", 25, 25);
    text(sunlight, 25, 50);
    text("||", 100, 25);
    text("plant", 125, 25);
    text("||", 175, 25);//test
  }
}
void mouseClicked() {
  if (start == false) {
    if (mouseX >= 300 && mouseX <= 500 && mouseY >= 280 && mouseY <= 380) {
      start = true;
    }
  } else {
    for (int i = 0; i < sunspots.size(); i++) {
      if (sunspots.get(i).hit(mouseX, mouseY)) {
        sunlight += 25;
        sunspots.remove(i);
      }
    }
    if (plantclicked) {
      int r = (mouseY - 60) / 120;
      int c = mouseX / 100;
      plants[r][c] = new Plant(c*100+25, r*120+95);
      plantclicked = false;
      sunlight -= 50;
    }
    if (sunlight >= 50 && mouseX >= 110 && mouseX <= 175 && mouseY >= 10 && mouseY <= 35 ) {
      System.out.println("plant hit");
      plantclicked = true;
    }
  }
}
