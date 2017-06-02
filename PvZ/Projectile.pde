class Projectile implements Comparable {

  float x; // x-position of ball in row
  float y; // y-position of ball, should not be changed post-generation
  int damage; //determines the bang of your buck
  color c;
  //int speed; //determines how fast projectile moves down the row

  //default constructor
  Projectile() {
    float r = 10;
    float g = 255;
    float b = 10;
    c = color(r, g, b);
  }
  //overloaded constructor
  Projectile( int xCor, int yCor, int dmg) {
    this();
    x = xCor;
    y = yCor;
    damage = dmg;
    //  ellipse(xCor, yCor, 10, 10);
  }

  public String toString() {
    return "" + getX();
  }

  //accessors
  float getX() {
    return x;
  }
  float getY() {
    return y;
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
  void setDamage(int newDmg) {
    damage = newDmg;
  }


  void display() {
    fill(c);
    noStroke();
    ellipse(x+25, y+25, 10, 10);
  }

  void move() {
    // display();
    x += 2;
  }

  public int compareTo(Object other) { //comparable for heap
    if (getX() > ((Projectile) other).getX()) {
      return -1;
    } else if (getX() == ((Projectile) other).getX()) {
      return 0;
    } else {
      return 1;
    }
  }
}