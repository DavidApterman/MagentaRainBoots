class Ball {
  
  int x;
  int y;
  int speed;
  int damage;
  Ball( int xCor , int yCor){
    ellipse(xCor, yCor, 10, 10);
  }
  void move(){
    x += 5;
  }
}
