import oscP5.*;
import netP5.*;
  
OscP5 oscP5;
NetAddress myRemoteLocation;
  
int movement = 0;
int reset = 0;
int last_reset = 1;
int last_background = 0;

void setup() {
  ////fullScreen();
  //fullScreen(1);
  size(1024,768);
  oscP5 = new OscP5(this,7000);
  
  myRemoteLocation = new NetAddress("127.0.0.1",7000);
}

void draw() {
  //print(movement);
  if (reset != last_reset){

    last_reset = reset;
  }
  else{
    background(last_background);
  }
  //print(movement);
  //background(127);
  
  float curveWidth = 9.0;
  float curveThickness = 9.0;
  float angleOffset = 0.9;
  
  float angleIncrement = map(movement, 0, 127, 0.0, 0.1);
  float angleA = 0.0;
  float angleB = angleA + angleOffset;
  
  float k = map(movement, 0, 127, 2.0, 4.0);
  
  for (int i = 0; i < height; i += curveWidth*k) {
    float waveColor = map(i, 0, movement, 0, 255);
    noStroke();

    pushMatrix();
    translate(0, 400);
    fill(waveColor);
    beginShape(QUAD_STRIP);
    for (int x = 0; x <= width; x += 10) {
      //float y1 = i + (sin(angleA)* curveWidth);
      //float y2 = i + (sin(angleB)* curveWidth);
      float y1 = i + (sin(angleB) * curveWidth);
      float y2 = i + (cos(angleA) * curveWidth);
      vertex(x, y1);
      vertex(x, y2 + curveThickness);
      angleA += angleIncrement;
      angleB = angleA + angleOffset;
    }
    endShape();
    
    pushMatrix();
    scale(1.0, -1.0);
    beginShape(QUAD_STRIP);
    for (int x = 0; x <= width; x += 10) {
      //float y1 = i + (sin(angleA)* curveWidth);
      //float y2 = i + (sin(angleB)* curveWidth);
      float y1 = i + (sin(angleB) * curveWidth);
      float y2 = i + (cos(angleA) * curveWidth);
      vertex(x, y1);
      vertex(x, y2 + curveThickness);
      angleA += angleIncrement;
      angleB = angleA + angleOffset;
    }
    endShape();
    popMatrix();
    popMatrix();
  }
}

void oscEvent(OscMessage theOscMessage) {
  /* check if theOscMessage has the address pattern we are looking for. */
  if(theOscMessage.checkAddrPattern("/movement")==true) {
    /* check if the typetag is the right one. */
    /* parse theOscMessage and extract the values from the osc message arguments. */
    movement = theOscMessage.get(0).intValue();  
    }  
  if(theOscMessage.checkAddrPattern("/reset")==true){
    reset = theOscMessage.get(0).intValue();
  } 
}