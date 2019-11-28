public class Bike{
  
  private PImage bd;
  private PImage bm;
  private PImage bu;
  private PImage costume;
  private int topSpeed;
  private int zoomAccel;
  private int boostRemainingCounter;
  private float jump1gravity;
  private float jump1displacement;
  private boolean isAccelerating;
  private boolean warning;
  private boolean warning2;
  private boolean boostZoom;                                         //to tell if Bike just hit Boost arrows
  private boolean jump1inAir;                                        //to tell if bike is in air after hitting jump1
  
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
    jump1gravity=0;
    jump1displacement=0;
    jump1inAir=false;
  }
    
  public void display(){
    displayWarning();
    
                                                       //if not in air, check for mud collision and for jumps
    checkMud();
    checkJump1();
    checkBoost();
    
    if(lane < 1){
      lane = 1;
    } else if (lane > 4){
      lane = 4;
    }
    y = height - 260 + lane*40 - jump1displacement;                        //gravity will change the height of the bike, unless jump1gravity=0
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
    if(jump1inAir){
      costume=bm;                                  //jumping costume
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
    if(!jump1inAir){                                                                                //only check for mud when not in air
      
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
  }
  
  
  
  public void checkJump1(){
    
      if(!jump1inAir && x > jump1X && x < jump1X + 30 && y > jump1.y-10 && y < jump1.y +10){                  //check bike riding over with jump, only if not in air
        jump1gravity=8;                                                                                        //jump1gravity controls height of jump, must change value in if statement below too
        jump1inAir=true;                                                                                        //lets rest of program know bike is in the air  
        accel+=10;                                                                                              //give a slight horizontal boost so stationary bike will not continue to "bounce"
      }  
      
      
      
      if(jump1inAir){                                                                                        //while in the air
        
        jump1displacement+=jump1gravity;                                                                    //change height of bike with a dynamic gravity variable
        jump1gravity-=0.2;                                                                                  //slow the upward movement, and decrease the downard movement after jump hits peak
        
      }
      
      if(jump1inAir && jump1gravity<-8){                                                                   //when the bike is back on the ground
        jump1inAir=false;                                                                                    //tell program bike is back on ground
        jump1displacement=0;                                                                                //reset displacement so the bike will not have vertical movement
        
      }
    
  }
  
  
  
  
  
  public void checkBoost(){
    
      if(!jump1inAir && x > boostX && x < boostX + 100 && y > boost.y-40 && y < boost.y +10){                  //check bike riding over with boost arrows
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
  
  public boolean getJump1inAir(){
    return jump1inAir;
  }
  
}
