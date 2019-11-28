public class Jump1{
  
  PImage j;
  private float y;
  
   
  public Jump1(int lane){
    y = 375 + 40 * lane;
    j = loadImage("./img/jump.png");
    j.resize(50,60);
  }
  
  public void display(){
    image(j, jump1X, y);                 //needs its own x value, if using bgx the boost would possibly dissappear when bgx is set to 0
    
  }
  
  public void changeLane(){
    y=375 + 40 * floor(random(4));        //random lane
  }
  
}
