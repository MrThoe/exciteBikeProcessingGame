public class Bike{
  
  private PImage bd;
  private PImage bm;
  private PImage bu;
  private PImage costume;
  private int topSpeed;
  private boolean isAccelerating;
  private boolean warning;
  private float x;
  private float y;
  public float accel;
  public float lane;
  
  public Bike()
  {
    bd = loadImage("./img/bd.png");
    bm = loadImage("./img/bm.png");
    bu = loadImage("./img/bu.png");
    x = 100;
    y = height - 100;
    costume = bd;
    lane = 5;
  }
    
  public void display(){
    displayWarning();
    checkMud();
    if(lane < 1){
      lane = 1;
    } else if (lane > 4){
      lane = 4;
    }
    y = height - 260 + lane*40;
    if(topSpeed >=30){
       isAccelerating = false;
    } 
    if(accel >= 10){
      accel = 10;
      warning = false;
    } else if(accel >= 6){
      costume = bu;
    } else if (accel > 0){
      costume = bm;
    } else {
      costume = bd;
      accel = 0;
    }
    if(!isAccelerating){
      costume = bd;
    }
    image(costume, x, y);
  }
  
  public void checkMud(){
    for(int i = 0; i < mud.length; i++){
      if(x > bgx + mud[i].x && x < bgx + mud[i].x + 100 && y > mud[i].y-40 && y < mud[i].y +10){
        accel = 2;
        isAccelerating = true; //RESET THE ACCELERATOR ANIMATION
        warning = true;  
      }  
    }
  }
  
  public void displayWarning(){
    if(warning){
        fill(255);
        text("SHAKE OFF THE MUD!", width/2, 250);
        text("TAP THE LEFT ARROW", width/2, 300); 
    }
  }
}
