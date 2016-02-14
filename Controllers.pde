/***************************************************
 KEYBOARD COMMANDS

 == ACTION COMMANDS
 Key            Command 
 s              Starts a new simulation (i.e. creates a new structure model).
 1              Enters pathway CONFIG mode.
 2              Exits pathway CONFIG mode.
 q              When in pathways COFIG mode, clears previously recorded pathways.
 r              When in pathways COFIG mode, recods (saves) the newly edited pathways.
 
 == DISPLAY COMMANDS
 Key            Command
 d              Turns display of weighting factors ON (the less transparent blue, the smaller the weight).
 f              Turns config mode OFF.
 g              Turns display of faces ON.
 h              Turns display of faces OFF.
 j              Displays each orientation with a different colour.
 k              Displays all orientations with the same colours (light green).
 l              Display light effects ON (click it again to turn it OFF).
 ;              Display rolling text ON (click it again to turn it OFF).
 4              Display only cells facing UP.
 5              Display only cells facing DOWN.
 6              Display only cells facing WEST.
 7              Display only cells facing SOUTH.
 8              Display only cells facing EAST.
 9              Display only cells facing NORTH.
 0              Display ALL cells.
 =              Render landscape.
 
  == NAVIGATION COMMANDS
 Key            Command 
 >              Rotate UP.
 <              Rotate DOWN.
 LEFT ARROW     Rotate LEFT.
 RIGHTT ARROW   Rotate RIGHT.
 
  == OUTPUT COMMANDS
 Key            Command
 x              Export structure file.

***************************************************/

boolean runningSimulation;

boolean configMode = false;
boolean configRecorded = true;
boolean displayFaces = true;
boolean facesDifferentColours = true;
boolean pixelColours = false;
boolean rollingText = false;
boolean renderLandscape = false;
boolean defaultShapes = false;

public enum FACET {ALL, NORTH, SOUTH, EAST, WEST, BOTTOM_UP, CEILING_DOWN};
FACET facetDisplayed = FACET.ALL;

boolean displayWeights = false;
boolean restartWeights = false;
boolean writePathWeights = false;

long COMMAND_TIME_THRESHOLD = 50;
long timeLastCommand;

void evaluateControllers() {
  processCommands();

  //////////////////////////
  // EVALUATE CONTROLLERS
  //////////////////////////
  if (keyPressed) {
    if ((millis()-timeLastCommand) < COMMAND_TIME_THRESHOLD) {
      return;
    }
    timeLastCommand = millis();
  }
  
  if (command('s')) {
    println("\n### RESTARTING SIMULATION");
    environment.resetEnvironment();
    runningSimulation = true;
  }

  //////////////////////
  // ACTION COMMANDS
  //////////////////////
  
  // Config mode
  if (command('1')) {
    configMode = true;
  }
  if (command('2')) {
    configMode = false;
  }
  if (configMode && command('q')) {
    restartWeights = true;
    configRecorded = false;
    writePathWeights = true;
  }
  if (configMode && command('r')) {
    environment.recordWeightConfig();
    configRecorded = true;
  }
  
  // Display modes
  if (command('d')) {
    displayWeights = true;
  }
  if (command('f')) {
    displayWeights = false;
  }  
  if (command('g')) {
    displayFaces = true;
  }
  if (command('h')) {
    displayFaces = false;
  }
  if (command('j')) {
    facesDifferentColours = true;
  }
  if (command('k')) {
    facesDifferentColours = false;
  }
  if (command('l')) {
    pixelColours = !pixelColours;
  }
  if (command(';')) {
    rollingText = !rollingText;
  }
  if (command('=')) {
    renderLandscape = !renderLandscape;
  }
  if (command('-')) {
    defaultShapes = !defaultShapes;
  }
  
  // Facet views
  if (command('0')) {
    facetDisplayed = FACET.ALL;
  }
  if (command('4')) {
    facetDisplayed = FACET.BOTTOM_UP;
  }
  if (command('5')) {
    facetDisplayed = FACET.CEILING_DOWN;
  }
  if (command('6')) {
    facetDisplayed = FACET.WEST;
  }
  if (command('7')) {
    facetDisplayed = FACET.SOUTH;
  }
  if (command('8')) {
    facetDisplayed = FACET.EAST;
  }
  if (command('9')) {
    facetDisplayed = FACET.NORTH;
  }
  
  // Navigation
  if (command('>')) {
//    panUpFactor -= 0.005f;
    panUpFactor -= 0.02f;
  }
  if (command('<')) {
//    panUpFactor += 0.005f;
    panUpFactor += 0.02f;
  }
  
  // Navigation arrows
  if (commandCoded(UP)) {
    zoomFactor -= 0.01f;
  }
  if (commandCoded(DOWN)) {
    zoomFactor += 0.01f;
  }
  if (commandCoded(LEFT)) {
    rotationFactor -= 0.01f;
  }
  if (commandCoded(RIGHT)) {
    rotationFactor += 0.01f;
  }

  // File export
  if (command('x') && !fileExporter.stillWritingFile()) {
    fileExporter.exportExnvironmentAsFile(environment);
  }
}

void processCommands() {
  //////////////////////
  // PROCESS COMMANDS
  //////////////////////
  // Runs config step
  if (configMode) {
    if (restartWeights) {
      environment.restartWeights();
      environment.resetWeightConfig();
      restartWeights = false; 
    }
    
    if (writePathWeights) {
      environment.writePathWeights();
    }
  } 
  
  // Runs simulation step
  if (runningSimulation) {
    if (!environment.hasSimulationEnded()) {
      environment.runSimulationStep();
//      println("\ncellsGrown: " + environment.cellsGrown);
    } else {
      runningSimulation = false;
      println("\n### SIMULATION FINISHED");
    }
  }
}

//////////////////////
// HELPER FUNCTIONS
//////////////////////
boolean command(char c) {
  return (keyPressed && (key == c));
}

boolean commandCoded(int c) {
  return keyPressed && (keyCode == c);
}