public float DEFAULT_WEIGHT = 0.4f;

public class Environment {
  public Cell[][][] matrix;
  int[][] weightConfig;
  
  private Cell growthCell;
  private Cell currentCell;
  
  private int cellsGrown;
  private boolean simulationFailed;
  
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
//    initialiseWeights();
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
    simulationFailed = false;
    
    for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        for (int z = 0; z < envZMaxUnits; z++) {
          matrix[x][y][z].reset();
        }
      }
    }
    
    int xInit = 0;
    //int yInit = envYMaxUnits-1;
    int yInit = (int)random(0, envYMaxUnits);
    int zInit = 0;
    
    while (matrix[xInit][yInit][zInit].weight >= 1) {
      yInit = (int)random(0, envYMaxUnits);
    }
    
    Cell initialCell = matrix[xInit][yInit][zInit];
    initialCell.solid = true;
    initialCell.initialiseOrientation();
    
    initialCell.entryPixel = PIXEL.BOTTOM;
    if (initialCell.orientation.x == -1) {
      if (yInit < envYMaxUnits/2) {
        initialCell.exitPixel = PIXEL.RIGHT;
      } else {
        initialCell.exitPixel = PIXEL.LEFT;
      }
    } else if (initialCell.orientation.y == 1) {
      initialCell.exitPixel = PIXEL.RIGHT;
    } else {
      initialCell.exitPixel = PIXEL.LEFT;
    }
    
    currentCell = initialCell;
    
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
    growCell(currentCell.x, currentCell.y, currentCell.z);
