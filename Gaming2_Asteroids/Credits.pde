class CreditsScreen
{
  PImage screen, asteroids;
  float z, speed, acceleration;
  CreditsScreen()
  {
    screen = loadImage("Credits.png");
    asteroids = loadImage("Asteroid.png");
  }

  void update()
  {
    display();
    displayAsteroids();
  }

  void display()
  {
    image(screen, width/2, height/2, 800, 600);
  }


  void displayAsteroids() {
    acceleration = map(mouseX, 0, width, -0.001, 0.001);
    println(acceleration);
    pushMatrix();
    translate(width/4, height/2);
    rotate(z*-1);
    image(asteroids, 0, 0);
    popMatrix();

    pushMatrix();
    translate(width*3/4, height/2);
    rotate(z);
    image(asteroids, 0, 0);
    popMatrix();
    z += speed;
    speed += acceleration;
  }
}