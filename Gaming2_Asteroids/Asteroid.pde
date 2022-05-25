class Asteroid
{
  PImage asteroid;
  PVector location, speed;
  int state;
  int size, timer;


  Asteroid(float x, float y, float sX, float sY, int _state)
  {
    location = new PVector(x, y);
    speed = new PVector(sX, sY);
    asteroid = loadImage("Asteroid.png");
    state = _state;
  }

  void update() {
    display();
    move();
  }

  void display()
  {
    image(asteroid, location.x, location.y, size, size);
    if (state == 0)
    {
      size = 75;
    } 
    if (state == 1)
    {
      size = 45;
    } 
    if (state == 2)
    {
      size = 25;
    }
  }

  void move()
  {
    location.add(speed);
    if (location.x < -size/2)
    {
      location.x = width+size/2;
    }

    if (location.x > width+size/2)
    {
      location.x = -size/2;
    }

    if (location.y <-size/2)
    {
      location.y = height+size/2;
    }

    if (location.y > height+size/2)
    {
      location.y = -size/2;
    }
  }

  void explode()
  {
    state += 1;
  }

  boolean collided(float x1, float y1)
  {
    if (dist(location.x, location.y, x1, y1)<=size/2+10)
    {
      return true;
    } else return false;
  }

  int getSize()
  {
    return size;
  }

  int state()
  {
    return state;
  }

  float getSpeedX()
  {
    return speed.x;
  }

  float getSpeedY()
  {
    return speed.y;
  }
}