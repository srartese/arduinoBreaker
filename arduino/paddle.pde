
class Paddle {
  
  int yPos = height - paddleHeight/2;
  float xPos;
  
  float xPosPrevious;
  
 Paddle(float xPaddle) {
   xPos = xPaddle;
 }
 
  void display() {
    fill(105);
    stroke(0);
    xPosPrevious = xPos;
    rect(xPos, yPos, paddleWidth, paddleHeight);
  }
  
  boolean impact(Ball b) {
    if (xPos - paddleWidth/2 <= b.xPosition &&
        b.xPosition <= xPos + paddleWidth/2 &&
        yPos - paddleHeight/2 < b.yPosition+ballDiameter/2)
        return true;
    else
        return false;
  }
  
  void impartXVelocity(Ball b) {
    float xVector = xPos - xPosPrevious;
    b.xSpeed += xVector;
  }
  
  void update(){
    xPos = xPaddle;
    println(xPos);
  }
}