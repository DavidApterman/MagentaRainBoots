//import java.util.*;

Zombie test = new Zombie();
Zombie test1 = new Zombie(300,100);
Zombie test2 = new Zombie();
Zombie test3 = new Zombie(600,100);
Plant testp = new Plant();
ArrayList<Zombie> zombies1_offfield = new ArrayList<Zombie>(); //all zombies for level
ArrayList<Zombie> zombies1_onfield = new ArrayList<Zombie>();  //all zombies currently on screen
ArrayList<Zombie> zombies1_nextfield = new ArrayList<Zombie>();
int time = 0;

void setup(){
  size(800,660); //generates board
  background(25, 150, 25); //sets board color 
  //zombies1.add(test);
  //try{
    zombies1_onfield.add(test);
    zombies1_offfield.add(test1);
    zombies1_offfield.add(test2);
    zombies1_offfield.add(test3);
    
  //}
  /*
  catch(ClassCastException e){
    System.out.println("error on zombie add");
    exit();
  }
  */
}

void draw(){
  frameRate(60); //sets basic parameters
  background(25, 150, 25); 
  display();
  time += 1;
  if (time % 300 == 0){
    if (!zombies1_offfield.isEmpty()){
      zombies1_onfield.add(zombies1_offfield.remove(0)); //if there are more zombies to spawn, by all means
    }
  }
  for (int x = 0; x < zombies1_onfield.size(); x++){ //checks if a zombie has reached the end of the row, which would cause a game over
    if (zombies1_onfield.get(x).getX() <= -25){
      zombies1_onfield.get(x).display();
      textSize(32);
      text("game over", 350, 300);
      noLoop();
    }
    else{
      zombies1_onfield.get(x).move();
    }
    for (int i = 0; i < testp.getProjectiles().size(); i++){   
      if (x < zombies1_onfield.size() && testp.getProjectiles().get(i).getX() + 5 >= zombies1_onfield.get(x).getX() - 25 && testp.getProjectiles().get(i).getX() + 5 <= zombies1_onfield.get(x).getX() - 20){  //checks collision between shot and zombie
        System.out.println("projectiles size: " + testp.getProjectiles().size());
        zombies1_onfield.get(x).setHealth(testp.getProjectiles().get(i).getDamage());
        System.out.println(zombies1_onfield.get(x).getHealth());  //s.o.p
        System.out.println(zombies1_onfield.get(x).getState());
        if(zombies1_onfield.get(x).getState() == 0) {   //if a zombe is dead, off it goes off the screen and to zombie heaven
          zombies1_nextfield.add(zombies1_onfield.get(x));
          zombies1_onfield.remove(zombies1_onfield.get(x));
          if(zombies1_onfield.isEmpty()){
            return;
          }
        }
        testp.getProjectiles().remove(i); //projectile is removed from screen
      }
      }
    }
  testp.move();
  //System.out.println(width);
  //System.out.println(test.y);
  }

void display(){ 
    fill(150);
    stroke(0);
    line(0, 60, 800, 60);
    stroke(255);
    line(0, 180, 800, 180);
    line(0, 300, 800, 300);
    line(0, 420, 800, 420);
    line(0, 540, 800, 540);
    fill(0);
    textSize(18);
    text("sunlight", 25, 25);
}
void mouseClicked(){
  
}