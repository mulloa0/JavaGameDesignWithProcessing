/* Game Class Starter File
 * Last Edit: 5/22/23
 * Authors: _____________________
 */

//GAME VARIABLES
private int msElapsed = 0;
private int timesGet = 0;
//Grid grid = new Grid(5,15);
Grid grid = new Grid(20,20);
//HexGrid hGrid = new HexGrid(3);
PImage bg;
//PImage player1;
AnimatedSprite p1;
PImage player2;
PImage enemy;
PImage key; 
PImage drawer;
PImage hairclip;
PImage tv;
ArrayList<String> item = new ArrayList<String>();
AnimatedSprite enemySprite;
PImage endScreen;
String titleText = "Murder Mystery";
String extraText = "Mansion Conspiracy -Maria & Sadia";
AnimatedSprite exampleSprite;
boolean doAnimation;

//HexGrid hGrid = new HexGrid(3);
//import processing.sound.*;
//SoundFile song;

int player1Row = 3;
int player1Col = 0;

ArrayList<String> marks = new ArrayList<String>();



//Required Processing method that gets run once
void setup() {

  //Match the screen size to the background image size
  size(800, 600);

  //Set the title on the title bar
  surface.setTitle(titleText);

  //Pixel width of one tile: 40
  //Pixel height of one tile: 30
  
  //Load images used
  //bg = loadImage("images/chess.jpg");
  bg = loadImage("images/mansion.jpg");
  bg.resize(800,600);
  //player1 = loadImage("images/mchar-transformed.png");
  //player1.resize(80,60);
  key = loadImage("images/key.png");
  key.resize(50,50);
  drawer = loadImage("images/drawer.png");
  drawer.resize(80,60);
  hairclip = loadImage("images/hairclip-removebg-preview.png");
  hairclip.resize(80,60);
  tv = loadImage("images/tv-removebg-preview.png");
  tv.resize(120,90);
  endScreen = loadImage("images/youwin.png");

  // Load a soundfile from the /data folder of the sketch and play it back
  // song = new SoundFile(this, "sounds/Lenny_Kravitz_Fly_Away.mp3");
  // song.play();

  //set up the images
  itemSetup();

  //loop through to find marks
  
  //Animation & Sprite setup
  animationSetup();

   imageMode(CORNER);    //Set Images to read coordinates at corners
  //fullScreen();   //only use if not using a specfic bg image
  
  println("Game started...");
}

//Required Processing method that automatically loops
//(Anything drawn on the screen should be called from here)
void draw() { 

  updateTitleBar();

  // if (msElapsed % 300 == 0) {
  //   populateSprites();
  //   moveSprites();
  // }

  updateScreen();
  
  if(isGameOver()){
    endGame();
  }

  //checkExampleAnimation();
  
  msElapsed +=100;
  grid.pause(100);

}

//Known Processing method that automatically will run whenever a key is pressed
void keyPressed(){

  //check what key was pressed
  System.out.println("Key pressed: " + keyCode); //keyCode gives you an integer for the key

  //What to do when a key is pressed?B
  

  //set "w" key to move the player1 up
  if(player1Row !=0 && keyCode == 87){
    
    //Erase image from previous location
    GridLocation oldLoc = new GridLocation(player1Row, player1Col);
    
    grid.clearTileSprite(oldLoc);

    //change the field for player1Row
    player1Row--;
    
    


  }
if(player1Row != grid.getNumRows()-2 && keyCode == 83){
    //check case where out of bounds (key s)
    
    //Erase image from previous location
    GridLocation oldLoc = new GridLocation(player1Row, player1Col);
    grid.clearTileSprite(oldLoc);

    //change the field for player1Row
    player1Row++;

  }
 if(player1Col != grid.getNumCols()-2 && keyCode == 68){

    //Erase image from previous location
    GridLocation oldLoc = new GridLocation(player1Row, player1Col);
    grid.clearTileSprite(oldLoc);

    //change the field for player1Col
    player1Col++;
  }
  if(player1Col !=0 && keyCode == 65){

    //Erase image from previous location
    GridLocation oldLoc = new GridLocation(player1Row, player1Col);
    grid.clearTileSprite(oldLoc);

    //change the field for player1Col
    player1Col--;
  }
}

  //Known Processing method that automatically will run when a mouse click triggers it
  void mouseClicked(){
  
    //check if click was successful
    System.out.println("Mouse was clicked at (" + mouseX + "," + mouseY + ")");
    System.out.println("Grid location: " + grid.getGridLocation());

    //what to do if clicked?
    GridLocation clickedLoc= grid.getGridLocation();
    GridLocation player1loc= new GridLocation(player1Row,player1Col);

    //check if the lcoations are within 1
    if(clickedLoc.equals(player1loc)){

      //check if any nearby tiles hold any marks --> return the String
      player1Col--;
    }


    //is an object nearby
    //loop thru the 3x3 grid surrouding player




    //Toggle the animation on & off
    doAnimation = !doAnimation;
    System.out.println("doAnimation: " + doAnimation);
    grid.setMark("X",grid.getGridLocation());
    
  }





