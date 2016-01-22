public float DEFAULT_WEIGHT = 0.4f;

public class Environment {
  public Cell[][][] matrix;
  int[][] weightConfig;
  
  private Cell growthCell;
  
  private int cellsGrown;
  
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
    
    growthCell = new Cell(0, 0, 0);
    initialiseWeights();
  }
  
  public Cell[][][] getMatrix() {
    return matrix;
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
  }


  /* 
   * Resets the whole environment, deleting all cells and pathways.
   */
  public void resetEnvironment() {
    cellsGrown = 0;
    
    for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        for (int z = 0; z < envZMaxUnits; z++) {
          matrix[x][y][z].reset();
        }
      }
    }
    
    int xInit = 0;
    int yInit = envYMaxUnits-1;
    int zInit = 0;
    matrix[xInit][yInit][zInit].solid = true;
    matrix[envXMaxUnits/2][envXMaxUnits/2][envZMaxUnits/2].initialiseOrientation();
    cellsGrown++;

    restartWeights();
    recordWeightConfig();
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
          matrix[x][y][z].weight = DEFAULT_WEIGHT; // default weight
          
          if ((x == envXMaxUnits-1) || (y == envYMaxUnits-1)
              || (x == 0) || (y == 0)) {
            matrix[x][y][z].weight = 0;
          }
        }
      }
    }
  }
  
  
  /* 
   * Runs a single step of the structure modelling,
   * attempting to grow it by a single cell.
   */
  public void runSimulationStep() {
    for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        for (int z = 0; z < envZMaxUnits; z++) {
          if (matrix[x][y][z].solid) {
            growCell(x, y, z);
          }
        }
      }
    } 
  }
  
  
  /* 
   * "Grows" a cell into one of its availale neighbouring spaces,
   * according to its orientation and the weighting factors calculated
   * for its neihbours.
   */
  public void growCell(int x, int y, int z) {
    if (cellsGrown < maxCells) {
      Cell cell = matrix[x][y][z];
      int directionIndex = int(random(0, 4));
      
      int growthCellX = x;
      int growthCellY = y;
      int growthCellZ = z;
      
      boolean xok = true;
      boolean yok = true;
      boolean zok = true;
      
      switch (directionIndex) {
        case 0: {
          if (abs(cell.orientation.x) == 1) {
            growthCellZ += 1;
            zok = false;
          } else if (abs(cell.orientation.y) == 1) {
            growthCellZ += 1;
            zok = false;
          } else if (cell.orientation.z == 1) {
            growthCellX -= 1;
            xok = false;
          } else if (cell.orientation.z == -1) {
            growthCellX += 1;
            xok = false;
          }
          break;
        }
        case 1: {
          if (cell.orientation.x == 1) {
            growthCellY -= 1;
            yok = false;
          } else if (cell.orientation.x == -1) {
            growthCellY += 1;
            yok = false;
          } else if (cell.orientation.y == 1) {
            growthCellX += 1;
            xok = false;
          } else if (cell.orientation.y == -1) {
            growthCellX -= 1;
            xok = false;
          } else if (abs(cell.orientation.z) == 1) {
            growthCellY -= 1;
            yok = false;
          }
          break;
        }
        case 2: {
          if (abs(cell.orientation.x) == 1) {
            growthCellZ -= 1;
            zok = false;
          } else if (abs(cell.orientation.y) == 1) {
            growthCellZ -= 1;
            zok = false;
          } else if (cell.orientation.z == 1) {
            growthCellX += 1;
            xok = false;
          } else if (cell.orientation.z == -1) {
            growthCellX -= 1;
            xok = false;
          }
          break;
        }
        case 3: {
          if (cell.orientation.x == 1) {
            growthCellY += 1;
            yok = false;
          } else if (cell.orientation.x == -1) {
            growthCellY -= 1;
            yok = false;
          } else if (cell.orientation.y == 1) {
            growthCellX -= 1;
            xok = false;
          } else if (cell.orientation.y == -1) {
            growthCellX += 1;
            xok = false;
          } else if (abs(cell.orientation.z) == 1) {
            growthCellY += 1;
            yok = false;
          }
          break;
        }
      }
      
      if (validCoordinates(growthCellX, growthCellY, growthCellZ)) {
        growthCell = matrix[growthCellX][growthCellY][growthCellZ];
        if (!growthCell.solid && enoughPorous(growthCell)) {
          growthCell.solid = true; 
          growthCell.orientation = growthCell.pickNeighbourOrientation(xok, yok, zok);
          growthCell.adjustOrientation();
          
          if ((growthCellZ > 0) && (matrix[growthCellX][growthCellY][growthCellZ-1].solid))  {
            growthCell.weight = matrix[growthCellX][growthCellY][growthCellZ-1].weight+cellLoadOffset;
          } else {
            growthCell.weight = cellLoadOffset;
          }
          
          // Isolate neighbours
          isolateNeighbours(growthCellX, growthCellY, growthCellZ);
          
          cellsGrown++;
        }
      }
    }
  }


  /* 
   * Sets to maximum the weight factor on neighbouring positions not
   * connected to any of the four arms of the cross-shaped cell,
   * therefore making them unavailable.
   */
  void isolateNeighbours(int growthCellX, int growthCellY, int growthCellZ) {
    if (abs(growthCell.orientation.x) == 1) {
      if ((growthCellX-1) >= 0) {
        matrix[growthCellX-1][growthCellY][growthCellZ].weight = 1.0;
      }
      if ((growthCellX+1) < envXMaxUnits) {
        matrix[growthCellX+1][growthCellY][growthCellZ].weight = 1.0;
      }
      
      if ((growthCellX-2) >= 0) {
        matrix[growthCellX-2][growthCellY][growthCellZ].weight = 1.0;
      }
      if ((growthCellX+2) < envXMaxUnits) {
        matrix[growthCellX+2][growthCellY][growthCellZ].weight = 1.0;
      }
    }
    if (abs(growthCell.orientation.y) == 1) {
      if ((growthCellY-1) >= 0) {
        matrix[growthCellX][growthCellY-1][growthCellZ].weight = 1.0;
      }
      if ((growthCellY+1) < envYMaxUnits) {
        matrix[growthCellX][growthCellY+1][growthCellZ].weight = 1.0;
      }
      
      if ((growthCellY-2) >= 0) {
        matrix[growthCellX][growthCellY-2][growthCellZ].weight = 1.0;
      }
      if ((growthCellY+2) < envYMaxUnits) {
        matrix[growthCellX][growthCellY+2][growthCellZ].weight = 1.0;
      }
    }
    if (abs(growthCell.orientation.z) == 1) {
      if ((growthCellZ-1) >= 0) {
        matrix[growthCellX][growthCellY][growthCellZ-1].weight = 1.0;
      }
      if ((growthCellZ+1) < envZMaxUnits) {
        matrix[growthCellX][growthCellY][growthCellZ+1].weight = 1.0;
      }
      
      if ((growthCellZ-2) >= 0) {
        matrix[growthCellX][growthCellY][growthCellZ-2].weight = 1.0;
      }
      if ((growthCellZ+2) < envZMaxUnits) {
        matrix[growthCellX][growthCellY][growthCellZ+2].weight = 1.0;
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
    return (cell.weight < 1) && (random(0.9-cell.weight, 1) >= 0.9);
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