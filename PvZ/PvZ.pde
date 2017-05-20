Zombie test = new Zombie();
Plant testp = new Plant();

void setup(){
  size(800,660); //generates board
  background(25, 150, 25); //sets board color 
}

void draw(){
  frameRate(30); //sets basic parameters
  background(25, 150, 25); 
  display();
  test.move();
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
