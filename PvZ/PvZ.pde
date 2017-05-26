//import java.util.*;

Zombie test = new Zombie();
Zombie test1 = new Zombie(300, 100);
Zombie test2 = new Zombie();
Zombie test3 = new Zombie(600, 100);
Plant testp = new Plant(25, 100);
ArrayList<Zombie> zombies1_offfield = new ArrayList<Zombie>(); //all zombies for level
ArrayList<Zombie> zombies1_onfield = new ArrayList<Zombie>();  //all zombies currently on screen
ArrayList<Zombie> zombies1_nextfield = new ArrayList<Zombie>();
ArrayList<Sunlight> sunspots = new ArrayList<Sunlight>(); 
int time = 0;
int sunlight = 50;
boolean plantclicked = false;

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
  zombies1_onfield.add(test);
  zombies1_offfield.add(test1);
  zombies1_offfield.add(test2);
  zombies1_offfield.add(test3);
}

void draw() {
  frameRate(60); //sets basic parameters
  background(25, 150, 25); 
  display();
  time += 1;
  if(time%300 == 0 && sunspots.size() < 5) {
    sunspots.add(new Sunlight(random(800), 0));
  }
  for(Sunlight x:sunspots) {
    x.move();
  }
  if (time % 300 == 0) { //maintain rate of zombies
    if (!zombies1_offfield.isEmpty()) {
      zombies1_onfield.add(zombies1_offfield.remove(0)); //if there are more zombies to spawn, by all means
    }
  }
  for (int x = 0; x < zombies1_onfield.size(); x++) { //checks if a zombie has reached the end of the row, which would cause a game over
    if (zombies1_onfield.get(x).getX() <= -25) { //if true, zombie reached end
      zombies1_onfield.get(x).display();
      textSize(32);
      text("game over", 350, 300);
      noLoop();
    }
    else {
      zombies1_onfield.get(x).move();
    }
    for (int i = 0; i < testp.getProjectiles().size(); i++) {   
      if (x < zombies1_onfield.size() &&
          testp.getProjectiles().get(i).getX() + 5 >= zombies1_onfield.get(x).getX() - 25 &&
          testp.getProjectiles().get(i).getX() + 5 <= zombies1_onfield.get(x).getX() - 20) {  //checks collision between shot and zombie
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
    }
  }
  testp.move(); //move projectiles
  //System.out.println(width);
  //System.out.println(test.y);
}

void display() { 
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
  
  //sunlight statistic showing
  fill(0);
  textSize(18);
  text("sunlight", 25, 25);
  text(sunlight, 25, 50);
  text("||", 100, 25);
  text("plant", 125, 25);
  text("||", 175, 25);//test
}
void mouseClicked() {
  for(int i = 0; i < sunspots.size(); i++) {
    if(sunspots.get(i).hit(mouseX,mouseY)) {
      sunlight += 25;
      sunspots.remove(i);
    }
  }
      
  if (mouseX >= 110 && mouseX <= 175 && mouseY >= 10 && mouseY <= 35){
    System.out.println("plant hit");
    plantclicked = true;
  }
  if (plantclicked &&
  (mouseX - 60) / 120 == 1 &&
  mouseY / 100 = 1){
    Plant x = new Plant();//doesnt work yet. fix.
  }
}
