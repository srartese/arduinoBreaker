//////////////////////////////////////////

/** The ball for the BrickBreaker game
 */
class Ball {
  
  float xPosition;
  int yPosition;
  float xSpeed;
  int ySpeed;
 
  Ball(float x, int y, int xInitialSpeed, int yInitialSpeed) {
    xPosition = x;
    yPosition = y;
    xSpeed = xInitialSpeed;
    ySpeed = yInitialSpeed;
  }  
    void draw() {
    fill(0);
    ellipse(xPosition, yPosition, ballDiameter, ballDiameter);
  }
  
  void update() {
    xPosition += xSpeed;
    yPosition += ySpeed;
    if (xPosition < 0 || xPosition > width) {
      xSpeed *= -1;
    }
  }
  
  void bounce() {
    ySpeed *= -1;
  }
}