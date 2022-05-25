class StartScreen
{
  ArrayList <Asteroid> asteroidBelt = new ArrayList<Asteroid>();
  PImage screen;

  StartScreen()
  {
    screen = loadImage("StartScreen.png");
    for (int i = 0; i < 2; i++)
    {
      asteroidBelt.add(new Asteroid(width/2, height/2, 4, 4, 0));
      asteroidBelt.add(new Asteroid(100, 500, -3, 3, 0));
      asteroidBelt.add(new Asteroid(500, 100, 2, -3, 0));
      asteroidBelt.add(new Asteroid(100, 100, 3, -3, 0));
      asteroidBelt.add(new Asteroid(500, 500, -3, -2, 0));
    }
  }

  void update()
  {
    background(0);
    for (Asteroid m : asteroidBelt)
    {
      m.update();
    }
    display();
    score = 0;
  }

  void display()
  {
    image(screen, width/2, height/2,800,600);
  }
}