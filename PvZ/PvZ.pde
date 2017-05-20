Zombie test = new Zombie();

void setup(){
  size(800, 600);
  background(0); 
}

void draw(){
  frameRate(30);
  background(0); 
  test.move();
  System.out.println(width);
  //System.out.println(test.y);
}

void mouseClicked(){
  
}