class Sunflower extends Plant{

  int x; //x-pos of plant, doesn't change
  int y; //y-pos of plant, doesn't change
  int health;
  int state;
  int sunTime;
  
  //default constructor
  Sunflower() {
    health = 100;
    x = 25;
    y = 100;
    state = 1;
    type = 2;
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
  void generate() {
    Sunlight drop = null;
    sunTime ++;
    if(time % 250 == 0) {
      drop = new Sunlight( random(-25,25) + x, random(-35,35) + y);
      drop.setState(0);
    }
    if(drop != null) 
    drop.display();
  }
      
  
   void die() {
    if (health <= 0) {
      state = 0;
    }
  }
  
  void display() {
    fill(100, 255, 0);
    rect(x, y, 50, 50);
  }

  void move() {
    die();
    generate();
    display();
  }
}