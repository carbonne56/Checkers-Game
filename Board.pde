
class Board {
  // True holds a Piece
  final boolean[][] board = new boolean[8][8];
  int startX, startY;
  private final int cellSize = 80;
  Position highlighted = new Position(-1,-1); //  The values -1,-1 mean that nothing is highlighted
  
  Board(int startX, int startY){
    this.startX = startX;
    this.startY = startY;
  }
  
  void drawBoard(){
    // black first
    color black = color(64, 40, 6); 
    color white = color(255);
    color fillColor;
    color highlightColor = color(245, 191, 66);
    
    for (int i = 0; i < board.length; i++){
      for (int j = 0; j < board[i].length; j++){
        boolean isWhite = (i + j) % 2 == 0; 
        fillColor = isWhite ? white : black;
        fill(fillColor);
        
        //if (board[i][j]){ fill(highlightColor);}
        
        rect(i * cellSize + startX, j * cellSize + startY, cellSize,cellSize);
        
        if (!isWhite && squareIsClicked(new Position(i,j))){
          highlighted = new Position(i, j);
          
        } else if (isWhite && squareIsClicked(new Position(i,j))){
          highlighted = new Position(-1, -1);
        } else if(clickedOutOfSquares()){
          highlighted = new Position(-1, -1);
        }
        
      }
    }
    
  }
  
  boolean squareIsClicked(Position p){
    int x = p.getX();
    int y = p.getY();
    if (mousePressed){  
      if ( mouseX > startX + x * cellSize && mouseX < startX + cellSize + x * cellSize &&
      mouseY > startY + y * cellSize && mouseY < startY + cellSize + y * cellSize){
       // println("Clicked: " + x + ", " + y);
        return true;
      } 
    }
    return false;
  }
  
  boolean clickedOutOfSquares(){
    if (mousePressed && (mouseX < startX || mouseX > startX + cellSize * 8 || 
                         mouseY < startY || mouseY > startY + cellSize * 8)){
      return true;
    }
    return false;
  }
}
