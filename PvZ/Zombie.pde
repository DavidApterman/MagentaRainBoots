class Zombie { //implements Comparable {

  float x; // x-position of zombie in row
  float y; // y-position of zombie, should not be changed post-generation
  int health; // if health <= 0, change state to 0
  color c;
  int state; // if state = 0, zombie dies
  int damage;

  //default constructor
  Zombie() {
    float r = random(256);
    float g = random(256);
    float b = random(256);
    c = color(r, g, b);
    x = 800;
    y = 95;
    health = 100;
    //y = ((int) random(5)) * 120 + 100;
    state = 1;
    damage = 1;
  }

  //overloaded constructor
  Zombie(int xCor, int yCor) {
    this();
    x = xCor;
    y = yCor; 
    state = 1;
  }
  Zombie(int xCor, int yCor, int newhealth) {
    this();
    x = xCor;
    y = yCor; 
    health = newhealth;
    state = 1;
  }

  //accessors
  float getX() {
    return x;
  }
  float getY() {
    return y;
  }
  int getHealth() {
    return health;
  }
  color getColor() {
    return c;
  }
  int getState() {
    return state;
  }
  int getDamage() {
    return damage;
  }

  //mutators
  void setX(float newX) {
    x = newX;
  }
  void setY(float newY) {
    y = newY;
  }
  void setHealth(int damage) {
    health -= damage;
  }
  void setColor(color newC) {
    c = newC;
  }
  void setState(int newState) {
    state = newState;
  }
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  void die() {
    if (health <= 0) {
      state = 0;
    }
  }

  //displays the zombie
  void display() {
    if (x == -25) {
      fill(255, 0, 0);
    } else {
      fill(150);
    }
    noStroke();
    rect(x, y, 50, 50);
  }

  void move() { 
    die();
    display();
    x -= 1;
  }
}