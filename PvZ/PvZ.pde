import java.util.PriorityQueue;

Zombie test = new Zombie();
Plant testp = new Plant();
PriorityQueue<Zombie> zombies1 = new PriorityQueue<Zombie>();

void setup(){
  size(800,660); //generates board
  background(25, 150, 25); //sets board color 
  zombies1.add(test);
}

void draw(){
  frameRate(30); //sets basic parameters
  background(25, 150, 25); 
  display();
  for (Zombie x : zombies1){
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
      if(testp.getProjectiles().get(i).getX() + 10 == x.get(X) - 50){
        testp.getProjectiles().remove(i);
      }
    }
  }
  testp.move();
  //System.out.println(width);
  System.out.println(test.y);
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