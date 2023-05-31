/* Game Class Starter File
 * Last Edit: 5/22/23
 * Authors: _____________________
 */

//GAME VARIABLES
private int msElapsed = 0;
<<<<<<< HEAD
private int timesGet = 0;
Grid grid = new Grid(5,15);
=======
Grid grid = new Grid(20,20);
>>>>>>> bbe23a4c2177e0765444b5dfeaac2b8d441eb12c
//HexGrid hGrid = new HexGrid(3);
PImage bg;
PImage player1;
PImage player2;
PImage enemy;
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
int player1Col=0;

//items stay still until they are collected


//Required Processing method that gets run once
void setup() {

  //Match the screen size to the background image size
  size(800, 600);

  //Set the title on the title bar
  surface.setTitle(titleText);

  //Load images used
  //bg = loadImage("images/chess.jpg");
  bg = loadImage("images/mansion.jpg");
  bg.resize(800,600);
  player1 = loadImage("images/mchar-transformed.png");
  player1.resize(100,100);
  endScreen = loadImage("images/youwin.png");

  // Load a soundfile from the /data folder of the sketch and play it back
  // song = new SoundFile(this, "sounds/Lenny_Kravitz_Fly_Away.mp3");
  // song.play();

  
  //Animation & Sprite setup
  exampleAnimationSetup();

   imageMode(CORNER);    //Set Images to read coordinates at corners
  //fullScreen();   //only use if not using a specfic bg image
  
  println("Game started...");
}

//Required Processing method that automatically loops
//(Anything drawn on the screen should be called from here)
void draw() {

  updateTitleBar();

  if (msElapsed % 300 == 0) {
    populateSprites();
    moveSprites();
  }

  updateScreen();
  
  if(isGameOver()){
    endGame();
  }

  checkExampleAnimation();
  
  msElapsed +=100;
  grid.pause(100);

}

//Known Processing method that automatically will run whenever a key is pressed
void keyPressed(){

  //check what key was pressed
  System.out.println("Key pressed: " + keyCode); //keyCode gives you an integer for the key

  //What to do when a key is pressed?
  //check collisions
  
  //set "w" key to move the player1 up
  if(player1Row !=0 && keyCode == 87){

    //Erase image from previous location
    GridLocation oldLoc = new GridLocation(player1Row, player1Col);
    grid.clearTileImage(oldLoc);

    //change the field for player1Row
    player1Row--;

  }
if(player1Row !=-1 && keyCode == 83){
    //check case where out of bounds (key s)
    
    //Erase image from previous location
    GridLocation oldLoc = new GridLocation(player1Row, player1Col);
    grid.clearTileImage(oldLoc);

    //change the field for player1Row
    player1Row++;

  }
 if(player1Col !=  grid.getNumCols()-1 && keyCode == 68){

    //Erase image from previous location
    GridLocation oldLoc = new GridLocation(player1Row, player1Col);
    grid.clearTileImage(oldLoc);

    //change the field for player1Col
    player1Col++;
  }
  if(player1Col !=  grid.getNumCols()-1 && keyCode == 65){

    //Erase image from previous location
    GridLocation oldLoc = new GridLocation(player1Row, player1Col);
    grid.clearTileImage(oldLoc);

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
    if(clickedLoc.equals(player1loc)){
      player1Col--;
    }

    //Toggle the animation on & off
    doAnimation = !doAnimation;
    System.out.println("doAnimation: " + doAnimation);
    grid.setMark("X",grid.getGridLocation());
    
  }





//------------------ CUSTOM  METHODS --------------------//

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
  GridLocation player1Loc = new GridLocation(player1Row,player1Col);
  grid.setTileImage(player1Loc, player1);
  
  //Loop through all the Tiles and display its images/sprites
  

      //Store temporary GridLocation
      
      //Check if the tile has an image/sprite 
      //--> Display the tile's image/sprite



  //Update other screen elements
  grid.showImages();
  grid.showSprites();

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
public void checkCollision(){
for(int r = 0; r < grid.getNumRows(); r++){
  for(int c = 1; c <grid.getNumCols(); c++){

    GridLocation current = new GridLocation(r,c);
    GridLocation newLoc = new GridLocation(r, c-1);

    if(grid.hasTileImage(current)){
      //collision occurs
      timesGet++;
      //clear image at original loc
      grid.clearTileImage(current);
    }
  }
}

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
  exampleSprite = new AnimatedSprite("sprites/horse_run.png", 50.0, i*75.0, "sprites/horse_run.json");
}

//example method that animates the horse Sprites
public void checkExampleAnimation(){
  if(doAnimation){
    exampleSprite.animateVertical(5.0, 1.0, true);
  }
}