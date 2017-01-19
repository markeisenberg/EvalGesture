import net.java.games.input.*;

import oscP5.*;

OscP5 oscP5;

int box = 160;
int radius = 10, directionX = 1, directionY = 0;
float posx=580, posy=340;
int value;

float randArrayX[] = {320,480, 640, 800, 960};
float randArrayY[] = {720, 560, 400, 240, 80};

int randx = (int)random(randArrayX.length); 
int randy = (int)random(randArrayY.length); 

boolean following = false;
boolean overlap = false;

String xval = "x: Null";
String yval = "y: Null";
String zval = "x: Null";

float storeX = 0;
float storeY = 0;
float storeZ = 0;

float gestureVal = 0;

void setup() {
  size(1280,800);
  //fullScreen();
  
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
}

// =========================================================
void keyPressed()
{
  if (key == 'v')
  {
    //following = true;
    //following = !following;
    checkOverlap();
       if (overlap == true){
       following = !following;
       }
  }
  if (key == 'p')
  {
    restart();
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

void checkOverlap(){
  if (randArrayX[randx] == 320 && posx == 260 && randArrayY[randy] == 80 & posy == 20){
    overlap = true;
  }
  else{
    overlap = false;
  }
}

void restart(){
  following = false;
  
  randx = (int)random(randArrayX.length); 
  randy = (int)random(randArrayY.length); 
  
  posx=580;
  posy=340;
  
  //making sure circle doesn't start on square
  if(randArrayX[randx] == 640 && randArrayY[randy] == 400){
    randArrayX[randx] = randArrayX[randx] + 160;
    randArrayY[randy] = randArrayY[randy] + 160;
  }
}

void oscEvent(OscMessage theOscMessage) {
  //String value = theOscMessage.get(0).stringValue();
  if(theOscMessage.checkAddrPattern("/gesture") == true){
     value = theOscMessage.get(0).intValue();
     
     //RIGHT
     if (value == 1){
       posx= posx+160;
      
      println(posx, posy);
      if (posx > 900){
        posx = 900;
      }
     }
     
     //LEFT
     if (value == 2){
       posx= posx-160;
     
      println(posx, posy);
      if (posx < 260){
        posx = 260;
      }
     }
     
     //UP
     if (value == 3){
       posy = posy - 160;
     
      println(posx, posy);
      if (posy < 20){
        posy = 20;
      }
     }
     
     //DOWN
     if (value == 4){
       posy = posy + 160;
      
      println(posx, posy);
      if (posy > 660){
        posy = 660;
      }
     }
     
     //SELECT
     if (value == 5){
       checkOverlap();
       if (overlap == true){
       following = !following;
       }
     }
}
}