/**
 * Mass and velocity visualization
 * by Yehho Shin
 * 
 * Momentum is constant
 * Press 'M' or 'N' key to adjust mass
 */

/* Variables */
PVector box; //coordinates of box
int rectSize; //size of box
float deltaM = 2; //mass multiplying
float f=0, a, e, m=10, v,mv=40;
//force, acceleration, energy(kinetic), velocity, momentum

/*setup fuction - executes once at start*/

void setup(){
  size(1500, 800);  //define size of the window(program)
  box = new PVector(0, height/2); //initializing coordinates
  frameRate(30);  //framerate : 30 per sec
}

/*draw fuction - executes 30 times per second*/

void draw(){
  background(0); //background colour : black
  ManagePhysics(); //executing the function : ManagePhysics
  PrintText();  //executing the function : PrintText
  rectSize = int(m*100);  //size is proportional to mass
  rectMode(CORNERS);  //deciding how to display rectangle
  rect(box.x,box.y - m*100/30,box.x+50, box.y);  //displaying the box at specific location
  stroke(255);  //making the line white
  line(0,box.y,width,box.y);  //drawing the ground line
  box.x = box.x+v;  //moving the box
}

/*PrintText fuction - displaying physical status*/

void PrintText(){
  text("Momentum = " + mv +"N·s",100,160);
  text("Mass = " + m +"kg",100,140);
  text("Acceleration = " + a + "m/s²",100,120);
  text("Velocity = " + v + "m/s",100,100);
  text("Energy = " + e + "J",100,80);
  text("Force = " + f +"N",100,60);
}

/*ManagePhysics fuction - Calculating energy, acceleration, velocity*/

void ManagePhysics(){
  e = m*v*v/2; //setting energy variable
  a = f/m;     //setting acceleration variable
  v = mv/m;    //setting velocity variable
}

/*KeyPressed fuction - Adjusting mass by keyboard input*/

void keyPressed(){
   if(key == 'm'){ //when key 'm' pressed
      m = m*deltaM; //make mass double since deltaM is 2
   }
   if(key == 'n'){ //when key 'n' pressed
      m = m/deltaM; //make half double since deltaM is 2
   }
}
