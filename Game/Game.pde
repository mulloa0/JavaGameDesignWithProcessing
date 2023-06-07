/* Game Class Starter File
 * Last Edit: 5/22/23
 * Authors: _____________________
 */

//import processing.sound.*;

//GAME VARIABLES
private int timesGet = 0;
private int msElapsed = 0;
String titleText = "Murder Mystery";
String extraText = "Mansion Conspiracy -Maria & Sadia";

//Screens
Screen currentScreen;
World currentWorld;
Grid currentGrid;

//Splash Screen Variables
Screen splashScreen;
String splashBgFile = "images/mansion.jpg";
PImage splashBg;

//Main Screen Variables
Grid mainGrid;
String mainBgFile = "images/basement.PNG";
PImage mainBg;

AnimatedSprite p1;
String p1File = "sprites/MC_AKey.png";
String p1json = "sprites/MC_AKey.json";
int player1Row = 3;
int player1Col = 0;
int health = 3;

AnimatedSprite enemySprite;
PImage enemy;
String enemyFile = "";
// AnimatedSprite exampleSprite;
boolean doAnimation;

ArrayList<String> marks = new ArrayList<String>();
ArrayList<String> items = new ArrayList<String>();
PImage key; 
String keyFile = "images/key.png";
PImage drawer;
String drawerFile = "images/drawer.png";
PImage hairclip;
String hairclipFile = "images/hairclip-removebg-preview.png";
PImage tv;
String tvFile = "images/tv-removebg-preview.png";

//EndScreen variables
World endScreen;
PImage endBg;
String endBgFile = "images/youwin.png";

//Example Variables
//HexGrid hGrid = new HexGrid(3);
//SoundFile song;



//Required Processing method that gets run once
void setup() {

  //Match the screen size to the background image size
  size(800, 600);

  //Set the title on the title bar
  surface.setTitle(titleText);

  //Pixel width of one tile: 40
  //Pixel height of one tile: 30
  
  //Load BG images used
  splashBg = loadImage(splashBgFile);
  splashBg.resize(800, 600);
  mainBg = loadImage(mainBgFile);
  mainBg.resize(800, 600);
  endBg = loadImage(endBgFile);
  endBg.resize(800, 600);

  //setup the screens/worlds/grids in the Game
  splashScreen = new Screen("splash", splashBg);
  mainGrid = new Grid("basement", mainBg, 20,20);
  endScreen = new World("end", endBg);
  currentScreen = splashScreen;
  currentGrid = mainGrid;

  //Setup player1 animation
  playerAnimationSetup();

  //setup the item images
  key = loadImage(keyFile);
  key.resize(50,50);
  drawer = loadImage(drawerFile);
  drawer.resize(80,60);
  hairclip = loadImage(hairclipFile);
  hairclip.resize(80,60);
  tv = loadImage(tvFile);
  tv.resize(120,90);

  //set up the items into the first Grid
  itemSetup1();


  // exampleSprite = new AnimatedSprite("sprites/horse_run.png", "sprites/horse_run.json");
  // exampleAnimationSetup();

  // Load a soundfile from the /data folder of the sketch and play it back
  // song = new SoundFile(this, "sounds/Lenny_Kravitz_Fly_Away.mp3");
  // song.play();

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
  currentGrid.pause(100);

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
    
    currentGrid.clearTileSprite(oldLoc);

    //change the field for player1Row
    player1Row--;
    
    


  }
if(player1Row != currentGrid.getNumRows()-2 && keyCode == 83){
    //check case where out of bounds (key s)
    
    //Erase image from previous location
    GridLocation oldLoc = new GridLocation(player1Row, player1Col);
    currentGrid.clearTileSprite(oldLoc);

    //change the field for player1Row
    player1Row++;

  }
 if(player1Col != currentGrid.getNumCols()-2 && keyCode == 68){

    //Erase image from previous location
    GridLocation oldLoc = new GridLocation(player1Row, player1Col);
    currentGrid.clearTileSprite(oldLoc);

    //change the field for player1Col
    player1Col++;
  }
  if(player1Col !=0 && keyCode == 65){

    //Erase image from previous location
    GridLocation oldLoc = new GridLocation(player1Row, player1Col);
    currentGrid.clearTileSprite(oldLoc);

    //change the field for player1Col
    player1Col--;
  }
}

  //Known Processing method that automatically will run when a mouse click triggers it
  void mouseClicked(){
  
    //check if click was successful
    System.out.println("Mouse was clicked at (" + mouseX + "," + mouseY + ")");
    if(currentGrid != null){
      System.out.println("Grid location: " + currentGrid.getGridLocation());
    }

    //what to do if clicked?
    GridLocation clickedLoc= currentGrid.getGridLocation();
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
    if(currentGrid != null){
      currentGrid.setMark("X",currentGrid.getGridLocation());
    }
    
  }





//------------------ CUSTOM  METHODS --------------------//

