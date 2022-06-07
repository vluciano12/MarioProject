public class Player extends AnimatedSprite{
  int lives;
  boolean onPlatform, inPlace;
  PImage[] standL;
  PImage[] standR;
  PImage[] jumpL;
  PImage[] jumpR;
  
  public Player(PImage img, float scale){
    super(img, scale);
    lives = 3;
    dir = RIGHT_FACING;
    onPlatform = false;
    inPlace = true;
    standL = new PImage[1];
    standL[0] = loadImage("pStandL.png");
    standR = new PImage[1];
    standR[0] = loadImage("pStandR.png");
    jumpL = new PImage[6];
    jumpL[0] = loadImage("pJumpL0.png");
    jumpL[1] = loadImage("pJumpL1.png");
    jumpL[2] = loadImage("pJumpL2.png");
    jumpL[3] = loadImage("pJumpL3.png");
    jumpL[4] = loadImage("pJumpL4.png");
    jumpL[5] = loadImage("pJumpL5.png");
    jumpR = new PImage[6];
    jumpR[0] = loadImage("pJumpR0.png");
    jumpR[1] = loadImage("pJumpR1.png");
    jumpR[2] = loadImage("pJumpR2.png");
    jumpR[3] = loadImage("pJumpR3.png");
    jumpR[4] = loadImage("pJumpR4.png");
    jumpR[5] = loadImage("pJumpR5.png");
    moveL = new PImage[4];
    moveL[0] = loadImage("pMoveL0.png");
    moveL[1] = loadImage("pMoveL1.png");
    moveL[2] = loadImage("pMoveL2.png");
    moveL[3] = loadImage("pMoveL3.png");
    moveR = new PImage[4];
    moveR[0] = loadImage("pMoveR0.png");
    moveR[1] = loadImage("pMoveR1.png");
    moveR[2] = loadImage("pMoveR2.png");
    moveR[3] = loadImage("pMoveR3.png");
    currentImgs = standR;
  }
  
  @Override
  public void updateAnimation(){ 
    onPlatform = isOnPlatforms(this, platforms);
    inPlace = changeX == 0 && changeY == 0;
    super.updateAnimation();
  }
  
  @Override
  public void selectDirection(){
    if(changeX > 0) dir = RIGHT_FACING;
    else if(changeX < 0) dir = LEFT_FACING;
  }
  
  @Override
  public void selectCurImgs(){
    if(dir == RIGHT_FACING){
      if(inPlace) currentImgs = standR;
      else if(!onPlatform) currentImgs = jumpR;
      else currentImgs = moveR;
    }
    if(dir == LEFT_FACING){
      if(inPlace) currentImgs = standL;
      else if(!onPlatform) currentImgs = jumpL;
      else currentImgs = moveL;
    }
  }
  
}
