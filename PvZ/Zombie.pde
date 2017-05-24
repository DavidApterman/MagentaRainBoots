class Zombie implements Comparable {

  float x;
  float y;
  int health;
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
    health = 100;
    //y = ((int) random(5)) * 120 + 100;
    state = 1;
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
  int getHealth() {
    return health;
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
  void setHealth(int damage) {
    health -= damage;
  }
  void setColor(color newC) {
    c = newC;
  }
  void setState(int newState) {
    state = newState;
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

  void die() {
    if (health <= 10) {
      state = 0;
    }
  }
  void move() { 
    die();
    display();
    x -= 1;
  }

  // void hit( Projectile p){
  //   if (p.getX() + 5 <= x - 20){


  int compareTo(Object other) {
    if (x > ((Zombie) other).getX()) {
      return -1;
    } else if (x == ((Zombie) other).getX()) {
      return 0;
    } else {
      return 1;
    }
  }
}