import java.util.PriorityQueue;

Zombie test = new Zombie();
Zombie test1 = new Zombie(600,100);
Zombie test2 = new Zombie();
Plant testp = new Plant();
PriorityQueue<Zombie> zombies1_offfield = new PriorityQueue<Zombie>();
PriorityQueue<Zombie> zombies1_onfield = new PriorityQueue<Zombie>();
PriorityQueue<Zombie> zombies1_nextfield = new PriorityQueue<Zombie>();
int time = 0;

void setup(){
  size(800,660); //generates board
  background(25, 150, 25); //sets board color 
  //zombies1.add(test);
  //try{
    zombies1_onfield.add(test);
    zombies1_offfield.add(test2);
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
      zombies1_onfield.add(zombies1_offfield.remove());
    }
  }
  for (Zombie x : zombies1_onfield){
    if (x.getX() == -25){
      x.display();
      textSize(32);
      text("game over", 350, 300);
      noLoop();
    }
    else{
      x.move();
    }
    for (int i = 0; i < testp.getProjectiles().size(); i++){
      if (testp.getProjectiles().get(i).getX() + 5 == x.getX() - 25){
        x.setHealth(testp.getProjectiles().get(i).getDamage());
        System.out.println(x.getHealth());
        System.out.println(x.getState());
        if(x.getState() == 0) { 
          zombies1_nextfield.add(x);
          zombies1_onfield.remove(x);
        }
        testp.getProjectiles().remove(i);
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