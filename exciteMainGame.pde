PImage bg;
Bike bike;
Time time;
float bgx, bgy;
int count, t;

void setup(){
  size(800, 600);
  bike = new Bike();
  bg = loadImage("./img/excitebike.png"); 
  time = new Time();
}

void draw(){
  moveBg();
  image(bg, bgx, bgy);   
  image(bg, bgx + bg.width, bgy);
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

void moveBg(){
 bgx -= bike.accel;
 if(bgx < -bg.width){
   bgx = 0;
 }
}
void keyPressed(){
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
