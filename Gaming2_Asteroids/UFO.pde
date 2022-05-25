class UFO
{
  ArrayList <Bullet> lasers = new ArrayList<Bullet>();
  PImage ufo;
  PVector location, speed, velocity;
  PVector mouse;
  int bulletTimer, limit;
  float x,y,z;
  Ship player;

  UFO(int x, int y, int sX, int sY, ArrayList<Bullet> _lasers, Ship _player)
  {
    ufo = loadImage("UFO.png");
    location =  new PVector(x, y);
    speed = new PVector(sX, sY);
    velocity = new PVector(cos(radians(z)),sin(radians(z)));
    mouse = new PVector(mouseX,mouseY);
    lasers = _lasers;
    limit = 150;
    player = _player;
  }

  void update()
  {
    display();
    move();
    shoot();
    mouse = new PVector(mouseX,mouseY);
  }

  void display()
  {
    image(ufo, location.x, location.y);
  }

  void move()
  {
    location.x += speed.x;

    if (location.x < -25)
    {
      location.x = width+25;
    }

    if (location.x > width+25)
    {
      location.x = -25;
    }
  }
  
  boolean collided(float x1, float y1)
  {
    if (dist(location.x, location.y, x1, y1)<=40/2+10)
    {
      return true;
    } else return false;
  }

  void shoot()
  {
    bulletTimer ++;
    x = player.location.x-location.x;
    y = player.location.y-location.y;
    z = atan2(y,x);
    velocity.x = cos(z);
    velocity.y = sin(z);
    println(degrees(z));
    for (Bullet l : lasers)
      {
        l.shootBullet();
        //println("SHOT!" , velocity.x, velocity.y);
      }
    
    if (bulletTimer >= limit)
    {
      lasers.add(new Bullet(location.x, location.y, velocity.x, velocity.y));
      bulletTimer = 0;
      
    }
  }
}