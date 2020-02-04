PImage bg;
Bike bike;
Time time;
Mud[] mud;
Boost boost;
float bgx, bgy, boostX;
boolean boostNotShowing;
int count, t, boostFrequency;

void setup(){
  size(800, 600);
  bike = new Bike();
  bg = loadImage("./img/excitebike.png"); 
  time = new Time();
  mud = new Mud[2];
  for(int i = 0; i < mud.length; i++){
    mud[i] = new Mud(2*i);
  }
  
  boost = new Boost(floor(random(4)));                //randomly pick lane
  boostNotShowing=true;                               //boost is not showing, allows for only one boost at a time to be on screen
  boostFrequency=100;                                 //how often boost appears, higher number is less often
  boostX=-100;                                        //boost starts off screen to left
}

void draw(){
  moveBg();
  image(bg, bgx, bgy);   
  image(bg, bgx + bg.width, bgy);
  displayMud();
  displayBoost();
  bike.checkMud();
  bike.checkBoost();
  bike.display();
  if(!keyPressed){
      if(bike.accel >=1 && count%4 == 0){
        bike.accel--;
        bike.topSpeed = 0;
      }
  }
  count++;
  time.display();
  time.update();
}

public void displayMud(){
  for (int i = 0; i < mud.length ; i++){
    mud[i].display();
  }
}


public void displayBoost(){
  boost.display();
  int num = floor(random(boostFrequency));    //pick a random num to possibly show next boost
  
  if(num==0 && boostNotShowing)               //if other boost not showing and random number is 0, show new boost
  {
    boostX=900;                               //just off screen to right
    boost.changeLane();                       //new lane
    boostNotShowing=false;                    //allows only one boost to be displayed at a time
  }
  if(boostX<-40){                             //when boost is off screen, make it possible for next boost to show
    boostNotShowing=true;
  }
  
  
}


void moveBg(){
 bgx -= bike.accel;
 boostX-=bike.accel;                         //the boost arrows will move at same speed of background
 if(bgx < -bg.width){
   bgx = 0;
   
 }
}
void keyPressed(){                          //THIS ONL WQORKS WITH ARROW KEYS
  if(key == CODED){
    if (keyCode == UP){
      bike.lane--;
    } else if (keyCode == DOWN){
      bike.lane++;
    } else if (keyCode == LEFT){
      bike.accel++;
      bike.isAccelerating = true;
      bike.topSpeed++;
    } else if(keyCode == RIGHT){
      bike.accel = 5;
    } 
  } 
} 
