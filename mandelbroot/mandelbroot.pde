
public class Mandelbroot{
 
    private final int minColorRange = 0;
    private final int maxColorRange = 256*256*256;
    private final int maxIterations = 256*256*256;
    
    public void drawAll(){
        for(int row = 0; row < height; row++){
            this.drawRow(row);
        }
    }
    
    public void drawRow(int row){
        for(int column = 0; column < width; column++){
            float mappedx = map(column, 0, width,  -2.5, 1.0);
            float mappedy = map(row, 0, height, -2.0, 1.0);
            
            int iteration = this.calculateIteration(mappedx, mappedy);
            color myColor = this.getColor(iteration);
            
            stroke(myColor);
            point(row, column);
            noStroke();
        }
    }
    
    private int calculateIteration(float x0, float y0){
        
        float xtemp;
        float x = 0.0;
        float y = 0.0;
        int iteration = 0;
        
        while ( ((x*x+y*y) <= 4)  &&  (iteration < this.maxIterations)) {
            xtemp = x*x - y*y + x0;
            y = 2*x*y + y0;
            x = xtemp;
            iteration++;
        }
        
        return iteration;
    }
        
    private color getColor(int iteration){
      return int(map(iteration, 0, this.maxIterations, this.minColorRange, this.maxColorRange));
    }
}

int currentRow = 0;
Mandelbroot mandelBroot = new Mandelbroot();

void setup(){
  size(600, 600);
  background(255);
}

void draw(){
  
  fill(0);
  rect(0, 0, 122, 42);
  noFill();
  
  if(currentRow < height){
      mandelBroot.drawRow(currentRow);
      currentRow++;
      float percentage =  100.0 * ((float)currentRow) / ((float)height);
      String percentageStr = String.format("%.2f",percentage) + "%";
      
      
      textAlign(RIGHT, RIGHT);
      textSize(32); 
      fill(255);
      text(percentageStr, 120, 40);
      noFill();
  }
  
  
}
