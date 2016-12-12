//Original code from: http://d.hatena.ne.jp/metya1013/20120331/1333202187

import oscP5.*;
import netP5.*;

OscP5 osc;

float x;
float y;
float z;

float xvalEd;
float yvalEd;
float zvalEd;

String xval = "x: Null";
String yval = "y: Null";
String zval = "x: Null";

boolean upDetect = false;

PrintWriter output;

void setup() {
  size(400, 400);
  
  //output file for testing
  output = createWriter("positions.txt"); 

  // OscCulator
  osc = new OscP5(this,9000);
  
  // osc.plug
  osc.plug(this,"rawaccel","/wii/1/accel/xyz");
  osc.plug(this,"x","/wii/1/accel/xyz/0");
  osc.plug(this,"y","/wii/1/accel/xyz/1");
  osc.plug(this,"z","/wii/1/accel/xyz/2");

  background(255);
  smooth();
  noFill();
  stroke(0);
}

void rawaccel(float _x, float _y, float _z) {
  x = -1 * (_x - 0.5);
  y = _y - 0.5;
  z = _z - 0.5;
}

void draw(){
  background(255);
  ellipseMode(RADIUS);
  ellipse(width/2 + width*x, height/2 +  height*y, 20 + (z * 15), 20 + (z * 15));
  //print("x: "+x);
 // print(" y: "+y);
  //print(" z: "+z);
  
  //output.println(y);  // Write the coordinate to the file
  
  xval = str(x * 75);
  yval = str(y * 75);
  zval = str(z * 75);
  
  xvalEd = x * 75;
  yvalEd = y * 75;
  zvalEd = z * 75;
  
  //Same as if statements below
  checkMovement();
  
 /* if (yvalEd > 8){
    println ("LEFT");
  }
  if (yvalEd < -8){
    println ("RIGHT");
  }
  if (xvalEd > 8){
    println ("SELECT");
  }
  if (zvalEd > 20){
    println ("DOWN");
    upDetect = true;
  }
  if (zvalEd < -8 & upDetect == true){
    println ("UP");
  } */
  
  fill (color(255, 0, 255));
  text("x: " + xval, 10, 10, 250, 80);
  
  text("y: " +yval, 10, 40, 250, 80);
  
  text("z: " +zval, 10, 70, 250, 80);
}

void checkMovement(){
  if (yvalEd > 9 && yvalEd <10){
    println ("LEFT");
  }
  if (yvalEd < -8 && yvalEd > -9){
    println ("RIGHT");
  }
  if (xvalEd > 8){
    println ("SELECT");
  }
  if (zvalEd > 20){
    println ("DOWN");
    upDetect = true;
  }
  if (zvalEd < -8 & upDetect == true){
    println ("UP");
  }
}

void keyPressed() {
  if (key == x){
  output.flush();  // Writes the remaining data to the file
  output.close();  // Finishes the file
  exit();  // Stops the program
  }
}