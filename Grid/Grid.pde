import net.java.games.input.*;
import org.gamecontrolplus.*;
import org.gamecontrolplus.gui.*;

import oscP5.*;

OscP5 oscP5;

ControlIO control;
Configuration config;
//ControlDevice gpad;

int box = 160;
int radius = 10, directionX = 1, directionY = 0;
float posx=580, posy=340;

float x;
float y;
float z;

float xvalEd;
float yvalEd;
float zvalEd;

float randArrayX[] = {320,480, 640, 800, 960};
float randArrayY[] = {720, 560, 400, 240, 80};

int randx = (int)random(randArrayX.length); 
int randy = (int)random(randArrayY.length); 

boolean following = false;

String xval = "x: Null";
String yval = "y: Null";
String zval = "x: Null";

boolean upDetect = false, downDetect = false, leftDetect = false, rightDetect = false;

float storeX = 0;
float storeY = 0;
float storeZ = 0;

void setup() {
  size(1280,800);
  //fullScreen();
  
  // Initialise the ControlIO
  control = ControlIO.getInstance(this);
  // Find a device that matches the configuration file
  //gpad = control.getMatchedDevice("tank_game");
 // if (gpad == null) {
   // println("No suitable device configured");
    //System.exit(-1); // End the program NOW!
  //}
  
  println("dot " + randArrayX[randx], randArrayY[randy]);
  
  //making sure circle doesn't start on square
  if(randArrayX[randx] == 640 && randArrayY[randy] == 400){
    randArrayX[randx] = randArrayX[randx] + 160;
    randArrayY[randy] = randArrayY[randy] + 160;
  }
  
  oscP5 = new OscP5(this,9000);
  
  oscP5.plug(this,"rawaccel","/wii/1/accel/xyz");
  oscP5.plug(this,"x","/wii/1/accel/xyz/0");
  oscP5.plug(this,"y","/wii/1/accel/xyz/1");
  oscP5.plug(this,"z","/wii/1/accel/xyz/2");
}

void rawaccel(float _x, float _y, float _z) {
  x = -1 * (_x - 0.5);
  y = _y - 0.5;
  z = _z - 0.5;
}

void draw() 
{
for (int x = -80; x < width; x+=160) 
{
  for (int y = 0; y < height; y+=160)
  {
    stroke(255);
    fill(0,0,0);
    rect(x,y,box-1,box-1);
}
}
  noStroke();
  rect(0, 0, 239, 800);
  fill(0, 0, 0);
  rect(1280, 0, -239, 800);
  fill(0, 0, 0);
  
  fill (color(222, 22, 22)); 
  rect(posx, posy, 120, 120);
  
  ellipseMode(CENTER);
  fill (color(255, 255, 0));
  if (following == true){
    fill (color(0, 255, 0));
  }
  else{
    fill (color(255, 255, 0));
  }
  ellipse(randArrayX[randx], randArrayY[randy], 100, 100);
  
  fill (color(255, 255, 0));
  text(xval, 10, 10, 250, 80);
  
  text(yval, 10, 40, 250, 80);
  
  text(zval, 10, 70, 250, 80);
  
  xval = str(x * 75);
  yval = str(y * 75);
  zval = str(z * 75);
  
  xvalEd = x * 75;
  yvalEd = y * 75;
  zvalEd = z * 75;
  
  if (following == true) {
    randArrayX[randx] = posx + 60;
    randArrayY[randy] = posy + 60;
  }
  else{
    following = false;
  }
  
  checkMovement();
}

void checkMovement(){
  if (yvalEd > 7 && yvalEd <10){
    println ("LEFT");
    leftDetect = true;
    downDetect = false;
    upDetect = false;
    rightDetect = false;
    
    if (leftDetect == true){
    posx= posx-160;
    }
    else if (rightDetect == true||
    downDetect == true ||
    upDetect == true){
      //nothing
    }
      //}
      println(posx, posy);
      if (posx < 260){
        posx = 260;
      }
  }
  if (yvalEd < -10 && yvalEd > -12){
    println ("RIGHT");
    leftDetect = false;
    downDetect = false;
    upDetect = false;
    rightDetect = true;
    
    if (rightDetect == true){
    posx= posx+160;
    }
    else if (leftDetect == true||
    downDetect == true ||
    upDetect == true){
      //nothing
    }
      //}
      println(posx, posy);
      if (posx > 900){
        posx = 900;
      }
  }
  if (xvalEd > 8){
    println ("SELECT");
    following = true;
  }
  if (zvalEd > 24){
    println ("DOWN");
    upDetect = false;
    leftDetect = false;
    downDetect = true;
    rightDetect = false;
    
    if (downDetect == true){
    posy = posy + 160;
    }
    
      //}
      println(posx, posy);
      if (posy > 660){
        posy = 660;
      }
  }
  if (zvalEd < -4){
    println ("UP");
    upDetect = true;
    leftDetect = false;
    downDetect = false;
    rightDetect = false;
    
    if (upDetect == true){
    posy = posy - 160;
    }
      //}
      println(posx, posy);
      if (posy < 20){
        posy = 20;
      }
  }
}