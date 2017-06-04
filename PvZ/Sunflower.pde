class Sunflower extends Plant {

  int x; //x-pos of plant, doesn't change
  int y; //y-pos of plant, doesn't change
  int health;
  int state;
  int sunTime;  //times sunlight generation 
  int type;
  ArrayList<Sunlight> dropped = new ArrayList<Sunlight>(); //stores generated Sunlight 


  //default constructor
  Sunflower() {
    health = 50;
    x = 25;
    y = 100;
    state = 1;
    type = 2;
  }

  Sunflower (int xcor, int ycor) {
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
  ArrayList<Sunlight> getDropped() {
    return dropped;
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
  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~  

  void generate() {
    sunTime ++;
    if (sunTime > random(400, 500)) {
      dropped.add( new Sunlight( random(-25, 25) + x, random(-35, 35) + y) );   //generates Sunlight in block around Sunflower 
      dropped.get(dropped.size()-1).setState(0);
      sunTime = 0;
    }
    for (Sunlight s : dropped) {
      s.display();
    }
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
    generate();
  }
}