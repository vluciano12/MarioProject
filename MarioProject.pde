final static float MOVE_SPEED = 5;
final static float SPRITE_SCALE = 55.0 / 128;
final static float SPRITE_SIZE = 55;
final static float GRAVITY = .6;
final static float JUMP_SPEED = 14;

final static float RIGHT_MARGIN = 400;
final static float LEFT_MARGIN = 60;
final static float VERTICAL_MARGIN = 40;

final static int NEUTRAL_FACING = 0;
final static int RIGHT_FACING = 1;
final static int LEFT_FACING = 2;

Sprite p;
PImage grass, crate, greenBrick, coin;
ArrayList<Sprite> platforms;
ArrayList<Sprite> coins;

float viewX = 0;
float viewY = 0;

void setup(){
  size(800,600);
  imageMode(CENTER);
  p = new Sprite("Capture.PNG", 0.5, 100, 300);
  p.changeX = 0;
  p.changeY = 0;
  
  platforms = new ArrayList<Sprite>();
  coins = new ArrayList<Sprite>();
  grass = loadImage("grass.png");
  greenBrick = loadImage("brick.png");
  coin = loadImage("coin_0.png");
  createPlatforms("map.csv");
}

void draw(){
  background(255);
  scroll();
  p.display();
  resolvePlatCollisions(p, platforms);
  
  for(Sprite s : platforms)
    s.display();
    
  for(Sprite c : coins){
    c.display();
    ((AnimatedSprite)c).updateAnimation();
  }
}

void scroll(){
  float rBoundary = viewX + width - RIGHT_MARGIN;
  if(p.getRight() > rBoundary) viewX += p.getRight() - rBoundary;
  
  float lBoundary = viewX + LEFT_MARGIN;
  if(p.getLeft() < lBoundary) viewX -= lBoundary - p.getLeft();
  
  float bBoundary = viewY + height - VERTICAL_MARGIN;
  if(p.getBottom() > bBoundary) viewY += p.getBottom() - bBoundary;
  
  float tBoundary = viewY + VERTICAL_MARGIN;
  if(p.getTop() < tBoundary) viewY -= tBoundary - p.getTop();
  
  translate(-viewX, -viewY);
}

boolean isOnPlatforms(Sprite s, ArrayList<Sprite> walls){
  s.centerY += 5;
  ArrayList<Sprite> colList = checkCollisionList(s, walls);
  s.centerY -= 5;
  if(colList.size() > 0){ return true; } 
  else { return false;  }
}

void resolvePlatCollisions(Sprite s, ArrayList<Sprite> walls){
  s.changeY += GRAVITY;
  
  //vertical
  s.centerY += s.changeY;
  ArrayList<Sprite> colList = checkCollisionList(s, walls);
  if(colList.size() > 0){
    Sprite collided = colList.get(0);
    if(s.changeY > 0){ s.setBottom(collided.getTop()); }
    else if(s.changeY < 0){ s.setTop(collided.getBottom()); }
    
    s.changeY = 0;
  }
  
  //horizontal
  s.centerX += s.changeX;
  colList = checkCollisionList(s, walls);
  if(colList.size() > 0){
    Sprite collided = colList.get(0);
    if(s.changeX > 0){ s.setRight(collided.getLeft()); }
    else if(s.changeX < 0){ s.setLeft(collided.getRight()); }
    
    s.changeX = 0;
  }
}

boolean checkCollision(Sprite s1, Sprite s2){
  boolean noXOverlap = s1.getRight() <= s2.getLeft() || s1.getLeft() >= s2.getRight();
  boolean noYOverlap = s1.getBottom() <= s2.getTop() || s1.getTop() >= s2.getBottom();
  if(noXOverlap || noYOverlap){
    return false;
  } else {return true;}
}

ArrayList<Sprite> checkCollisionList(Sprite s, ArrayList<Sprite> list){
  ArrayList<Sprite> collisionList = new ArrayList<Sprite>();
  for(Sprite p : list){
    if(checkCollision(s, p))
      collisionList.add(p);
  }
  return collisionList;
}


void keyPressed(){
  if(keyCode == RIGHT){p.changeX = MOVE_SPEED;}
  else if(keyCode == LEFT){p.changeX = -MOVE_SPEED;}
  else if(keyCode == UP && isOnPlatforms(p, platforms)){p.changeY = -JUMP_SPEED;}
  
}

void keyReleased(){
  if(keyCode == RIGHT || keyCode == LEFT){p.changeX = 0;}
  if(keyCode == UP){p.changeY = 0;}
}

void createPlatforms(String filename){
  String[] lines = loadStrings(filename);
  for(int row = 0; row < lines.length; row++){
    String[] values = split(lines[row], ",");
    for(int col = 0; col < values.length; col++){
      if(values[col].equals("1")){
        Sprite s = new Sprite(grass, SPRITE_SCALE);
        s.centerX = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.centerY = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      } else if(values[col].equals("2")){
        Sprite s = new Sprite(greenBrick, SPRITE_SCALE);
        s.centerX = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        s.centerY = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        platforms.add(s);
      } else if(values[col].equals("3")){
        Coin c = new Coin(coin, SPRITE_SCALE);
        c.centerX = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        c.centerY = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        coins.add(c);
      }
    }
  }
}  
