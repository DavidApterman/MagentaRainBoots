class Chomper extends Plant{

  int x; //x-pos of plant, doesn't change
  int y; //y-pos of plant, doesn't change
  int health; //hp of plant 
  int type; //tells game which type of plant it's dealing with
  int state; //checker for if plant has died 

  //default constructor
  Chomper() {
    health = 1;
    x = 25;
    y = 100;
    state = 1;
    type = 4;
  }

  Chomper(int xcor, int ycor) {
    this();
    x = xcor;
    y = ycor;
  }

  //accessors
  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  int getState() {
    return state;
  }
  int getType() {
    return type;
  }

  //mutators
  void setHealth(int damage) {
    health -= damage;
  }

  void setState(int newState) {
    state = newState;
  }
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  

  void die() {
    if (health <= 0) {
      state = 0;
    }
  }

  void display() {
    fill(75, 0, 130);
    rect(x, y, 50, 50);
  }

  void move() {
    die();
    display();
  }
}