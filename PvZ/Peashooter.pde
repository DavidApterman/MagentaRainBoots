class Peashooter extends Plant {

  int x; //x-pos of plant, doesn't change
  int y; //y-pos of plant, doesn't change
  int health; //hp of plant 
  int damage; //damage inflicted by projectiles
  ArrayList<Projectile> projectiles; //stores shots being fired by plant
  int shotCounter; //forces intervals between shots 
  int type; //tells game which type of plant it's dealing with
  int state; //checker for if plant has died 

  //default constructor
  Peashooter() {
    health = 100;
    x = 25;
    y = 100;
    state = 1;
    damage = 15;
    shotCounter = 0;
    projectiles = new ArrayList<Projectile>(10);
    type = 1;
  }

  Peashooter (int xcor, int ycor) {
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
  ArrayList<Projectile> getProjectiles() {
    return projectiles;
  }
  int getDamage() {
    return damage;
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

  //~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

  void die() {
    if (health <= 0) {
      state = 0;
    }
  }

  void shoot() {
    if (shotCounter % 30 == 0) { //interval shots
      Projectile proj = new Projectile(x, y, damage, x);
      projectiles.add(proj);
    }
    shotCounter++;
  } 

  void display() {
    fill(0, 255, 0);
    rect(x, y, 50, 50);
  }

  void move() {
    die();          //remove if dead (ready)
    display();      //display if not (aim)
    shoot();        //FIRE
    for (int i = 0; i < projectiles.size()-1; i++) {
      projectiles.get(i).move();  //updates projectile x-coordinate (displayment of projectiles dependent on master heap)
    }
  }
}