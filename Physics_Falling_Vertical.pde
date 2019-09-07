/**
 * Falling Box Visualization
 * by Yehho Shin
 * 
 * X velocity of A and B are same.
 * No inputs available.
 */

/* Variables */
PVector boxA, boxB; //coordinates of boxes
int boxSizeA, boxSizeB; //size of boxes
float g = 9.8; //gravity = 9.8
float dropPointX;
float aA, mA=10, vA=4,mvA; //physical status of box A
float aB, mB=10, xvB=0, yvB=0, mvB, boxBheight; //physical status of box B
float impulse, ymaxVB; //impulse / recording max y velocity of box B
float lineY;  //Y location of the ground
float tempmvA;
boolean collision = false;  //whether the collision happened or not
boolean dropping = false;
/*setup fuction - executes once at start*/

void setup() {
  size(1500, 800); //define size of the window(program)
  lineY = height/2+height/4; //setting the y location of the ground : 3/4
  boxA = new PVector(0, lineY); //initializing coordinates
  boxB = new PVector(600, 100);
  SetDropPoint();
  
  frameRate(30);  //framerate : 30 per sec
}

/*draw fuction - executes 30 times per second*/

void draw() {
  background(0);  //background colour : black
  ManagePhysics(); //executing the function : ManagePhysics
  PrintText();  //executing the function : PrintText
  boxSizeA = int(mA*100);  //sizes are proportional to the mass
  boxSizeB = int(mB*100);  
  rectMode(CORNERS);  //deciding how to display rectangle
  noStroke(); //just polishing the boxes
  fill(255);  //colour of box A, white
  rect(boxA.x, boxA.y - mA*100/30, boxA.x+50, boxA.y);  //displaying box A
  fill(#42a5f5);  //colour of box B, blue
  rect(boxB.x, boxB.y - mB*100/30, boxB.x+50, boxB.y);  //displaying box B
  stroke(255);  //colour of the ground, white
  line(0, lineY, width, lineY);  //displaying ground line
  boxA.x = boxA.x+vA;  //moving box a(x direction)
  boxB.x = boxB.x+xvB;  //moving box b(x direction)
  boxB.y = boxB.y+yvB;  //moving box b(y direction)
}

/*PrintText fuction - displaying physical status*/

void PrintText() {
  fill(255);  //setting colour of texts, white
  /*Box A*/
  textSize(20);  //setting font size of texts, 20 pt.
  text("Box A", 100, lineY+30);  //displaying text
  textSize(14);  //setting font size of texts, 14 pt.
  text("X Velocity = " + vA + "m/s", 100, lineY+60);
  text("Y Velocity = " + "0" + "m/s", 100, lineY+80);
  text("X Acceleration = " + "0" + "m/s²", 100, lineY+100);
  text("Y Acceleration = " + aA + "m/s²", 100, lineY+120);
  text("Mass = " + mA +"kg", 100, lineY+140);
  text("X Momentum = " + mvA +"N·s", 100, lineY+160);
  /*Box B*/
  textSize(20);  //setting font size of texts, 20 pt.
  fill(#42a5f5);  //setting colour of texts, blue
  text("Box B", 300, lineY+30);  //displaying text
  fill(255);  //setting colour of texts, white
  textSize(14);  //setting font size of texts, 14 pt.
  text("X Velocity = " + xvB + "m/s", 300, lineY+60);
  text("Y Velocity = " + yvB + "m/s", 300, lineY+80);
  text("X Acceleration = " + "0" + "m/s²", 300, lineY+100);
  text("Y Acceleration = " + g + "m/s²", 300, lineY+120);
  text("Mass = " + mB +"kg", 300, lineY+140);
  text("X Momentum = " + mvB +"N·s", 300, lineY+160);
  
  if (collision) { //if the collision already happened
    /*displaying the collisioin info*/
    textSize(18);  //setting font size of texts, 18 pt.
    text("Collision Info", 500, lineY+30);
    text("Max Y Velocity " + ymaxVB + "m/s", 500, lineY+60);
    text("Impulse = " + impulse + "N·s", 500, lineY+80);
  }
}

void SetDropPoint(){
  boxBheight = (boxA.y - mA*100/30) - (boxB.y);
  dropPointX = boxB.x-(vA*frameRate*sqrt(boxBheight*2/g/frameRate));
  println(boxBheight);
  println(boxB.x);
  println(vA*frameRate*sqrt(boxBheight*2/g/frameRate));
  println(dropPointX);
}


/*ManagePhysics fuction - Calculating energy, acceleration, velocity*/

void ManagePhysics() {
  boxBheight = (boxA.y - mA*100/30) - (boxB.y);
  mvA=mA*vA;
  mvB=mB*xvB;
  //boxA.y - mA*100/30<=boxB.y
  if (boxBheight<=0) {  //if collided
    if (collision==false) { //is first recording?
      tempmvA = mvA;
      ymaxVB = yvB;  //recording max y velocity
      impulse = ymaxVB*mB; //calculating impulse
      g = 0;  //make gravity 0
      collision = true; //recording that the collision already happened
    }
  }
  if (collision) { //after collision
    yvB = 0;  //y velocity of box B : zero
    xvB = vA = tempmvA/(mA+mB);  //accelerating
  } else if(collision == false && dropping == true) {  //before collision
    yvB += g/frameRate;  //accelerating
  }
  
  if(boxA.x>=dropPointX+90){
     dropping = true;
  }
}
