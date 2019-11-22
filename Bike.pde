public class Bike{
  
  private PImage bd;
  private PImage bm;
  private PImage bu;
  private PImage costume;
  private int topSpeed;
  private boolean isAccelerating;
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
    
}
