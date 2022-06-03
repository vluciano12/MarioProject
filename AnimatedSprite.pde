// YOU DO NOT NEED TO MODIFY THIS CLASS.


public class AnimatedSprite extends Sprite{
  PImage[] currentImgs;
  PImage[] standNeutral;
  PImage[] moveL;
  PImage[] moveR;
  int dir;
  int index;
  int frame;
  // implement the constructor, remember to call super() appropriately.
  // initialize direction, index and frame. The PImage arrays can be initialized
  // as null. 
  public AnimatedSprite(PImage img, float scale){
    super(img, scale);    
    dir = NEUTRAL_FACING;
    index = 0;
    frame = 0;
  }
  // frame is increased by 1
  // every 5 frames do:
  //    call selectionDirection
  //    call selectCurrentImages
  //    call advanceToNextImage
  public void updateAnimation(){
    frame++;
    if(frame % 5 == 0){
      selectDirection();
      selectCurImgs();
      advToNextImg();
    }
  }
  // if sprite is moving right, set direction to RIGHT_FACING
  // else if it is moving left, set direction to LEFT_FACING
  // otherwise set it to NEUTRAL_FACING
  public void selectDirection(){
    if(change_x > 0)
      dir = RIGHT_FACING; //<>//
    else if(change_x < 0)
      dir = LEFT_FACING;    
    else
      dir = NEUTRAL_FACING;  
  }

  // if direction is RIGHT_FACING, LEFT_FACING or NEUTRAL_FACING
  // set currentImages to the appropriate PImage array. 
  public void selectCurImgs(){
    if(dir == RIGHT_FACING)
      currentImgs = moveR;
    else if(dir == LEFT_FACING)
      currentImgs = moveL;
    else
      currentImgs = standNeutral;
  }
  // increase index by 1
  // if index is at end of array loop back to 0
  // assign image variable(from Sprite class) to currentImages at index.
  public void advToNextImg(){
    index++;
    if(index >= currentImgs.length)
      index = 0;
    image = currentImgs[index];
  }
}
