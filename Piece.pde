
class Piece {
  
  Position position;
  Color teamColor;
  Rank rank;
  color pieceColor;
  color strokeColor;
  
  public Piece(Position position, Color teamColor){
    this.position = position;
    this.teamColor = teamColor;
    this.rank = Rank.SOLDIER;
    switch (teamColor) {
      case RED:
        pieceColor = color(200,0,0);
        strokeColor = color(0);
        break;
      case BLACK:
        pieceColor = color(0);
        strokeColor = color(80);
        break;
    }
  }
  
  
  
  public void setPosition(Position newPosition){
    
      position = newPosition;
    
  }
  
  public void setRank(){
    this.rank = Rank.QUEEN;
  }
  
  Rank getRank(){
    return this.rank;
  }
  void drawPiece(Position p, int startX, int startY, int cellSize){
    
    
    stroke(strokeColor);
    fill(pieceColor);
    
    bezier(60 + startX + p.getX() * cellSize, 30 + startY + p.getY() * cellSize, 
           85 + startX + p.getX() * cellSize, 55 + startY + p.getY() * cellSize,
           40 + startX + p.getX() * cellSize, 92 + startY + p.getY() * cellSize,
           16 + startX + p.getX() * cellSize, 49 + startY + p.getY() * cellSize);
           
    ellipse(40 + startX + p.getX() * cellSize, 40 + startY + p.getY() * cellSize, 50, 50);
    noFill();
    ellipse(40 + startX + p.getX() * cellSize, 40 + startY + p.getY() * cellSize, 25, 25);
    ellipse(40 + startX + p.getX() * cellSize, 40 + startY + p.getY() * cellSize, 33, 33);
  }
  boolean isEqual(Position p){
    if (this.position.getX() == p.getX() && this.position.getY() == p.getY()){
      return true;
    }
    return false;
  }
}

enum Color{
  RED, BLACK;
}

enum Rank {
  SOLDIER, QUEEN;
}
