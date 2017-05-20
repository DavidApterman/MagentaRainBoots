class Plant {
  
  int x;
  int y;
  int health;
  int damage;
  int range;
  
  Plant(){
    health = 50;
    damage = 5;
    x = 25;
    y = 100;
    range = x + 400;
  }
  
  float getX(){
    return x;
  }
  float getY(){
    return y;
  }
  
  void display(){
    rect(x, y, 50, 50);
  }
  void shoot(){
    Ball projectile = new Ball(x, y);
  }
}
