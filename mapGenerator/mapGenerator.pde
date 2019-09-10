

public class MapGenerator{

  private int realWidth;
  private int realHeight;
  private int mapWidth; 
  private int mapHeight;
  private int pixelsPerSquareInX;
  private int pixelsPerSquareInY;
 
  private color [][] map;
  
  public MapGenerator(int realWidth, int realHeight, int mapWidth, int mapHeight){
    
    this.realWidth = realWidth;
    this.realHeight = realHeight;
    this.mapWidth = mapWidth;
    this.mapHeight = mapHeight;
    
    this.pixelsPerSquareInX = realWidth / mapWidth;
    this.pixelsPerSquareInY = realHeight / mapHeight;
    
    this.map = new color [mapWidth][mapHeight];
  }
  
  public void generate(){
    double value;
    for(int x = 0; x < this.map.length; x++){
      for(int y =0; y < this.map[0].length; y++){
          value = ImprovedNoise.noise((double)x, (double)y, (double)0.0);
          this.map[x][y] = this.noiseToColor(value);
      }
    }
  }
  
  public void draw(){
    int realX, realY;
    for(int x = 0; x < this.map.length; x++){
      for(int y =0; y < this.map[0].length; y++){
        realX = x * this.pixelsPerSquareInX;
        realY = y * this.pixelsPerSquareInY;
        noStroke();
        fill(this.map[x][y]);
        rect(realX,realY,this.pixelsPerSquareInX,this.pixelsPerSquareInY);
        noFill();
      }
    }
  }
  
  private int noiseToColor(double noise){
    println(noise);
    return 0;
  }
}




MapGenerator m;

void setup(){
  size(500, 500);
  m = new MapGenerator(width, height, 5, 5);
  m.generate();
  m.draw();
}

void mousePressed(){
  m.generate();
  m.draw();
}
