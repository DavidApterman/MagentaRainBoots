class Sunlight {

  float x; // x-position of ball in row
  float y; // y-position of ball, should not be changed post-generation
  //int speed; //determines how fast projectile moves down the row
  color c;
  int state;

  Sunlight() {
    float r = 255;
    float g = 215;
    float b = 0;
    c = color(r, g, b);
    state = 1;
  }

  Sunlight( float xCor, float yCor) {
    this();
    x = xCor;
    y = yCor;
  }

  //accessors
  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  //mutators
  void setX(float newX) {
    x = newX;
  }
  void setY(float newY) {
    y = newY;
  }
  boolean hit(int mouseX, int mouseY) {
    if( mouseX > getX() - 25 && mouseX < getX() + 25 && mouseY > getY() - 25 && mouseY < getY() + 25) {
      setY(-25);
      return true;
    }
    else {
      return false;
    }
  }

  void display() {
    fill(c);
    noStroke();
    ellipse(x+25, y+25, 25, 25);
  }

  void move() {
    display();
    int a = (int)random(100,600);
    if(y < a + 1 && y > a - 1 || y >= 600){
    state = 0;
    }
    if(state != 0) {
      y += 1;
    }
  }
}