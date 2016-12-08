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

float randArrayX[] = {320,480, 640, 800, 960};
float randArrayY[] = {720, 560, 400, 240, 80};

int randx = (int)random(randArrayX.length); 
int randy = (int)random(randArrayY.length); 

boolean following = false;

String xval = "x: Null";
String yval = "y: Null";
String zval = "x: Null";

float storeX = 0;
float storeY = 0;
float storeZ = 0;

void setup() {
  //size(1280,800);
  fullScreen();
  
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
  
  oscP5 = new OscP5(this,7400);
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
  
  if (following == true) {
    randArrayX[randx] = posx + 60;
    randArrayY[randy] = posy + 60;
  }
  else{
    following = false;
  }
  
  //GAMEPAD
/*  if (gpad.getButton("SELECT").pressed()){
    following = true;
  }
  else if(gpad.getButton("DESELECT").pressed()){
    following = false;
  }
  else  if (gpad.getButton("UP").pressed()){
    posy = (posy - 160);
  }
  else if (gpad.getButton("DOWN").pressed()){
    posy = (posy + 160);
  }
  else if (gpad.getButton("LEFT").pressed()){
    posx = (posx - 160);
  }
  else if (gpad.getButton("RIGHT").pressed()){
    posx = (posx + 160);
  } */ 
}

// =========================================================
void keyPressed()
{
  if (key == 'v')
  {
    //following = true;
    following = !following;
  }
  if (key == CODED)
  {
    if (keyCode == LEFT)
    {
      //if (directionX>0) { 
      //directionX=-1;
      //directionY=0;
      posx= posx-160;
      //}
      println(posx, posy);
      if (posx < 260){
        posx = 260;
      }
    }
    else if (keyCode == RIGHT)
    {
      //if (directionX<0) {  
      //directionX=1;
      //directionY=0;
      posx= posx+160;
      //}
      println(posx, posy);
      if (posx > 900){
        posx = 900;
      }
    }
    else if (keyCode == UP)
    {
      //if (directionY<0) {
      //directionY=-1;
      //directionX=0;
      posy = posy - 160;
      //}
      println(posx, posy);
      if (posy < 20){
        posy = 20;
      }
    }
    else if (keyCode == DOWN)
    {
      //if (directionY<0) { 
      //directionY=1;
      //directionX=0;
      posy = posy + 160;
      //}
      println(posx, posy);
      if (posy > 660){
        posy = 660;
      }
    }
  }
}

void oscEvent(OscMessage theOscMessage) {
  float value = theOscMessage.get(0).floatValue();
  if(theOscMessage.checkAddrPattern("/accelerometer/raw/x")){
    //posx= posx-160;
    //println("x: " + value);
    //value = value * 15;
    xval = str(value);
    storeX = value;
    //logic
    
  }if(theOscMessage.checkAddrPattern("/accelerometer/raw/y")){
    //posy= posy-160;
    //println("y: " + value);
    //value = value * 15;
    yval = str(value);
    storeY = value;
    //logic here
    
  }
  if(theOscMessage.checkAddrPattern("/accelerometer/raw/z")){
    //posy= posy-160;
    //println("z: " + value);
    //value = value * 15;
    zval = str(value);
    storeZ = value;
    //logic here
    
  }
  //up
  if (storeZ < -13.5 || storeZ > 15.0){
    posy = posy - 10;
    if (posy < 20){
        posy = 20;
      }
  }
  //down
  if (storeX > 10.0 && storeZ < 2.0){
    posy = posy + 10;
    if (posy > 660){
        posy = 660;
      }
  }
  //left
  if (storeY > 11.5 && storeZ < 1.0){
    posx = posx - 10;
    if (posx < 260){
        posx = 260;
      }
  }
  //right
  if (storeY < -9.5 && storeZ < 1.0){
    posx = posx + 10;
    if (posx > 900){
        posx = 900;
      }
  }
  //select or deselect
  if (storeX < -7.0 ){
    following = true;
  }
}