public class Sprite{
  PImage image;
  float centerX, centerY;
  float changeX, changeY;
  float w, h;
  
  public Sprite(String filename, float scale, float x, float y){
    image = loadImage(filename);
    w = image.width * scale;
    h = image.height * scale;
    centerX = x;
    centerY = y;
    changeX = 0;
    changeY = 0;
  }
  
  public Sprite(String filename, float scale){
    this(filename, scale, 0, 0);
  }
  
  public Sprite(PImage img, float scale){
    image = img;
    w = img.width * scale;
    h = img.height * scale;
    centerX = 0;
    centerY = 0;
    changeX = 0;
    changeY = 0;
  }
  
  public void display(){image(image, centerX, centerY, w, h);}
  
  public void update(){
    centerX += changeX;
    centerY += changeY;
  }
  
  void setLeft(float left){ centerX = left + w/2; }
  
  float getLeft(){ return centerX - w/2; }
  
  void setRight(float right){ centerX = right - w/2; }
  
  float getRight(){ return centerX + w/2; }
  
  void setTop(float top){ centerY = top + h/2; }
  
  float getTop(){ return centerY - h/2; }
  
  void setBottom(float bottom){ centerY = bottom - h/2; }
  
  float getBottom(){ return centerY + h/2; }
}
