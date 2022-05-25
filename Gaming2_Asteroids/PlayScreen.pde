class PlayScreen
{
  ArrayList <Bullet> shipBullets = new ArrayList<Bullet>();
  ArrayList <Bullet> alienBullets = new ArrayList<Bullet>();
  ArrayList <Asteroid> asteroidBelt = new ArrayList<Asteroid>();
  ArrayList <UFO> ufos = new ArrayList<UFO>();
  int[] aX = {50, width-50, 75, width-75, 100, 50, width-100}; //asteroid x position
  int[] aY = {height-100, 100, 100, height-100, 50, height-75, 75}; //asteroid y position
  int[] asX = {2, 1, -3, 2, -2, 1, 3}; //asteroid x speed
  int[] asY = {-2, 3, -1, 4, 1, 3, -2}; //asteroid y speed
  int[] uX = {-25, width+25, width+25, -25}; //UFO x position
  int[] uY = {200, height-200, 200, height-200}; //UFO y position
  int[] usX = {1, -1, -1, 1}; // UFO x speed
  int asteroidCount=2; // amount of asteroids to spawn
  int UFOtimer, ufoIndex; //timer and index for ufo
  float alienZ; //angle of UFO
  boolean dead;
  Ship player;
  UFO alien;

  PlayScreen()
  {
    player = new Ship(shipBullets);
    for (int i = 0; i < asteroidCount; i++)
    {
      asteroidBelt.add(new Asteroid(aX[i], aY[i], asX[i], asY[i], 0));
    }
  }

  void play()
  {
    spawnUFO();
    player.update();
    for (Asteroid m : asteroidBelt)
    {
      m.update();
    }
    asteroidHit();
    respawn();
    shipHit();
    UFOhit();
    text("SCORE: " + score, 50, 50);
  }

  void spawnUFO()
  {
    UFOtimer++;
    if (UFOtimer >= 1000) {
      ufos.add(new UFO(uX[ufoIndex], uY[ufoIndex], usX[ufoIndex], 1, alienBullets, player));
      ufoIndex+=1;
      UFOtimer = 0;
    }

    if (ufoIndex > 3)
    {
      ufoIndex=0;
    }

    for (UFO alien : ufos) {
      alien.update();
    }
  }

  void UFOhit()
  {
    for (int ib = shipBullets.size()-1; ib >= 0; ib--)
    {
      for (int i = ufos.size()-1; i >= 0; i--)
      {
        if (shipBullets.size() > 0 && shipBullets.size() != ib)
        {
          UFO u = ufos.get(i);
          Bullet b = shipBullets.get(ib);
          if (u.collided(b.bulletX, b.bulletY))
          {
            score += 50;
            ufos.remove(i);
            alienBullets.clear();
            shipBullets.remove(ib);
          }
        }
      }
    }
  }

  void shipHit()
  {
    for (Asteroid m : asteroidBelt)
    {
      if (player.collided(m.location.x, m.location.y, m.getSize()))
      {
        dead = true;
      }
    }

    for (int i = alienBullets.size()-1; i >= 0; i--)
    {
      Bullet b = alienBullets.get(i);
      if (player.collided(b.bulletX, b.bulletY, 25))
      {
        dead = true;
      }
    }

    if (dead)
    {
      reset();
      gameState = 2;
    }
  }

  void asteroidHit()
  {
    for (int ib = shipBullets.size()-1; ib >= 0; ib--)
    {
      for (int i = asteroidBelt.size()-1; i >= 0; i--) {
        if (shipBullets.size() > 0 && shipBullets.size() != ib) {
          Asteroid m = asteroidBelt.get(i);
          Bullet b = shipBullets.get(ib);
          if (m.state() == 0 && m.collided(b.bulletX, b.bulletY))
          {
            shipBullets.remove(ib);
            m.explode();
            asteroidBelt.add(new Asteroid(m.location.x-75, m.location.y, m.getSpeedX()*-1, m.getSpeedY()*-1, 1));
            score += 10;
          }
          if (shipBullets.size() > 0 && shipBullets.size() != ib) {
            if ( m.state()== 1 && m.collided(b.bulletX, b.bulletY))
            {
              shipBullets.remove(ib);
              m.explode();
              asteroidBelt.add(new Asteroid(m.location.x-75, m.location.y, m.getSpeedX()*-1, m.getSpeedY()*-1, 2));
              score += 10;
            }
          } 
          if (shipBullets.size() > 0 && shipBullets.size() != ib) {
            if (m.state()== 2 && m.collided(b.bulletX, b.bulletY))
            {
              asteroidBelt.remove(i);
              shipBullets.remove(ib);
              score += 10;
            }
          }
        }
      }
    }
  }

  void respawn()
  {
    if (asteroidBelt.size() == 0)
    {
      if (asteroidCount < 8) {
        asteroidCount += 1;
      }
      for (int i = 0; i < asteroidCount; i++)
      {
        asteroidBelt.add(new Asteroid(aX[i], aY[i], asX[i], asY[i], 0));
      }
    }
  }

  void reset()
  {
    shipBullets.clear();
    player.setShipLocation(width/2, height/2);
    player.gameReset = true;
    alienBullets.clear();
    asteroidBelt.clear();
    ufos.clear();
    asteroidCount = 2;
    for (int i = 0; i < asteroidCount; i++)
    {
      asteroidBelt.add(new Asteroid(aX[i], aY[i], asX[i], asY[i], 0));
    }
    dead = false;
    player.boost = false;
    UFOtimer = 0;
    ufoIndex = 0;
  }

  void setScore(int num)
  {
    score = num;
  }

  void checkKeyPressed()
  {
    player.shipKeyPressed();
  }

  void checkKeyReleased()
  {
    player.shipKeyReleased();
  }
}