public void itemSetup1(){

  GridLocation haircliploc = new GridLocation(10, 2);
  mainGrid.setTileImage(haircliploc, hairclip);

  //Display key
  GridLocation drawerloc = new GridLocation(5, 2);
  mainGrid.setTileImage(drawerloc, drawer);

  GridLocation tvloc = new GridLocation (15, 15);
  mainGrid.setTileImage(tvloc, tv);

  //set marks
  System.out.println(currentGrid.setNewMark("key", drawerloc));
  System.out.println(currentGrid.setNewMark("hairclip", haircliploc));
  System.out.println(currentGrid.setNewMark("tv", tvloc));

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
  
  //Update the Background
  background(currentScreen.getBg());

  //splashScreen update
  if(splashScreen.getScreenTime() > 3000 && splashScreen.getScreenTime() < 5000){
    currentScreen = mainGrid;
  }

  //mainGrid Screen Updates
  if(currentScreen == mainGrid){
    currentGrid = mainGrid;

    //Display the Player1 image
    // GridLocation player1Loc = new GridLocation(player1Row,player1Col);
    // currentGrid.setTileImage(player1Loc, player1);

    GridLocation p1Loc= new GridLocation(player1Row,player1Col);
    currentGrid.setTileSprite(p1Loc, p1);

    //Update other screen elements
    currentGrid.showImages();
    currentGrid.showSprites();
    currentGrid.showGridSprites();
  }

  //update other screens?

}

//Method to populate enemies or other sprites on the screen
public void populateSprites(){

  //What is the index for the last column?
  int lastCol = currentGrid.getNumCols()-1;

  //Loop through all the rows in the last column
  for(int r=0; r<currentGrid.getNumRows(); r++){

    //Generate a random number
    double rando = Math.random();

    //10% of the time, decide to add an image to a Tile
    if(rando < 0.1){
      //currentGrid.setTileImage(new GridLocation(r,lastCol), enemy);
      //System.out.println("Populating in row " + r);
      currentGrid.setTileSprite(new GridLocation(r, lastCol), enemySprite);
    }

  }


}

//Method to move around the enemies/sprites on the screen
public void moveSprites(){

  //Loop through all of the cells in the grid
  for (int r = 0; r < currentGrid.getNumRows(); r++) {
    for (int c = 1; c < currentGrid.getNumCols(); c++) {

      //Store the 2 locations to move
      GridLocation loc = new GridLocation(r, c);
      GridLocation newLoc = new GridLocation(r, c - 1);
      
      // Check if the current tile has an image and is NOT the player1
      // if(currentGrid.hasTileImage(loc) && !currentGrid.getTileImage(loc).equals(player1) ){
      if(currentGrid.hasTileSprite(loc) ){
        //System.out.println("Moving sprite found at loc " + loc);

        //Get image from current location
        //PImage img = currentGrid.getTileImage(loc);
        AnimatedSprite sprite = currentGrid.getTileSprite(loc);

        //Set image to new Location 
        //currentGrid.setTileImage(newLoc, img);
        //System.out.println("Moving to newLoc" + newLoc);
        currentGrid.setTileSprite(newLoc, sprite);

        //Erase image from old location
        //currentGrid.clearTileImage(loc);
        currentGrid.clearTileSprite(loc);

        //System.out.println(loc + " " + currentGrid.hasTileImage(loc));
      }

      //What is at the first column?
      if (c == 1) {
        currentGrid.clearTileImage(newLoc);
        currentGrid.clearTileSprite(newLoc);
      }

    }
  }
}

//Method to handle the collisions between Sprites on the Screen

//it checks collisions - requires two parameters
public boolean checkCollision(GridLocation current, GridLocation newLoc){
  

//get image at current location first, if any
PImage image = currentGrid.getTileImage(current);

//if nothing is there, there can't be a collision
if(image == null){
  return false;
}

//get image at new location, if any
PImage newImage = currentGrid.getTileImage(newLoc);
Sprite sprite = currentGrid.getTileSprite(newLoc);

//if nothing is at new location, there can't be a collision 
if(newImage == null){
  return false;
}

//check if player interacts with item or npc
// if(player1.equals(image) && key.equals(newImage)){
if(p1.equals(sprite) && key.equals(newImage)){
    currentGrid.clearTileSprite(current);
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
    // image(endScreen, 100,100);
    currentScreen = endScreen;

}



public void playerAnimationSetup(){  
  
  p1 = new AnimatedSprite(p1File, p1json);
  p1.resize(50,80);
  p1.animate(1.0);
  GridLocation p1Loc= new GridLocation(player1Row,player1Col);
  currentGrid.setTileSprite(p1Loc, p1);

}


// //example method that creates 5 horses along the screen
// public void exampleAnimationSetup(){  
//   int i = 2;
//   exampleSprite = new AnimatedSprite("sprites/horse_run.png", "sprites/horse_run.json");
// }



// //example method that animates the horse Sprites
// public void checkExampleAnimation(){
//   if(doAnimation){
//     exampleSprite.animateVertical(5.0, 1.0, true);
//   }
// }





