public class Coin extends AnimatedSprite{
  
  public Coin(PImage img, float scale){
    super(img, scale);
    standNeutral = new PImage[5];
    standNeutral[0] = loadImage("coin_0.png");
    standNeutral[1] = loadImage("coin_1.png");
    standNeutral[2] = loadImage("coin_2.png");
    standNeutral[3] = loadImage("coin_3.png");
    standNeutral[4] = loadImage("coin_4.png");
    currentImgs = standNeutral;
  }
}
