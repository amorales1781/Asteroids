class Game
{
  StartScreen start;
  PlayScreen lvl1;
  DeathScreen death;
  CreditsScreen credits;

  Game()
  {
    start = new StartScreen();
    lvl1 = new PlayScreen();
    death = new DeathScreen();
    credits = new CreditsScreen();
  }

  void run()
  {
    if (gameState == 0)
    {
      start.update();//start screen
    }

    if (gameState == 1)
    {
      lvl1.play();//PlayScreen
    }
    if (gameState == 2)
    {
      death.update();//Dead Screen
    }
    if (gameState == 3)
    {
      credits.update();//Credits Screen
    }

    
  }

  void keyP()
  {
    lvl1.checkKeyPressed();
    if (key == 'f' && gameState != 1)
    {
      gameState += 1;
      if (gameState >= 4)
      {
        gameState = 0;
      }
    }
  }

  void keyR()
  {
    lvl1.checkKeyReleased();
  }
}