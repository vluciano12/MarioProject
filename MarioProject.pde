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

final static float WIDTH = SPRITE_SIZE * 16;
final static float HEIGHT = SPRITE_SIZE * 12;
final static float GROUND_LEVEL = HEIGHT - SPRITE_SIZE;


Player player;
PImage grass, crate, greenBrick, coin, spider, p;
ArrayList<Sprite> platforms;
ArrayList<Sprite> coins;
ArrayList<Sprite> enemies;
Enemy enemy;

boolean isGameOver;
int numCoins;
float viewX = 0;
float viewY = 0;

void setup(){
  size(800,600);
  imageMode(CENTER);
  p = loadImage("pStandR.png");
  player = new Player(p, 0.5);
  player.setBottom(GROUND_LEVEL);
  player.centerX = 100;
  
  isGameOver = false;
  numCoins = 0;
  platforms = new ArrayList<Sprite>();
  coins = new ArrayList<Sprite>();
  enemies = new ArrayList<Sprite>();
  
  grass = loadImage("grass.png");
  greenBrick = loadImage("brick.png");
  coin = loadImage("coin_0.png");
  spider = loadImage("spider0.png");
  createPlatforms("map.csv");
}

void draw(){
  scroll();
  
  displayAll();
  
  if(!isGameOver){
    updateAll();
    collectCoins();
    checkDeath();
    enemyKill();
  }
  
  
  //collectCoins();
  //checkDeath();
}

void displayAll(){
  background(255);
  for(Sprite s : platforms)
    s.display();
    
  for(Sprite c : coins){
    c.display();
  }
  for(Sprite e : enemies){
    e.display();
  }
  
  player.display();
  
  fill(255,0,0);
  textSize(32);
  text("Coins: " + numCoins, viewX + 50, viewY + 50);
  text("Lives: " + player.lives, viewX + 50, viewY + 100);
  
  if(isGameOver){
    fill(0,0,255);
    text("GAME OVER!", viewX + width/2 - 100, viewY + height/2);
    if(player.lives == 0)
      text("You lose!", viewX + width/2 - 100, viewY + height/2 + 50);
    else
      text("You win!", viewX + width/2 - 100, viewY + height/2 + 100);
    text("Press SPACE to restart!", viewX + width/2 - 100, viewY + height/2 + 100);
  }
}

void updateAll(){
  player.updateAnimation();
  resolvePlatCollisions(player, platforms);
  for(Sprite c : coins){
    ((AnimatedSprite)c).updateAnimation();
  }
  for(Sprite e : enemies){
    e.update();
    ((AnimatedSprite)e).updateAnimation();
  }
  collectCoins();
  checkDeath();
  enemyKill();
}

void checkDeath(){
  ArrayList<Sprite> colEnemy = checkCollisionList(player, enemies);
  boolean fallCliff = player.getBottom() > GROUND_LEVEL;
  if(colEnemy.size() > 0 && player.onPlatform || fallCliff){
    player.lives--;
    if(player.lives == 0) isGameOver = true;
    else{
      player.centerX = 100;
      player.setBottom(GROUND_LEVEL);
    }
  }
}

void enemyKill(){
  ArrayList<Sprite> colEnemy = checkCollisionList(player, enemies);
  if(colEnemy.size() > 0 && !player.onPlatform){
    for(Sprite e : colEnemy){
      enemies.remove(e);
      player.changeY = -JUMP_SPEED;
    }
  }
  
}

void collectCoins(){
  ArrayList<Sprite> coinList = checkCollisionList(player, coins);
  if(coinList.size() > 0){
     for(Sprite coin : coinList){
       numCoins++;
       coins.remove(coin);
     }
  }
  if(coins.size() == 0){
    isGameOver = true;
  }
}

void scroll(){
  float rBoundary = viewX + width - RIGHT_MARGIN;
  if(player.getRight() > rBoundary) viewX += player.getRight() - rBoundary;
  
  float lBoundary = viewX + LEFT_MARGIN;
  if(player.getLeft() < lBoundary) viewX -= lBoundary - player.getLeft();
  
  float bBoundary = viewY + height - VERTICAL_MARGIN;
  if(player.getBottom() > bBoundary) viewY += player.getBottom() - bBoundary;
  
  float tBoundary = viewY + VERTICAL_MARGIN;
  if(player.getTop() < tBoundary) viewY -= tBoundary - player.getTop();
  
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
  if(keyCode == RIGHT){player.changeX = MOVE_SPEED;}
  else if(keyCode == LEFT){player.changeX = -MOVE_SPEED;}
  else if(keyCode == UP && isOnPlatforms(player, platforms)){player.changeY = -JUMP_SPEED;}
  
}

void keyReleased(){
  if(keyCode == RIGHT || keyCode == LEFT){player.changeX = 0;}
  if(keyCode == UP){player.changeY = 0;}
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
      } else if(values[col].equals("4")){
        float bL = col * SPRITE_SIZE;
        float bR = bL + 4 * SPRITE_SIZE;
        Enemy e = new Enemy(spider, 50/72.0, bL, bR);
        e.centerX = SPRITE_SIZE/2 + col * SPRITE_SIZE;
        e.centerY = SPRITE_SIZE/2 + row * SPRITE_SIZE;
        enemies.add(e);
      }
    }
  }
}  
