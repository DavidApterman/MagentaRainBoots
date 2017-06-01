class Plant {

  int x; //x-pos of plant, doesn't change
  int y; //y-pos of plant, doesn't change
  int health; //hp of plant 
  //int damage; //damage inflicted by projectiles
  //int range; 
  //ArrayList<Projectile> projectiles; //stores shots being fired by plant
  //int shotCounter; //forces intervals between shots 
  int type;
  int state;

  //default constructor
  Plant() {
    health = 100;
    x = 25;
    y = 100;
    //range = x + 400;
    state = 1;
  }
  
  Plant (int xcor, int ycor){
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
    fill(0, 255, 0);
    rect(x, y, 50, 50);
  }

  void move() {
    die();
    display();
    }
  }