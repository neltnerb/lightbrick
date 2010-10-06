/*
 Fading
 
 This example shows how to fade an LED using the analogWrite() function.
 
 The circuit:
 * LED attached from digital pin 9 to ground.
 
 Created 1 Nov 2008
 By David A. Mellis
 Modified 17 June 2009
 By Tom Igoe
 
 http://arduino.cc/en/Tutorial/Fading
 
 */

int delaytime = 100; // Delay time between incrementing PWM.
int stepnumber = 10; // Number of steps between adjacent RGB values.
int redPin = 9;    // Red LED connected to digital pin 9
int greenPin = 10; // Green LED connected to digital pin 10
int bluePin = 11; // Blue LED connected to digital pin 11

// Assign the initial RGB setpoints (off).
unsigned int currentred = 0;
unsigned int currentgreen = 0;
unsigned int currentblue = 0;

void setup()  { 
  randomSeed(analogRead(0));
} 

void loop()  {
  float newscaler = 0;
  unsigned int newblue = 0;
  unsigned int newred = 0;
  unsigned int newgreen = 0;
  
  // Initialize the delta steps for each color.
  unsigned int deltared = 0;
  unsigned int deltagreen = 0;
  unsigned int deltablue = 0;
  
  // Assign the new random RGB setpoint as an int.
  newred = (unsigned int)random(0xFFFF);
  newgreen = (unsigned int)random(0xFFFF);
  newblue = (unsigned int)random(0xFFFF);
  newscaler = (float)0xFFFF/(newred + newgreen + newblue);
  newred = (unsigned int)((long)newred * newscaler);
  newgreen = (unsigned int)((long)newgreen * newscaler);
  newblue = (unsigned int)((long)newblue * newscaler);
  
  // Calculate the delta in brightness needed to get from the initial
  // to the final value in 100 steps (2 seconds).
  
  deltared = (int)(newred - currentred)/stepnumber;
  deltagreen = (int)(newgreen - currentgreen)/stepnumber;
  deltablue = (int)(newblue - currentblue)/stepnumber;
  
  // Run a for loop for that many steps with the calculated incrementor.
  
  for(int i = 0 ; i <= stepnumber ; i += 1) {
    // Calculates the next value for each color.
    currentred = (unsigned int)((long)currentred + deltared);
    currentgreen = (unsigned int)((long)currentgreen + deltagreen);
    currentblue = (unsigned int)((long)currentblue + deltablue);
    
    // Write the updated current brightness values.
    analogWrite(redPin, currentred >> 8);
    analogWrite(greenPin, currentgreen >> 8);
    analogWrite(bluePin, currentblue >> 8);
    
    // Delay the given time for the next update.
    delay(delaytime);                            
  }
}


