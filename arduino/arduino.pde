import processing.serial.*;

Serial myPort; 
String val;

boolean firstContact = false;
int numBrickRows = 5;
int brickWidth = 50;
int brickHeight = 30;
int paddleHeight = brickHeight;
int paddleWidth = int(brickWidth*1.5);
int ballDiameter = 10;

float xPaddle;

Brick[] bricks = new Brick[0];
Paddle myPaddle;
Ball myBall;

void setup() {
  size(400, 450);
    smooth();  
  for (int j=0; j < numBrickRows; j++) { // rows
    int y = brickHeight / 2 + j * brickHeight;
    int offset = 0;
    if (j % 2 == 0) {
      offset = brickWidth / 2;
    }
    for (int i=offset; i < width+brickWidth/2.0; i += brickWidth) { // columns
      bricks = (Brick[]) append(bricks, new Brick(i,y));
    }
  }
  
  myPaddle = new Paddle(xPaddle);
  
  myPort = new Serial(this,"/dev/cu.usbmodem1411", 9600);
  myPort.bufferUntil('\n'); 
  
}

void draw() {
  background(255);
  
  myPaddle.update();
  for (int i=0; i < bricks.length; i++) {
    if (bricks[i] != null) {
      bricks[i].draw();
    }
  }
 
  if (myBall != null) {
    myBall.draw();
    myBall.update();
  }
 
  myPaddle.display();

    if (myBall != null && myPaddle.impact(myBall)) {
    myBall.bounce();
    myPaddle.impartXVelocity(myBall);
  }
  
  if (myBall != null) {
    for (int i=0; i < bricks.length; i++) {
      if (bricks[i] != null && bricks[i].impact(myBall) == true) {
        // bounce ball
        myBall.bounce();
        // delete brick
        bricks[i] = null;
      }
    }
  }
  
  if (myBall != null && myBall.yPosition-ballDiameter/2 < 0) {
    myBall.bounce();
  }
  
  if (myBall != null && myBall.yPosition-ballDiameter/2 > height) {
    myBall = null;
  }
  
  boolean weHaveWon = true;
  for (int i=0; i < bricks.length; i++) {
    if (bricks[i] != null) {
      weHaveWon = false;
      break;
    }
  }
  if (weHaveWon) {
    println("YOU'VE WON!!!");
    exit();
  }
}

void serialEvent(Serial myPort) {
val = myPort.readStringUntil('\n');
if (val != null) {
  val = trim(val);
  println(val);
  
  if (firstContact == false) {
    if (val.equals("A")) {
      myPort.clear();
      firstContact = true;
      myPort.write("A");
    }
  }
  else if(val.equals("shootBall")) {
     if (myBall == null) {
        myBall = new Ball(myPaddle.xPos, height - paddleHeight - ballDiameter/2, 0, -2);
      }
  }
  else {
    int num = Integer.parseInt(val);
    xPaddle = map(num, 0, 1023, 0, width); 
  }  
  }
}