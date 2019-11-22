public class Mud{
  
  PImage m;
  private float x;
  private float y;
  
   
  public Mud(int lane){
    x = width + random(200);
    y = 400 + 40 * lane;
    m = loadImage("./img/mud.png");
  }
  
  public void display(){
    image(m, bgx + x, y);
  }
  
}
