public class Boost{
  
  PImage b;
  private float y;
  
   
  public Boost(int lane){
    y = 400 + 40 * lane;
    b = loadImage("./img/boost.PNG");
    b.resize(50,30);
  }
  
  public void display(){
    image(b, boostX, y);                 //needs its own x value, if using bgx the boost would possibly dissappear when bgx is set to 0
  }
  
  public void changeLane(){
    y=400 + 40 * floor(random(4));        //random lane
  }
  
}
