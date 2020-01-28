
Game game;

void setup(){
  size(800, 800);
  game = new Game();
  
}

void draw(){
  background(6, 54, 64);
  
  game.drawGame();
  textSize(34);
  textAlign(CENTER);
  fill(255,5,5);
  String currentTurn = game.currentTurn == Color.BLACK ? "Black" : "Red";
  text(currentTurn + "'s Turn", width/2, 50);
}