//------------------ CUSTOM  METHODS --------------------//

public void itemSetup(){

  GridLocation haircliploc = new GridLocation(10, 2);
  grid.setTileImage(haircliploc, hairclip);

  //Display key
  GridLocation drawerloc = new GridLocation(5, 2);
  grid.setTileImage(drawerloc, drawer);

  GridLocation tvloc = new GridLocation (15, 15);
  grid.setTileImage(tvloc, tv);

  //set marks
  System.out.println(grid.setNewMark("key", drawerloc));
  System.out.println(grid.setNewMark("hairclip", haircliploc));
  System.out.println(grid.setNewMark("tv", tvloc));

  //marks.add(0,"key");
  

}

//method to update the Title Bar of the Game
public void updateTitleBar(){

  if(!isGameOver()) {
    //set the title each loop
    surface.setTitle(titleText + "    " + extraText);

    //adjust the extra text as desired
  
  }

}

//method to update what is drawn on the screen each frame
public void updateScreen(){

  //update the background
  background(bg);

  //Display the Player1 image
  // GridLocation player1Loc = new GridLocation(player1Row,player1Col);
  // grid.setTileImage(player1Loc, player1);

  GridLocation p1Loc= new GridLocation(player1Row,player1Col);
  grid.setTileSprite(p1Loc, p1);

  //Update other screen elements
  grid.showImages();
  grid.showSprites();
  grid.showGridSprites();

}

//Method to populate enemies or other sprites on the screen
public void populateSprites(){

  //What is the index for the last column?
  int lastCol = grid.getNumCols()-1;

  //Loop through all the rows in the last column
  for(int r=0; r<grid.getNumRows(); r++){

    //Generate a random number
    double rando = Math.random();

    //10% of the time, decide to add an image to a Tile
    if(rando < 0.1){
      //grid.setTileImage(new GridLocation(r,lastCol), enemy);
      //System.out.println("Populating in row " + r);
      grid.setTileSprite(new GridLocation(r, lastCol), enemySprite);
    }

  }


}

//Method to move around the enemies/sprites on the screen
public void moveSprites(){

  //Loop through all of the cells in the grid
  for (int r = 0; r < grid.getNumRows(); r++) {
    for (int c = 1; c < grid.getNumCols(); c++) {

      //Store the 2 locations to move
      GridLocation loc = new GridLocation(r, c);
      GridLocation newLoc = new GridLocation(r, c - 1);
      
      // Check if the current tile has an image and is NOT the player1
      // if(grid.hasTileImage(loc) && !grid.getTileImage(loc).equals(player1) ){
      if(grid.hasTileSprite(loc) ){
        //System.out.println("Moving sprite found at loc " + loc);

        //Get image from current location
        //PImage img = grid.getTileImage(loc);
        AnimatedSprite sprite = grid.getTileSprite(loc);

        //Set image to new Location 
        //grid.setTileImage(newLoc, img);
        //System.out.println("Moving to newLoc" + newLoc);
        grid.setTileSprite(newLoc, sprite);

        //Erase image from old location
        //grid.clearTileImage(loc);
        grid.clearTileSprite(loc);

        //System.out.println(loc + " " + grid.hasTileImage(loc));
      }

      //What is at the first column?
      if (c == 1) {
        grid.clearTileImage(newLoc);
        grid.clearTileSprite(newLoc);
      }

    }
  }
}

//Method to handle the collisions between Sprites on the Screen

//it checks collisions - requires two parameters
public boolean checkCollision(GridLocation current, GridLocation newLoc){
  

//get image at current location first, if any
PImage image = grid.getTileImage(current);

//if nothing is there, there can't be a collision
if(image == null){
  return false;
}

//get image at new location, if any
PImage newImage = grid.getTileImage(newLoc);
Sprite sprite = grid.getTileSprite(newLoc);

//if nothing is at new location, there can't be a collision 
if(newImage == null){
  return false;
}

//check if player interacts with item or npc
// if(player1.equals(image) && key.equals(newImage)){
if(p1.equals(sprite) && key.equals(newImage)){
    grid.clearTileSprite(current);
}

return true;


}

public void handleCollisions(){


}

//method to indicate when the main game is over
public boolean isGameOver(){ 
  return false; //by default, the game is never over
}

//method to describe what happens after the game is over
public void endGame(){
    System.out.println("Game Over!");

    //Update the title bar

    //Show any end imagery
    image(endScreen, 100,100);

}

//example method that creates 5 horses along the screen
public void exampleAnimationSetup(){  
  int i = 2;
  exampleSprite = new AnimatedSprite("sprites/horse_run.png", "sprites/horse_run.json");
}

public void animationSetup(){  
  
  p1 = new AnimatedSprite("sprites/MC_AKey.png", "sprites/MC_AKey.json");
  p1.resize(50,80);
  GridLocation p1Loc= new GridLocation(player1Row,player1Col);
  grid.setTileSprite(p1Loc, p1);

}

//example method that animates the horse Sprites
public void checkExampleAnimation(){
  if(doAnimation){
    exampleSprite.animateVertical(5.0, 1.0, true);
  }
}