class Ship
{
  ArrayList <Bullet> bullets = new ArrayList<Bullet>();
  PImage spaceship,boostingShip;
  PVector location, velocity;
  boolean left, up, right, bulletTimer, boost, gameReset;
  int timer, timerLimit = 10;
  int boostTimer, size = 50;
  float z;
  float momentumX, momentumY;

  Ship(ArrayList<Bullet> _bullets)
  {
    spaceship = loadImage("Ship.png");
    boostingShip = loadImage("ShipBoost.png");
    location = new PVector(width/2, height/2);
    velocity = new PVector(cos(radians(z)), sin(radians(z)));
    bullets = _bullets;
  }

  void update()
  {
    display();
    rotateShip();
    boundaries();
    shoot();
  }

  void display()
  {
    pushMatrix();
    translate(location.x, location.y);
    rotate(radians(z)+PI/2);
    if (boost)
    {
      image(boostingShip,0,0);
    }
    image(spaceship, 0, 0);   
    velocity.x = cos(radians(z))*3;
    velocity.y = sin(radians(z))*3;
    popMatrix();

    if (!gameReset) {
      location.x += momentumX;
      location.y += momentumY;
    }
  }

  void boost() {
    boost = true;
    if (boost)
    {
      boostTimer++;
    }
    if (!gameReset) {
      if (boost) {
        location.add(velocity);
      }
    }
    if (boostTimer >= 50)
    {
      boostTimer = 0;
      boost= false;
      up = false;
    }
  }

  void shoot()
  {
    for (int i = 0; i<bullets.size(); i++)
    {
      Bullet b = bullets.get(i);
      b.shootBullet();
    }

    for (int i=0; i<bullets.size(); i++)
    {
      if (bullets.get(i).bulletX > width)
      {
        bullets.remove(i);
      }
    }
    if (bulletTimer)
    {
      timer++;
    }

    if (timer >= timerLimit)
    {
      timer = 0;
      bulletTimer = false;
    }
  }

  boolean collided(float x1, float y1, int obstacleSize)
  {
    if (dist(location.x, location.y, x1, y1)<=obstacleSize*3/4)
    {
      return true;
    } else return false;
  }

  void rotateShip()
  {
    if (left)
    {
      z-=5;
    }
    if (right)
    {
      z+=5;
    }
    if (up)
    {
      boost();
    }
  }

  void setShipLocation(int _x, int _y)
  {
    location.x = _x;
    location.y = _y;
  }

  void boundaries()
  {
    if (location.x < -25)
    {
      location.x = width+25;
    }

    if (location.x > width+25)
    {
      location.x = -25;
    }

    if (location.y <-25)
    {
      location.y = height+25;
    }

    if (location.y > height+25)
    {
      location.y = -25;
    }
  }

  void shipKeyPressed()
  {
    if (key == CODED)
    {
      gameReset = false;
      if (keyCode == LEFT)
      {
        left = true;
      }
      if (keyCode == RIGHT)
      {
        right = true;
      }
      if (keyCode == UP)
      {
        up = true;
      }
    }
    if (key == ' ' && !bulletTimer) {
      bullets.add(new Bullet(location.x, location.y, velocity.x, velocity.y));
      bulletTimer = true;
    }
  }

  void shipKeyReleased()
  {
    if (key == CODED)
    {
      if (keyCode == LEFT)
      {
        left = false;
      }
      if (keyCode == RIGHT)
      {
        right = false;
      }
      if (keyCode == UP)
      {
        momentumX = velocity.x *0.2;
        momentumY = velocity.y *0.2;
      }
    }
  }
}