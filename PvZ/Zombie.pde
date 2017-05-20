class Zombie {

  float x;
  float y;
  color c;
  int state;

  //default constructor
  Zombie() {
    float r = random(256);
    float g = random(256);
    float b = random(256);
    c = color(r, g, b);
    x = 800;
    y = 100;
    //y = ((int) random(5)) * 120 + 100;
    state = 0;
  }

  //overloaded constructor
  Zombie(int xCor, int yCor) {
    this();
    x = xCor;
    y = yCor; 
    state = 1;
  }

  //accessors
  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  color getColor() {
    return c;
  }
  int getState() {
    return state;
  }

  //mutators
  void setX(float newX) {
    x = newX;
  }
  void setY(float newY) {
    y = newY;
  }
  void setColor(color newC) {
    c = newC;
  }
  void setState(int newState) {
    state = newState;
  }

  //displays the zombie
  void display() {
    if (x == -25){
      fill(255, 0, 0);
    }
    else{
      fill(150);
    }
    noStroke();
    rect(x, y, 50, 50);
  }

  void move() { 
    display();
    x -= 1;
  }
}