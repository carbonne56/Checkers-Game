import java.util.ArrayList;

class Game {
  private final int startX = 80;
  private final int  startY = 80;
  private final int cellSize = 80;
  
  Board board = new Board(startX, startY);
  
  color highlightColor = color(245, 191, 66);
  
  
  ArrayList<Piece> blacks = new ArrayList();
  ArrayList<Piece> reds = new ArrayList();
  
  Piece selectedPiece;
  
 // boolean itsBlacksTurnToPlay = true;
  Color currentTurn = Color.BLACK;
  
  /*----------------------------------------------------------------------------*/
  Game(){
    blacks.add(new Piece(new Position(1,0), Color.BLACK));
    blacks.add(new Piece(new Position(3,0), Color.BLACK));
    blacks.add(new Piece(new Position(5,0), Color.BLACK));
    blacks.add(new Piece(new Position(7,0), Color.BLACK));
   
    blacks.add(new Piece(new Position(0,1), Color.BLACK));
    blacks.add(new Piece(new Position(2,1), Color.BLACK));
    blacks.add(new Piece(new Position(4,1), Color.BLACK));
    blacks.add(new Piece(new Position(6,1), Color.BLACK));
    
    blacks.add(new Piece(new Position(1,2), Color.BLACK));
    blacks.add(new Piece(new Position(3,2), Color.BLACK));
    blacks.add(new Piece(new Position(5,2), Color.BLACK));
    blacks.add(new Piece(new Position(7,2), Color.BLACK));
    
    reds.add(new Piece(new Position(0,7), Color.RED));
    reds.add(new Piece(new Position(2,7), Color.RED));
    reds.add(new Piece(new Position(4,7), Color.RED));
    reds.add(new Piece(new Position(6,7), Color.RED));
    
    reds.add(new Piece(new Position(1,6), Color.RED));
    reds.add(new Piece(new Position(3,6), Color.RED));
    reds.add(new Piece(new Position(5,6), Color.RED));
    reds.add(new Piece(new Position(7,6), Color.RED));
    
    reds.add(new Piece(new Position(0,5), Color.RED));
    reds.add(new Piece(new Position(2,5), Color.RED));
    reds.add(new Piece(new Position(4,5), Color.RED));
    reds.add(new Piece(new Position(6,5), Color.RED));
    
    for (Piece red : reds){
      board.board[red.position.getX()][red.position.getY()] = true;
    }
    for (Piece black : blacks){
      board.board[black.position.getX()][black.position.getY()] = true;
    }
  }
  
  /*----------------------------------------------------------------------------*/
  /*----------------------------------------------------------------------------*/
  
  void drawGame(){
    
    board.drawBoard();
    
    if (board.highlighted.getX()!= -1){                 // If a square is selected
      
      highlightPiece(board.highlighted);
      
      Piece piece = getPieceInPosition(board.highlighted);
      
      
      if (piece != null){                               // If a piece is on the selected square
        selectedPiece = piece;
        for (Position position : possibleMoves(piece)){
          
          if((selectedPiece.teamColor == Color.BLACK && currentTurn == Color.BLACK)||   // check the current turn
             (selectedPiece.teamColor == Color.RED && currentTurn == Color.RED)){
               
            highlightSquare(position);
          }   
        }
        
      } else {                                          // Move the selected piece to the clicked square
        movePiece(board.highlighted);
        selectedPiece = null;
      }
    }
    // Display red Pieces
    for(Piece p : reds){
      p.drawPiece(p.position,startX,startY,board.cellSize);
    }
    // Display black Pieces
    for(Piece p : blacks){
      p.drawPiece(p.position,startX,startY,board.cellSize);
    }
  }
  
  /*----------------------------------------------------------------------------*/
  /*----------------------------------------------------------------------------*/
  // Used to highlight the selected piece. Called by drawGame
  
  void highlightPiece(Position p){
    int x = p.getX();
    int y = p.getY();
    //boolean isWhite = (x + y) % 2 == 0; 
    if (hasPiece(p)){
      fill(highlightColor);
      rect(x * cellSize + startX, y * cellSize + startY, cellSize,cellSize);
    }
  }
  
  /*----------------------------------------------------------------------------*/
  // Used to highlight the squares of possible moves. Called by drawGame 
  
  void highlightSquare(Position p){
    int x = p.getX();
    int y = p.getY();
    //boolean isWhite = (x + y) % 2 == 0; 
    
      fill(highlightColor);
      rect(x * cellSize + startX, y * cellSize + startY, cellSize,cellSize);
    
  }
  
  /*----------------------------------------------------------------------------*/
  // Returns true if a position holds a piece
  