/*    
    for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        for (int z = 0; z < envZMaxUnits; z++) {
          if (matrix[x][y][z].solid) {
            growCell(x, y, z);
          }
        }
      }
    } 
*/
  }
  
  
  /* 
   * "Grows" a cell into one of its availale neighbouring spaces,
   * according to its orientation and the weighting factors calculated
   * for its neihbours.
   */
  public void growCell(int x, int y, int z) {
    if (cellsGrown < maxCells) {
      Cell cell = matrix[x][y][z];

      ////////////////////
      //int directionIndex = int(random(0, 4));
      int directionIndex = 0;
      
      if (cell.exitPixel == PIXEL.TOP) {
        directionIndex = 0;
      } else if (cell.exitPixel == PIXEL.RIGHT) {
        directionIndex = 1;
      } else if (cell.exitPixel == PIXEL.BOTTOM) {
        directionIndex = 2;
      } else {
        directionIndex = 3;
      }
      
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
      
      ////////////////////

/*      
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
*/

      if (validCoordinates(growthCellX, growthCellY, growthCellZ)) {
        growthCell = matrix[growthCellX][growthCellY][growthCellZ];
//        if (!growthCell.solid && enoughPorous(growthCell)) { // COMMENTED 26-JAN-2016 - TEST
        //if (growthCell.solid || !enoughPorous(growthCell)) {
        //  int newGrowthCellX = growthCellX;
        //  int newGrowthCellY = growthCellY;
        //  int newGrowthCellZ = growthCellZ;
          
        //  if (cell.exitPixel == PIXEL.TOP) {
        //    cell.exitPixel = PIXEL.BOTTOM;
        //    if ((abs(cell.orientation.x) == 1) || (abs(cell.orientation.y) == 1)) {
        //      newGrowthCellZ -= 2;
        //    } else if (cell.orientation.z == 1) {
        //      newGrowthCellX += 2;
        //    } else {
        //      newGrowthCellX -= 2;
        //    }
        //  } else if (cell.exitPixel == PIXEL.BOTTOM) {
        //    cell.exitPixel = PIXEL.TOP;
        //    if ((abs(cell.orientation.x) == 1) || (abs(cell.orientation.y) == 1)) {
        //      newGrowthCellZ += 2;
        //    } else if (cell.orientation.z == 1) {
        //      newGrowthCellX -= 2;
        //    } else {
        //      newGrowthCellX += 2;
        //    }
        //  } else if (cell.exitPixel == PIXEL.LEFT) {
        //    cell.exitPixel = PIXEL.RIGHT;
        //    if (cell.orientation.x == 1) {
        //      newGrowthCellY -= 2;
        //    } else if (cell.orientation.x == -1) {
        //      newGrowthCellY += 2;
        //    } else if (cell.orientation.y == 1) {
        //      newGrowthCellX += 2;
        //    } else if (cell.orientation.y == -1) {
        //      newGrowthCellX -= 2;
        //    } else if (abs(cell.orientation.z) == 1) {
        //      newGrowthCellY -= 2;
        //    } 
        //  } else if (cell.exitPixel == PIXEL.RIGHT) {
        //    cell.exitPixel = PIXEL.LEFT;
        //    if (cell.orientation.x == 1) {
        //      newGrowthCellY += 2;
        //    } else if (cell.orientation.x == -1) {
        //      newGrowthCellY -= 2;
        //    } else if (cell.orientation.y == 1) {
        //      newGrowthCellX -= 2;
        //    } else if (cell.orientation.y == -1) {
        //      newGrowthCellX += 2;
        //    } else if (abs(cell.orientation.z) == 1) {
        //      newGrowthCellY += 2;
        //    }
        //  }
          
        //  if (validCoordinates(newGrowthCellX, newGrowthCellY, newGrowthCellZ)) {
        //    growthCellX = newGrowthCellX;
        //    growthCellY = newGrowthCellY;
        //    growthCellZ = newGrowthCellZ;
        //    growthCell = matrix[growthCellX][growthCellY][growthCellZ];
        //  }
        //}
        
        if (!growthCell.solid && enoughPorous(growthCell)) {
          growthCell.solid = true; 
          
          int MAX_SIMULATION_ATTEMPTS = 6;
          int attempts = 0;
          boolean adequateOrientationFound = false; 
          while (!adequateOrientationFound && (attempts < MAX_SIMULATION_ATTEMPTS)) {
            growthCell.orientation = growthCell.pickNeighbourOrientation(xok, yok, zok);
            growthCell.adjustOrientation();
            
            if ((growthCellZ > 0) && (matrix[growthCellX][growthCellY][growthCellZ-1].solid))  {
              growthCell.weight = matrix[growthCellX][growthCellY][growthCellZ-1].weight+cellLoadOffset;
            } else {
              growthCell.weight = cellLoadOffset;
            }
            
            // Calculate entry pixels for growthCell 
            switch (directionIndex) {
              case 0: {
                if ((abs(cell.orientation.x) == 1) || (abs(cell.orientation.y) == 1)) {
                  growthCell.entryPixel = PIXEL.BOTTOM;
                } else if (cell.orientation.z == 1) {
                  if (growthCell.orientation.y == 1) {
                    growthCell.entryPixel = PIXEL.RIGHT;
                  } else if (growthCell.orientation.y == -1) {
                    growthCell.entryPixel = PIXEL.LEFT;
                  } else if (growthCell.orientation.z == 1) {
                    growthCell.entryPixel = PIXEL.BOTTOM;
                  } else {
                    growthCell.entryPixel = PIXEL.TOP;
                  }
                } else if (cell.orientation.z == -1) {
                  if (growthCell.orientation.y == 1) {
                    growthCell.entryPixel = PIXEL.LEFT;
                  } else if (growthCell.orientation.y == -1) {
                    growthCell.entryPixel = PIXEL.RIGHT;
                  } else if (growthCell.orientation.z == 1) {
                    growthCell.entryPixel = PIXEL.TOP;
                  } else {
                    growthCell.entryPixel = PIXEL.BOTTOM;
                  }
                }
                break;
              }
              case 1: {
                if (cell.orientation.x == 1) {
                  if ((growthCell.orientation.x == 1) || (abs(growthCell.orientation.z) == 1)) {
                    growthCell.entryPixel = PIXEL.LEFT;
                  } else {
                    growthCell.entryPixel = PIXEL.RIGHT;
                  }
                } else if (cell.orientation.x == -1) {
                  if ((growthCell.orientation.x == 1) || (abs(growthCell.orientation.z) == 1)) {
                    growthCell.entryPixel = PIXEL.RIGHT;
                  } else {
                    growthCell.entryPixel = PIXEL.LEFT;
                  }
                } else if (cell.orientation.y == 1) {
                  if (growthCell.orientation.z == 1) {
                    growthCell.entryPixel = PIXEL.TOP;
                  } else if (growthCell.orientation.z == -1) {
                    growthCell.entryPixel = PIXEL.BOTTOM;
                  } else if (cell.orientation.y == 1) {
                    growthCell.entryPixel = PIXEL.LEFT;
                  } else {
                    growthCell.entryPixel = PIXEL.RIGHT;
                  }
                } else if (cell.orientation.y == -1) {
                  if (growthCell.orientation.z == 1) {
                    growthCell.entryPixel = PIXEL.BOTTOM;
                  } else if (growthCell.orientation.z == 1) {
                    growthCell.entryPixel = PIXEL.TOP;
                  } else if (cell.orientation.y == 1) {
                    growthCell.entryPixel = PIXEL.RIGHT;
                  } else {
                    growthCell.entryPixel = PIXEL.LEFT;
                  }
                } else if (abs(cell.orientation.z) == 1) {
                  if (abs(growthCell.orientation.z) == 1) {
                    growthCell.entryPixel = PIXEL.LEFT;
                  } else if (cell.orientation.x == 1) {
                    growthCell.entryPixel = PIXEL.LEFT;
                  } else {
                    growthCell.entryPixel = PIXEL.RIGHT;
                  }
                }
                break;
              }
              case 2: {
                if ((abs(cell.orientation.x) == 1) || (abs(cell.orientation.y) == 1)) {
                  growthCell.entryPixel = PIXEL.TOP;
                } else if (cell.orientation.z == 1) {
                  if (growthCell.orientation.y == 1) {
                    growthCell.entryPixel = PIXEL.LEFT;
                  } else if (growthCell.orientation.y == -1) {
                    growthCell.entryPixel = PIXEL.RIGHT;
                  } else if (growthCell.orientation.z == 1) {
                    growthCell.entryPixel = PIXEL.TOP;
                  } else {
                    growthCell.entryPixel = PIXEL.BOTTOM;
                  }
                } else if (cell.orientation.z == -1) {
                  if (growthCell.orientation.y == 1) {
                    growthCell.entryPixel = PIXEL.RIGHT;
                  } else if (growthCell.orientation.y == -1) {
                    growthCell.entryPixel = PIXEL.LEFT;
                  } else if (growthCell.orientation.z == 1) {
                    growthCell.entryPixel = PIXEL.BOTTOM;
                  } else {
                    growthCell.entryPixel = PIXEL.TOP;
                  }
                }
                break;
              }
              case 3: {
                if (cell.orientation.x == 1) {
                  if ((growthCell.orientation.x == 1) || (abs(growthCell.orientation.z) == 1)) {
                    growthCell.entryPixel = PIXEL.RIGHT;
                  } else {
                    growthCell.entryPixel = PIXEL.LEFT;
                  }
                } else if (cell.orientation.x == -1) {
                  if ((growthCell.orientation.x == 1) || (abs(growthCell.orientation.z) == 1)) {
                    growthCell.entryPixel = PIXEL.LEFT;
                  } else {
                    growthCell.entryPixel = PIXEL.RIGHT;
                  }
                } else if (cell.orientation.y == 1) {
                  if (abs(growthCell.orientation.z) == 1) {
                    growthCell.entryPixel = PIXEL.BOTTOM;
                  } else if (cell.orientation.y == 1) {
                    growthCell.entryPixel = PIXEL.RIGHT;
                  } else {
                    growthCell.entryPixel = PIXEL.LEFT;
                  }
                } else if (cell.orientation.y == -1) {
                  if (abs(growthCell.orientation.z) == 1) {
                    growthCell.entryPixel = PIXEL.TOP;
                  } else if (cell.orientation.y == 1) {
                    growthCell.entryPixel = PIXEL.LEFT;
                  } else {
                    growthCell.entryPixel = PIXEL.RIGHT;
                  }
                } else if (abs(cell.orientation.z) == 1) {
                  if (abs(growthCell.orientation.z) == 1) {
                    growthCell.entryPixel = PIXEL.RIGHT;
                  } else if (cell.orientation.x == 1) {
                    growthCell.entryPixel = PIXEL.RIGHT;
                  } else {
                    growthCell.entryPixel = PIXEL.LEFT;
                  }
                }
                break;
              }
            }
            
            // Calculate growthCell exit pixel
            if ((int)random(0, 2) == 0) {
              growthCell.exitPixel = growthCell.getLeftPixel(growthCell.entryPixel);
              if (growthCell.isPointingOut()) {
                growthCell.exitPixel = growthCell.getRightPixel(growthCell.entryPixel);
                System.out.println("CURRENT CELL ADJUSTED 1!");
              }
            } else {
              growthCell.exitPixel = growthCell.getRightPixel(growthCell.entryPixel);
              if (growthCell.isPointingOut()) {
                growthCell.exitPixel = growthCell.getLeftPixel(growthCell.entryPixel);
                System.out.println("CURRENT CELL ADJUSTED 2!");
              }
            }
            
            if (!growthCell.isPointingOut()) {
              adequateOrientationFound = true;
            } else {
              attempts++;
            }
          }
          
          if (attempts >= MAX_SIMULATION_ATTEMPTS) {
            System.out.println("\n### MAX ATTEMPTS REACHED. SIMULATION FAILED.\n"); 
            simulationFailed = true;
          }
          
          // Make the new cell the current one
          currentCell = growthCell;    
          System.out.println("CURRENT CELL: " + growthCell.x + "," +growthCell.y+ "," +growthCell.z+ "," + growthCell.entryPixel + "," + growthCell.exitPixel);
          
          // Isolate neighbours
          //isolateNeighbours(growthCellX, growthCellY, growthCellZ);
          cellsGrown++;
        }
        else if (cellsGrown == 1) {
          simulationFailed = true;
        }
      }
    }
    
    if (simulationFailed) {
      environment.resetEnvironment();
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
      
      //if ((growthCellX-2) >= 0) {
      //  matrix[growthCellX-2][growthCellY][growthCellZ].weight = 1.0;
      //}
      //if ((growthCellX+2) < envXMaxUnits) {
      //  matrix[growthCellX+2][growthCellY][growthCellZ].weight = 1.0;
      //}
    }
    if (abs(growthCell.orientation.y) == 1) {
      if ((growthCellY-1) >= 0) {
        matrix[growthCellX][growthCellY-1][growthCellZ].weight = 1.0;
      }
      if ((growthCellY+1) < envYMaxUnits) {
        matrix[growthCellX][growthCellY+1][growthCellZ].weight = 1.0;
      }
      
      //if ((growthCellY-2) >= 0) {
      //  matrix[growthCellX][growthCellY-2][growthCellZ].weight = 1.0;
      //}
      //if ((growthCellY+2) < envYMaxUnits) {
      //  matrix[growthCellX][growthCellY+2][growthCellZ].weight = 1.0;
      //}
    }
    if (abs(growthCell.orientation.z) == 1) {
      if ((growthCellZ-1) >= 0) {
        matrix[growthCellX][growthCellY][growthCellZ-1].weight = 1.0;
      }
      if ((growthCellZ+1) < envZMaxUnits) {
        matrix[growthCellX][growthCellY][growthCellZ+1].weight = 1.0;
      }
      
      //if ((growthCellZ-2) >= 0) {
      //  matrix[growthCellX][growthCellY][growthCellZ-2].weight = 1.0;
      //}
      //if ((growthCellZ+2) < envZMaxUnits) {
      //  matrix[growthCellX][growthCellY][growthCellZ+2].weight = 1.0;
      //}
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