char val; // Data received from the serial port
int ledPin = 13; // Set the pin to digital I/O 13
boolean ledState = LOW; //to toggle our LED
int buttonState = 0;  
const int buttonPin = 8;
int potPin = 2;
int pentiVal = 0; 


void setup()
{
  pinMode(ledPin, OUTPUT); // Set pin as OUTPUT
  pinMode(buttonPin, INPUT);
  //initialize serial communications at a 9600 baud rate
  Serial.begin(9600);
  establishContact();  // send a byte to establish contact until receiver responds
}


void loop()
{
  buttonState = digitalRead(buttonPin);            
  pentiVal = analogRead(potPin); 
    
  if (Serial.available() > 0) { // If data is available to read,
     val = Serial.read();
    if (val == '1') //if we get a 1
    {
        Serial.println("1");  
    }
  }
  else {
     if (buttonState == HIGH) {
        Serial.println("shootBall");
     }
      Serial.println(pentiVal);
  }
}

void establishContact() {
  while (Serial.available() <= 0) {
    Serial.println("A");   // send a capital A
    delay(300);
  }
}