  boolean hasPiece(Position p){
    
    for (Piece piece : blacks){
      if (piece.isEqual(p)){
        return true;
      }
    }
    for (Piece piece : reds){
      if (piece.isEqual(p)){
        return true;
      }
    }
    return false;
  }
  
  /*----------------------------------------------------------------------------*/
  // Returns the piece the parameter. If position is empty, returns null.
  // TODO:- Evaluate if this method can render redundant the hasPiece method.
  
  Piece getPieceInPosition(Position position){
    for (Piece red : reds){
      if (red.position.getX() == position.getX() && red.position.getY() == position.getY()){
        return red;
      }
    }
    
    for (Piece black : blacks){
      if (black.position.getX() == position.getX() && black.position.getY() == position.getY()){
        return black;
      }
    }
    return null;
  }
  
  /*----------------------------------------------------------------------------*/
  // Receives a piece, hopefuly the selected piece, and returns an array of
  //possible positions to where a move is possible. Called by drawGame()
  
  ArrayList<Position> possibleMoves(Piece piece){
    
    ArrayList<Position> possible = new ArrayList();
    // Black moves South
    // Red moves North
    // I could have created the ennum Direction, but since I only need it this once, I'll go for a simple boolean
    boolean directionSouth = false;
    int pieceX = piece.position.getX();
    int pieceY = piece.position.getY();
    boolean canEat = false;
    switch (piece.teamColor){
      case RED:
        break;
      case BLACK:
        directionSouth = true;
        break;
    }
    
    if (directionSouth){
       if (          pieceX > 0 && pieceY < 7 
        &&           hasPiece(new Position(pieceX -1, pieceY +1)) 
        &&         isInBounds(new Position(pieceX - 2, pieceY + 2))
        &&          !hasPiece(new Position(pieceX - 2, pieceY + 2)) 
        && getPieceInPosition(new Position(pieceX - 1, pieceY + 1)).teamColor != piece.teamColor){
        
        possible.add(new Position(pieceX - 2, pieceY + 2));
      }
      else if (pieceX > 0 && pieceY < 7 && !hasPiece(new Position(pieceX -1, pieceY +1))){ // Available square to the left
            
        possible.add(new Position(pieceX -1, pieceY + 1));
        
      }
      
      if (pieceX < 7 && pieceY < 7 && !hasPiece(new Position(pieceX + 1, pieceY + 1))){ // Available square to the right
            
        possible.add(new Position(piece.position.getX()+1, piece.position.getY()+1));
      }
      else if (isInBounds(new Position(pieceX + 2, pieceY + 2)) && !hasPiece(new Position(pieceX + 2, pieceY + 2)) 
      && getPieceInPosition(new Position(pieceX + 1, pieceY + 1)).teamColor != piece.teamColor){
        
        possible.add(new Position(pieceX + 2, pieceY + 2));
      }
    }
    
    if (!directionSouth){
      if (piece.position.getX() > 0 && piece.position.getY() > 0 &&
          !hasPiece(new Position(piece.position.getX()-1, piece.position.getY()-1))){
            
        possible.add(new Position(piece.position.getX()-1, piece.position.getY()-1));
      }
      if (piece.position.getX() < 7 && piece.position.getY() > 0 && 
          !hasPiece(new Position(piece.position.getX()+1, piece.position.getY()-1))){
            
        possible.add(new Position(piece.position.getX()+1, piece.position.getY()-1));
      }
    }
    return possible;
  }
  
  
  /*---------------------------------------------------------------------------*/
  
  void movePiece(Position chosenDestination){
    if (selectedPiece != null && ((selectedPiece.teamColor == Color.BLACK && currentTurn == Color.BLACK)||
        (selectedPiece.teamColor == Color.RED && currentTurn == Color.RED))){
          
      for (Position possibleMove : possibleMoves(selectedPiece)){
        if (chosenDestination.isA(possibleMove)){
          selectedPiece.setPosition(chosenDestination);
          switchTurn();
          println("Current Turn: " + currentTurn);
        }
      }
    }
  }
  /*------------------------------------------------------------------------*/
  
  void switchTurn(){
    switch (currentTurn){
      case BLACK:
      currentTurn = Color.RED;
      break;
      case RED:
      currentTurn = Color.BLACK;
      break;
    }
  }
  
  boolean isInBounds(Position position){
    if (position.getX() >= 0 && position.getX() < 8 && position.getY() >= 0 && position.getY() < 8){
      return true;
    }
    return false;
  }
  
  /* @ToDo: 
            When a piece can eat, other possible moves are not allowed
  */

    
  }
  
