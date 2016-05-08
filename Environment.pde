public float DEFAULT_WEIGHT = 0.2f;//0.4f;

public class Environment {
  public Cell[][][] matrix;
  int[][] weightConfig;
   
  private int cellsGrown;
  private int baseCells;
  private int typeACells;
  private int typeBCells;
  private boolean simulationFailed;
  
  private CellChain[] cellChains;
  
  private TextRoller textRoller;
  private Animation animation;
  private EntriesImporter entriesImporter;
  private ParticipativeTextRoller particpativeTextRoller;
  private MultipleTextRoller multipleTextRoller;
  
  private ArrayList<Entry> entriesList = new ArrayList<Entry>();

  
  public Environment() {
    matrix = new Cell[envXMaxUnits][envYMaxUnits][envZMaxUnits];
    weightConfig = new int[envXMaxUnits][envYMaxUnits];
    
    for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        for (int z = 0; z < envZMaxUnits; z++) {
          matrix[x][y][z] = new Cell(x, y, z);
        }
      }
    }
    
    cellChains = new CellChain[NUMBER_OF_CELL_CHAINS];
    for (int i = 0; i < NUMBER_OF_CELL_CHAINS; i++) {
      CellChain cellChain = new CellChain(i);
      cellChains[i] = cellChain;
    }
    
    // Create text roller
    textRoller = new TextRoller();
    textRoller.setText(DISPLAY_TEXT);
    
    // Create Animation
    animation = new Animation();
    
    // Create EntryContent
    entriesImporter = new EntriesImporter();
    entriesList = entriesImporter.loadEntriesFile();
    particpativeTextRoller = new ParticipativeTextRoller(entriesList);
    particpativeTextRoller.nextEntry();
    
    //Multiple TextRoller
    multipleTextRoller = new MultipleTextRoller();
    
  }
   
  public Cell[][][] getMatrix() {
    return matrix;
  }
  
  public CellChain[] getCellChain() {
    return cellChains;  
  }
  
  public TextRoller getTextRoller() {
    return textRoller;
  }
  
  public Animation getAnimation() {
    return animation;
  }
  
  public ParticipativeTextRoller getParticipativeTextRoller() {
    return particpativeTextRoller;
  }
  
  public MultipleTextRoller getMultipleTextRoller() {
    return multipleTextRoller;
  }
  
  public void initEntryContent(EntriesImporter entriesImporter){
  }
  
  public void resetWeightConfig() {
    for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        weightConfig[x][y] = 0;
      }
    }
  }

  public void recordWeightConfig() {
    for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        for (int z = 0; z < envZMaxUnits-1; z++) {
          if ((weightConfig[x][y] == 1) && (z <= envZMaxUnitsPath)) {
            matrix[x][y][z].weight = 1.0f;
          }
        }
      }
    }
    
    configRecorded = true;
  }
  
  public void setCell(int cellChainIndex, int x, int y, int z, String type, String orientation, int rotation){
    Cell cell = new Cell(x, y, z, type, orientation, rotation);
    matrix[x][y][z] = cell;
    cellChains[cellChainIndex].addCell(cell);
  }
  
  public void setFrontCells(){
    for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        for (int z = 0; z < envZMaxUnits-1; z++) {
          if (matrix[x][y][z].solid) {
            Cell cell = matrix[x][y][z];
            if(cell.orientation.x == 1){
              boolean front = false;
              for(int ix = x+1; ix < envXMaxUnits; ix++){
                //for(int iz = 0; iz < envZMaxUnits; iz++){
                  //if(matrix[ix][y][z].orientation.x == 1){
                    if(matrix[ix][y][z].solid){
                      front = true;    
                    }
                  //}
                //}
              }
              if(!front){
                matrix[x][y][z].front = true;   
                println("SetFrontCell");
              }  
            }else if(cell.orientation.x == -1){
              boolean front = false;
              for(int ix = x-1; ix >= 0; ix--){
                //for(int iz = 0; iz < envZMaxUnits; iz++){
                  //if(matrix[ix][y][z].orientation.x == 1){
                    if(matrix[ix][y][z].solid){
                      front = true;    
                    }
                  //}
                //}
              }
              if(!front){
                matrix[x][y][z].front = true;   
                println("SetFrontCell");
              }
            }else if(cell.orientation.y == 1){
              boolean front = false;
              for(int iy = y+1; iy < envYMaxUnits; iy++){
                //for(int iz = 0; iz < envZMaxUnits; iz++){
                  //if(matrix[ix][y][z].orientation.x == 1){
                    if(matrix[x][iy][z].solid){
                      front = true;    
                    }
                  //}
                //}
              }
              if(!front){
                matrix[x][y][z].front = true;   
                println("SetFrontCell");
              }
            }else if(cell.orientation.y == -1){
              boolean front = false;
              for(int iy = y-1; iy >= 0; iy--){
                //for(int iz = 0; iz < envZMaxUnits; iz++){
                  //if(matrix[ix][y][z].orientation.x == 1){
                    if(matrix[x][iy][z].solid){
                      front = true;    
                    }
                  //}
                //}
              }
              if(!front){
                matrix[x][y][z].front = true;   
                println("SetFrontCell");
              }  
            }
          }
        }
      }
    } 
    
   for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        for (int z = 0; z < envZMaxUnits-1; z++) {  
          if (matrix[x][y][z].front) {
            println("Front-Cell: "+x+" "+y+" "+z+" ");  
          }
        }
      }
   }   
        
        
  }
  
  /* 
   * Renders the whole 3D structure to the screen.
  */
  public void drawEnvironment() {
    if (configMode) {
      drawWeightConfig();
    } else {
      if (fileExporter.stillWritingFile()) {
        background(250, 141, 38);      // WRITING FILE
      } else if (runningSimulation) {
        background(35, 71, 88);        // RUNNING SIMULATION
      } else {
        background(0, 0, 0);           // DEFAULT BACKGROUND
      }
      
      for (int x = 0; x < envXMaxUnits; x++) {
        for (int y = 0; y < envYMaxUnits; y++) {
          for (int z = 0; z < envZMaxUnits; z++) {
            matrix[x][y][z].drawCell();
          }
        }
      } 
    }
    if(particpativeTextRoller.getLoopCounter()>=TEXT_ROLLER_LOOPS){
      particpativeTextRoller.nextEntry();
    }
  }

  public void sendDMX(){
    for (int i = 0; i < NUMBER_OF_CELL_CHAINS; i++) {
      cellChains[i].sendDMX();
    }  
  }

  /* 
   * Resets the whole environment, deleting all cells and pathways.
   */
  public void resetEnvironment() {
    cellsGrown = 0;
    baseCells = 0;
    simulationFailed = false;
    
    /*matrix = new Cell[envXMaxUnits][envYMaxUnits][envZMaxUnits];
    weightConfig = new int[envXMaxUnits][envYMaxUnits];
    
    for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        for (int z = 0; z < envZMaxUnits; z++) {
          matrix[x][y][z] = new Cell(x, y, z);
        }
      }
    }
    
    cellChains = new CellChain[NUMBER_OF_CELL_CHAINS];
    for (int i = 0; i < NUMBER_OF_CELL_CHAINS; i++) {
      CellChain cellChain = new CellChain(i);
      cellChains[i] = cellChain;
    }
    
    restartWeights();
    recordWeightConfig();*/
    
    for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        for (int z = 0; z < envZMaxUnits; z++) {
          matrix[x][y][z].reset();
          //matrix[x][y][z].resetWeight();
        }
      }
    }
    
    restartWeights();
    recordWeightConfig();
    
    for (CellChain cellChain : cellChains) {
      cellChain.resetChain();
    }
  }
  
  /* 
   * Clear the whole environment, deleting all cells in the matrix.
   */
  public void clearEnvironment() {
    cellsGrown = 0;
    baseCells = 0;
    simulationFailed = false;
    multipleTextRoller = new MultipleTextRoller();

    /*for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        for (int z = 0; z < envZMaxUnits; z++) {
          matrix[x][y][z].reset();
        }
      }
    }  
    
    restartWeights();
    recordWeightConfig();
    
    for (CellChain cellChain : cellChains) {
      cellChain.emptyChain();
    }*/
    
    matrix = new Cell[envXMaxUnits][envYMaxUnits][envZMaxUnits];
    weightConfig = new int[envXMaxUnits][envYMaxUnits];
    
    for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        for (int z = 0; z < envZMaxUnits; z++) {
          matrix[x][y][z] = new Cell(x, y, z);
        }
      }
    }
    
    cellChains = new CellChain[NUMBER_OF_CELL_CHAINS];
    for (int i = 0; i < NUMBER_OF_CELL_CHAINS; i++) {
      CellChain cellChain = new CellChain(i);
      cellChains[i] = cellChain;
    }
    
  }
  
  private Cell createRootCell(int index) {
    int xInit = 0;
    int yInit = 0;
    int zInit = 0;
    
    //do {
    //xInit = (int)random(0, envXMaxUnits);
    //yInit = (int)random(0, envYMaxUnits);
    //} while ((matrix[xInit][yInit][zInit].weight >= 1) || matrix[xInit][yInit][zInit].solid);
    
    switch (index%4) {
      case 0: {
        xInit = 0;
        yInit = (int)random(0, envYMaxUnits);
      
        while ((matrix[xInit][yInit][zInit].weight >= 1) || matrix[xInit][yInit][zInit].solid) {
          yInit = (int)random(0, envYMaxUnits);
        }
        break;
      }
      case 1: {
        xInit = envXMaxUnits-1;
        yInit = (int)random(0, envYMaxUnits);
      
        while ((matrix[xInit][yInit][zInit].weight >= 1) || matrix[xInit][yInit][zInit].solid) {
          yInit = (int)random(0, envYMaxUnits);
        }
        break;
      }
      case 2: {
        xInit = (int)random(0, envXMaxUnits);
        yInit = 0;
      
        while ((matrix[xInit][yInit][zInit].weight >= 1) || matrix[xInit][yInit][zInit].solid) {
          xInit = (int)random(0, envXMaxUnits);
        }
        break;
      }
      case 3: {
        xInit = (int)random(0, envXMaxUnits);
        yInit = envYMaxUnits-1;
      
        while ((matrix[xInit][yInit][zInit].weight >= 1) || matrix[xInit][yInit][zInit].solid) {
          xInit = (int)random(0, envXMaxUnits);
        }
        break;
      }
    }
    
    Cell initialCell = matrix[xInit][yInit][zInit];
    initialCell.solid = true;
    initialCell.initialiseOrientation();
    initialCell.baseCell = true;
    initialCell.indexOnPath = 1;
    initialCell.pathId = 
    initialCell.pathId = 0;
    
    initialCell.entryPixel = PIXEL.BOTTOM;
    initialCell.exitPixel = ((int)random(0, 2) == 0)? PIXEL.LEFT : PIXEL.RIGHT;
    if (initialCell.orientation.x == -1) {
      if (yInit == 0) {
        initialCell.exitPixel = PIXEL.RIGHT;
      } else if (yInit == envYMaxUnits-1) {
        initialCell.exitPixel = PIXEL.LEFT;
      }
    } else if (initialCell.orientation.x == 1) {
      if (yInit == 0) {
        initialCell.exitPixel = PIXEL.LEFT;
      } else if (yInit == envYMaxUnits-1) {
        initialCell.exitPixel = PIXEL.RIGHT;
      }
    } else if (initialCell.orientation.y == 1) {
      if (xInit  == 0) {
        initialCell.exitPixel = PIXEL.RIGHT;
      } else if (xInit == envXMaxUnits-1) {
        initialCell.exitPixel = PIXEL.LEFT;
      }
    } else if (initialCell.orientation.y == -1) {
      if (xInit == 0) {
        initialCell.exitPixel = PIXEL.LEFT;
      } else if (xInit == envXMaxUnits-1) {
        initialCell.exitPixel = PIXEL.RIGHT;
      }
    }
    
//    cellsGrown++;
    return initialCell;
  }

  
  /* 
   * Initialises the space with weighting factors that create
   * a T-shaped pathways across the area.
   */
  public void initialiseWeights() {
    for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        for (int z = 0; z < envZMaxUnits; z++) {
          matrix[x][y][z].weight = DEFAULT_WEIGHT; // default weight
          
          if ((x == envXMaxUnits-1) || (y == envYMaxUnits-1)
              || (x == 0) || (y == 0)) {
            matrix[x][y][z].weight = 0;
          }
          
          if (((x > envXMaxUnits/3) && (x < envXMaxUnits/3+3) && (y > envYMaxUnits/3))
              || (y > envYMaxUnits/3) && (y < envYMaxUnits/3+3)) { 
            weightConfig[x][y] = 1;
          }
          recordWeightConfig();
          
        }
      }
    }
  }
  
  
  /* 
   * Resets the weighting factors for all cells in the 3D space,
   * effectively clearing the whole space.
   */
  public void restartWeights() {
    for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        for (int z = 0; z < envZMaxUnits; z++) {
          //matrix[x][y][z].weight = DEFAULT_WEIGHT; // default weight
          
          //if ((x == envXMaxUnits-1) || (y == envYMaxUnits-1)
          //   || (x == 0) || (y == 0)) {
            matrix[x][y][z].weight = 0;
//          }
        }
      }
    }
  }
  
  public boolean hasSimulationEnded() {
    return (environment.cellsGrown >= maxCells);
  }
  
  /* 
   * Runs a single step of the structure modelling,
   * attempting to grow it by a single cell.
   */
  public void runSimulationStep() {
    growCell();

    if (simulationFailed) {
      environment.resetEnvironment();
    }

    cellsGrown = 0;
    baseCells = 0;
    typeACells = 0;
    typeBCells = 0;
    for (int i = 0; i < NUMBER_OF_CELL_CHAINS; i++) {
      CellChain cellChain = cellChains[i];
      cellsGrown += cellChain.getSize();
      
      for (Cell cell : cellChain.getCells()) {
          if (cell.z == 0) {
            baseCells++;
          }
          if (cell.getType() == TYPE.A) {
            typeACells++;
          }
          if (cell.getType() == TYPE.B) {
            typeBCells++;
          }
      }
    }

    System.out.println("Total cells: " + cellsGrown + " (A: " + typeACells + ", B: " + typeBCells + "); base cells: " + baseCells);
  }
  

  public boolean growCell() {
    boolean hasGrown = false;
    for (int i = 0; i < NUMBER_OF_CELL_CHAINS; i++) {
      CellChain cellChain = cellChains[i];
      if (!cellChain.isCompleted()) {
        hasGrown = hasGrown || cellChain.grow();
        break;
      } else if (!cellChain.hasBaseCellsAtHalfPoint()) {
        // LUKE - COMMENTED OUT 11-APR - NOT WORKING PROPERLY YET
//        simulationFailed = true;
      }
    }
    return hasGrown;
  }
  
  /* 
   * Sets to maximum the weight factor on neighbouring positions not
   * connected to any of the four arms of the cross-shaped cell,
   * therefore making them unavailable.
   */
  void isolateNeighbours(int growthCellX, int growthCellY, int growthCellZ) {
    Cell growthCell = matrix[growthCellX][growthCellY][growthCellZ];
    if (abs(growthCell.orientation.x) == 1) {
      if ((growthCellX-1) >= 0) {
        matrix[growthCellX-1][growthCellY][growthCellZ].weight = 1.0;
      }
      if ((growthCellX+1) < envXMaxUnits) {
        matrix[growthCellX+1][growthCellY][growthCellZ].weight = 1.0;
      }
    }
    if (abs(growthCell.orientation.y) == 1) {
      if ((growthCellY-1) >= 0) {
        matrix[growthCellX][growthCellY-1][growthCellZ].weight = 1.0;
      }
      if ((growthCellY+1) < envYMaxUnits) {
        matrix[growthCellX][growthCellY+1][growthCellZ].weight = 1.0;
      }
    }
    if (abs(growthCell.orientation.z) == 1) {
      if ((growthCellZ-1) >= 0) {
        matrix[growthCellX][growthCellY][growthCellZ-1].weight = 1.0;
      }
      if ((growthCellZ+1) < envZMaxUnits) {
        matrix[growthCellX][growthCellY][growthCellZ+1].weight = 1.0;
      }
    }
  }
  
  
  /* 
   * Checks whether coordinates for the new cell are within boundaries.
   */
  boolean validCoordinates(int x, int y, int z) {
    return (x >= 0) && (y >= 0) && (z >= 0)
            && (x < envXMaxUnits) && (y < envYMaxUnits) && (z < envZMaxUnits);  
  }

  /* 
   * Checks whether the matrix cell position is still able to accommodate a physical light cell.
   * connected to any of the four arms of the cross-shaped cell,
   * therefore making them unavailable.
   */
  boolean enoughPorous(Cell cell) {
    return (cell.weight < 1);// && (random(0.9-cell.weight, 1) >= 0.9);
  }

  
  /* 
   * Persists the pathways recently configured by the user into their data structure. 
   */
  void writePathWeights() {
    if (((mouseX/unitSize) < envXMaxUnits) && ((mouseY/unitSize) < envYMaxUnits)) {
      if (mousePressed) {
        if (!keyPressed) {
          weightConfig[mouseX/unitSize][mouseY/unitSize] = 1;
        } else {
          weightConfig[mouseX/unitSize][mouseY/unitSize] = 0;
        }
      }
    }
  }
  
  /* 
   * Draws to the screen the pathways configured by the user.
   */
  void drawWeightConfig() {
    if (configRecorded) {
      background(0, 0, 0); 
    } else {
      background(35, 71, 88);
    }
    noStroke();
    fill(255, 0, 0);
    
    for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        if (weightConfig[x][y] == 1) {
          rect(x*unitSize, y*unitSize, unitSize, unitSize);
        }
      }
    }
  }
  
  
}