
public class Board{

  private int boardWidth;
  private int boardHeight;
  private int pixelsPerSquareInX;
  private int pixelsPerSquareInY;
  
  private boolean [][] board;
  
  public Board(int boardWidth, int boardHeight, int widthLimit, int heightLimit){
    
    this.boardWidth = boardWidth;
    this.boardHeight = boardHeight;
    
    this.pixelsPerSquareInX = (width - widthLimit) / boardWidth;
    this.pixelsPerSquareInY = (height - heightLimit) / boardHeight;
    
    this.board = new boolean [boardWidth][boardHeight];
  }
  
  public void add(int xBoard, int yBoard) {
    this.board[xBoard][yBoard] = true;
  }
  
  public void delete(int xBoard, int yBoard) {
    this.board[xBoard][yBoard] = false;
  }
  
  public void update(){
    ArrayList<int[]> pointsToUpdate = new ArrayList<int[]>();
    
    for(int x = 0; x < this.boardWidth; x++ ){
      for(int y = 0; y < this.boardHeight; y++ ){
          if(this.needUpdate(x, y))
            pointsToUpdate.add(new int [] {x, y});
      }
    }
    
    for(int[]point : pointsToUpdate)
      this.board[point[0]][point[1]] = !this.board[point[0]][point[1]] ;
    
  }

  private boolean needUpdate(int xBoard, int yBoard) {
    int numNeighbor = this.countNeighbors(xBoard, yBoard);
    boolean isCellAllive = this.isAlive(xBoard, yBoard);
    if(isCellAllive)
      return (numNeighbor < 2 || numNeighbor > 3);
    else
      return (numNeighbor == 3);
  }
    
  private boolean isAlive(int xBoard, int yBoard){
    return this.board[xBoard][yBoard];
  }
  
  private int countNeighbors(int xBoard, int yBoard){
    int numNeighbors = 0;
    for(int y = yBoard-1; y <= yBoard+1; y++ ){
      for(int x = xBoard-1; x <= xBoard+1; x++ ){
        if( x >= 0 && x < this.boardWidth && y >= 0 && y < this.boardHeight){
          if((x != xBoard || y!= yBoard) && this.isAlive(x, y)){
            numNeighbors++;
          }
        }
      }
    }
    return numNeighbors;
  }
  
  public void draw(int xBoard, int yBoard){
    int xReal = xBoard * this.pixelsPerSquareInX;
    int yReal = yBoard * this.pixelsPerSquareInY;
    
    if(this.isAlive(xBoard,yBoard))
      fill(0);
    else
      fill(255);
    rect(xReal, yReal, this.pixelsPerSquareInX, this.pixelsPerSquareInY);
  }
  
  public void drawAll(){
    //clear and set background
    clear();
    background(255);
    //draw each pixel
    for(int x = 0; x < this.boardWidth; x++ ){
      for(int y = 0; y < this.boardHeight; y++ ){
         this.draw(x, y);
      }
    }
  }
  
  public int xRealToBoard(int x){
    return x / this.pixelsPerSquareInX;
  }
  
  public int yRealToBoard(int y){
    return y / this.pixelsPerSquareInY;
  }
  
}

Board b;
int statePanelSize;
boolean cellUpdateEnabled = false;

void setup(){
  size(500, 500);
  statePanelSize = 50;
  b = new Board(50, 50, 0, statePanelSize);
  background(255);
  b.drawAll();
  drawStatePanel();
}

void draw(){
  if(cellUpdateEnabled){
    b.update();
    b.drawAll();
    drawStatePanel();
    delay(500);
  }
}

void mousePressed(){
  
  int xBoard = b.xRealToBoard(mouseX);
  int yBoard = b.yRealToBoard(mouseY);

  if( mouseY > height - statePanelSize){
    cellUpdateEnabled = !cellUpdateEnabled;
    drawStatePanel();
  }else{
    if(!cellUpdateEnabled 
      && mouseY < height-statePanelSize
    ){
      if(mouseButton == LEFT){
        b.add(xBoard, yBoard);
        b.draw(xBoard, yBoard);
      }else if(mouseButton == RIGHT){
        b.delete(xBoard, yBoard);
        b.draw(xBoard, yBoard);
      }
    }
  }
}

void drawStatePanel(){
  if(cellUpdateEnabled)
    fill(222, 78, 78);
  else
    fill(72, 219, 97);
  rect(0, height-statePanelSize-1, width, height);
  noFill();
}
