class Sunflower {

  int x; //x-pos of plant, doesn't change
  int y; //y-pos of plant, doesn't change
  int health;
  int state;

  //default constructor
  Sunflower() {
    health = 100;
    x = 25;
    y = 100;
    state = 1;
  }
  
  Sunflower (int xcor, int ycor){
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
  
  void setHealth(int damage) {
    health -= damage;
  }

  void setState(int newState) {
    state = newState;
  }
  
   void die() {
    if (health <= 0) {
      state = 0;
    }
  }
  
  void display() {
    fill(255, 255, 0);
    rect(x, y, 50, 50);
  }

  void move() {
    die();
    display();
  }
}