public class AnimatedSprite extends Sprite{
  PImage[] currentImgs;
  PImage[] standNeutral;
  PImage[] moveL;
  PImage[] moveR;
  int dir;
  int index;
  int frame;
  
  public AnimatedSprite(PImage img, float scale){
    super(img, scale);
    dir = NEUTRAL_FACING;
    index = 0;
    frame = 0;
  }
  
  void updateAnimation(){
    frame++;
    if(frame % 5 == 0){
      selectDirection();
      selectCurImgs();
      advToNextImg();
    }
  }
  
  void selectDirection(){
    if(changeX > 0){ dir = RIGHT_FACING; }
    else if(changeY < 0){ dir = LEFT_FACING; }
    else { dir = NEUTRAL_FACING; }
  }
  
  void selectCurImgs(){
    if(dir == RIGHT_FACING){ currentImgs = moveR; }
    else if(dir == LEFT_FACING){ currentImgs = moveL; }
    else{ currentImgs = standNeutral; }
  }
  
  void advToNextImg(){}
  
}
