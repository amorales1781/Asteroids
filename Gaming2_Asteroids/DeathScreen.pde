class DeathScreen
{
  PImage screen, explosion;
  float x, y;
  float sX, sY;
  int points;


  DeathScreen()
  {
    screen = loadImage("DeathScreen.png");
    explosion = loadImage("Explosion.png");
    x = width/10;
    y = height/4;
    sX = 15;
    sY = 10;
  }

  void update()
  {
    displayScreen();
    bullet();
    displayExplosion();
  }

  void displayScreen()
  {
    image(screen, width/2, height/2, width, height);
    text("Your Score: " + score, width-300, 50);
  }

  void bullet()
  {
    noStroke();
    ellipse(x, y, 20, 20);
    x += sX;
    y += sY;
    if (x >= width/3)
    {
      x = width/10;
      y = height/4;
    }
    strokeWeight(1);
  }

  void displayExplosion()
  {
    image(explosion, width/2, height/2, width, height);
  }
}