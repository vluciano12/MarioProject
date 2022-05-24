public class Enemy extends AnimatedSprite{
  float boundaryL, boundaryR;
  public Enemy(PImage img, float scale, float bL, float bR){
    super(img, scale);
    moveL = new PImage[3];
    moveL[0] = loadImage("spider0.png");
    moveL[1] = loadImage("spider1.png");
    moveL[2] = loadImage("spider2.png");
    moveR = new PImage[3];
    moveR[0] = loadImage("spider0.png");
    moveR[1] = loadImage("spider1.png");
    moveR[2] = loadImage("spider2.png");
    currentImgs = moveR;
    
    dir = RIGHT_FACING;
    boundaryL = bL;
    boundaryR = bR;
    changeX = 2;
  }
  
  void update(){
    super.update();
    if(getLeft() <= boundaryL){
      setLeft(boundaryL);
      changeX *= -1;
    } else if (getRight() >= boundaryR){
      setRight(boundaryR);
      changeX *= -1;
    }
  }
}
