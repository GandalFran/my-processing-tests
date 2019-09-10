
final float RADIUS_ = 200.0;
final float CENTER_X = 200.0, CENTER_Y = 200.0;

public class Point{

  float x, y;
  
  public Point(){
    this.x = random(0, 400);
    this.y = random(0, 400);
  }
  
  float getX(){
    return this.x;
  }
  
  float getY(){
    return this.y;
  }

  boolean isInside(){
    float distance = sqrt((this.x-CENTER_X)*(this.x-CENTER_X) + (this.y-CENTER_Y)*(this.y-CENTER_Y));
    return (distance < RADIUS_);
  }
}

void setup(){
  size(400, 500);
  background(255, 255, 255);
  
  fill(0);
  rect(0.0, 0.0, 400.0, 400.0);
  noFill();
  
  stroke(255);
  circle(CENTER_X, CENTER_Y, RADIUS_*2);
  noStroke();
}

int numPoints = 0, numPointsInside = 0;

void draw(){
  
  Point p = new Point();
  
  numPoints++;
  if(p.isInside()){
      numPointsInside++;
  }
  
  float current_pi = (4 * (float)numPointsInside) / numPoints;
  String pi_str = String.format("%f",current_pi);
  println(pi_str);
  
  stroke(36, 252, 3);
  point(p.getX(), p.getY());
  noStroke();

  if(p.isInside())
    fill(0,255,0);
  else
    fill(255,0,0);
  rect(0.0, 400.0, 400.0, 100.0);
  noFill();  
  
  textSize(32);
  fill(0);
  text(pi_str, 150.0, 450.0); 
  noFill();
  
  delay(delay_time);
}

int delay_time = 300;

void keyPressed(){
  if(keyCode == UP && delay_time > 0){
    delay_time -= 10;
  }else if(keyCode == DOWN){
    delay_time += 10;
  }
}
