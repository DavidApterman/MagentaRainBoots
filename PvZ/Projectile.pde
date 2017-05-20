class Projectile {

  int x; // x-position of ball in row
  int y; // y-position of ball, should not be changed post-generation
  int speed; //determines how fast projectile moves down the row
  int damage; //determines the bang of your buck
  color c;
  
  Projectile() {
    float r = 10;
    float g = 255;
    float b = 10;
    c = color(r, g, b);
  }

  Projectile( int xCor, int yCor, int dmg) {
    this();
    x = xCor;
    y = yCor;
    damage = dmg;
    //  ellipse(xCor, yCor, 10, 10);
  }
  
   float getX(){
    return x;
  }
  float getY(){
    return y;
  }
  
  void display() {
    fill(c);
    noStroke();
    ellipse(x+25, y+25, 10, 10);
  }

  void move() {
    display();
    x += 2;
  }
}
