/** Represents a brick in the game */
class Brick {
  int xPosition;
  int yPosition;
  color c;

  Brick(int x, int y) {
    xPosition = x;
    yPosition = y;
    c = color(random(255), random(155), random(255));
  }
  
  void draw() {
    rectMode(CENTER);
    stroke(255);
    fill(c);
    rect(xPosition, yPosition, brickWidth, brickHeight);
  }

  boolean impact(Ball b) {
    if (xPosition - brickWidth/2 <= b.xPosition &&
        b.xPosition <= xPosition + brickWidth/2 &&
        yPosition + brickHeight/2 > b.yPosition-ballDiameter/2)
        return true;
    else
        return false;
  }
}