public class Time{
  
  private float timer;
  private float counter;
  
  public Time(){
    timer = 0;  
    counter = 0;
  }
  
  public void display(){
    fill(10,10,10,100);
    rect(18, 12, 200, 40);
    textSize(33);
    fill(255);
    text("Time: " + timer, 20, 45);  //TOP LEFT CORNER   
  }
  
  public void update(){
    counter++;
    timer = counter/100;
  }
  
  public void reset(){
    counter = 0;
  }
}
