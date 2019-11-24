public class Bike{
  
  private PImage bd;
  private PImage bm;
  private PImage bu;
  private PImage costume;
  private int topSpeed;
  private int zoomAccel;
  private int boostRemainingCounter;
  private boolean isAccelerating;
  private boolean warning;
  private boolean warning2;
  private boolean boostZoom; //to tell if Bike just hit Boost arrows
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
    
    boostRemainingCounter-=1;                      //variable that ends the boost
    if(boostZoom && boostRemainingCounter>0){      //runs during a current boost
       zoomAccel = 10;
    }
    else{                                          //when boost is done reset boost variables
      boostZoom = false;
      zoomAccel = 0;
      
      if(boostRemainingCounter<-60)               //allows warning2 to show for specific length of time, change number to increase or decrease warning time "Mud, Boost Lost!"
          warning2=false;
    }
    
    
    accel+=zoomAccel;                              //add any zoom boost to the bike accel, if no current boost then zoomAccel will be 0
    
    
    
    
    
    
    image(costume, x, y);
  }
  
  public void checkMud(){
    for(int i = 0; i < mud.length; i++){
      if(x > bgx + mud[i].x && x < bgx + mud[i].x + 100 && y > mud[i].y-40 && y < mud[i].y +10){
        if(boostZoom==false){                                                                      //when hitting mud without a current boostZoom
          accel = 2;
          isAccelerating = true; //RESET THE ACCELERATOR ANIMATION
           warning = true; 
        }
        else{                                                             //when hitting mud with a current boost
          zoomAccel=0;
          boostRemainingCounter=10;                                       //allows enough time to get off the mud before setting bustZoom=false when boostRemCounter=0 in code elsewhere above
          accel=5;                                                        //slow bike
          warning2=true;                                                  //show warning2
        }
      }  
    }
  }
  
  
  public void checkBoost(){
    
      if(x > boostX && x < boostX + 100 && y > boost.y-40 && y < boost.y +10){                  //check bike riding over with boost arrows
        boostZoom=true;                  
        zoomAccel=10;                                                                          
        boostRemainingCounter=100;                                                              //controls length of boost, higher number means longer boost
      }  
    
  }
  
  
  public void displayWarning(){
    if(warning){
        fill(255);
        text("SHAKE OFF THE MUD!", width/2, 250);
        text("TAP THE LEFT ARROW", width/2, 300); 
    }
    if(warning2){                                                                              //warning2: when bike hits the mud when you currently have a boost
        fill(255);
        text("MUD!", width/2, 250);
        text("BOOST LOST!", width/2, 300); 
      
    }
  }
}
