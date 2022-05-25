/*
Name:Alonso Morales
 Date:9/10/19
 Description: Asteroids Classic Game
 */
PFont font;
int gameState=0;
int score;

Game game;


void setup() {
  //size(1600, 1200);
  fullScreen();
  imageMode(CENTER);
  game = new Game();
  font = createFont("Retro Gaming.ttf", 28);
  textFont(font);
}

void draw() {
  background(0);
  game.run();
}

void keyPressed() {
  game.keyP();
}

void keyReleased() {
  game.keyR();
}