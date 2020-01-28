// Position is the position of a checkers piece in the board.

class Position {
  private int x, y;
  public final int minX = 1, minY = 1, maxX = 8, maxY = 8;
  
  public Position(int x, int y){
    this.x = x;
    this.y = y;
  }
  
  int getX(){
    return x;
  }
  int getY(){
    return y;
  }
  
  void setX(int val){
    
    if (val <=7 && val >= 1){
    x = val;
    } else {
      println("This x value is out of the boards bounds: x = " + val);
    }
  }
  
  void setY(int val){
     if (val <=7 && val >= 1){
    y = val;
    } else {
      println("This y value is out of the boards bounds: x = " + val);
    }
  }
  
  
  // Returns true if 2 positions are equal
  boolean isA(Position p){
    if (this.x == p.getX() && this.y == p.getY()){
      return true;
    }
    return false;
  }
}
