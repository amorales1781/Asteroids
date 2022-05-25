class Bullet
{
  float bulletX, bulletY, speedX, speedY;

  Bullet(float _x, float _y, float _sX, float _sY)
  {
    bulletX = _x;
    bulletY =_y;
    speedX = _sX;
    speedY = _sY;
  }

  void shootBullet()
  {
    ellipse(bulletX, bulletY, 10, 10);
    bulletX += speedX*5;
    bulletY += speedY*5;
    //println("Bullet",bulletX, bulletY);
  }

 
}