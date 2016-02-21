public class CellChain {
  private final int MAX_LENGTH = MAX_CELL_CHAIN_LENGTH;
  private final int MAX_BACKTRACKING_LENGTH = 15;
  private final int MAX_BACKTRACKING_ATTEMPTS = 50;
  
  private int index;
  private int backtrackingAttempts;
  private ArrayList<Cell> cells;
  
  public CellChain(int index) {
    this.index = index; //<>//
    cells = new ArrayList<Cell>();
  }
  
  public void addCell(Cell cell) {
    cells.add(cell);  
  }
  
  private void emptyChain() {
    if (!cells.isEmpty()) {
      for (Cell cell : cells) {
        cell.reset();
      }
    }
    cells.clear();
  }
  
  public void resetChain() {
    emptyChain();
    
    // Initialise position of first cell in the chain
    Cell initialCell = null;
    while (initialCell == null) {
      int x = int(random(0, envXMaxUnits));
      int y = int(random(0, envYMaxUnits));
      int z = 0;
      if (environment.getMatrix()[x][y][z].isAvailable()) {
        initialCell = environment.getMatrix()[x][y][z];
        initialCell = environment.createRootCell(index);
        initialCell.solid = true;
      }
    }
    cells.add(initialCell);
    backtrackingAttempts = 0;
  }
  
  public ArrayList<Cell> getCells() {
    return cells;
  }
  
  public Cell getFirstCell() {
    if (cells.size() > 0) {
      return cells.get(0);
    }
    return null;
  }
  
  public Cell getLastCell() {
    if (cells.size() > 0) {
      return cells.get(cells.size()-1);
    }
    return null;
  }
  
  public int getSize() {
    return cells.size();
  }
  
  public boolean isCompleted() {
    return (getSize() >= MAX_LENGTH) || (isGroundConnected() && isNearCompleted());
  }
  
  public boolean isNearCompleted() {
    int cellsToGo = MAX_LENGTH-getSize();
    int minStepsToFloor = getLastCell().z*2;
    if (getLastCell().getExitPixelDirection() == DIRECTION.D) {
      minStepsToFloor++;
    }
    return (cellsToGo - minStepsToFloor) < 5;
  }
  
  public boolean isTooShort() {
    int cellsToGo = MAX_LENGTH-getSize();
    int minStepsToFloor = getLastCell().z*2;
    if (getLastCell().getExitPixelDirection() == DIRECTION.D) {
      minStepsToFloor++;
    }
    return cellsToGo < minStepsToFloor;
  }
  
  public boolean isGroundConnected() {
    return (getLastCell().z == 0) && (getLastCell().getExitPixelDirection() == DIRECTION.D); 
  }
  
  public boolean grow() {
    boolean hasGrown = false;
    if (isCompleted()) {
      return false;
    }
    hasGrown = growCell(getFirstCell());
    if (!hasGrown && (getLastCell() != null)) {
      hasGrown = growCell(getLastCell());
    }
    
    if (!hasGrown || isTooShort()) {
      if (backtrackingAttempts >= MAX_BACKTRACKING_ATTEMPTS) {
        environment.simulationFailed = true;
      } else {
        for (int i = 0; i < MAX_BACKTRACKING_LENGTH; i++) {
          if (cells.size() > 1) {
            cells.get(cells.size()-1).reset();
            cells.remove(cells.size()-1);
          }
        }
        backtrackingAttempts++;
      }
    }
    
    return hasGrown;
  }
  
  public boolean growCell(Cell cell) {
    boolean hasGrown = false;

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
    
    int growthCellX = cell.x;
    int growthCellY = cell.y;
    int growthCellZ = cell.z;
    
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
    
    if (environment.validCoordinates(growthCellX, growthCellY, growthCellZ)) {
      Cell growthCell = environment.getMatrix()[growthCellX][growthCellY][growthCellZ];
      
      // Check whether cell is solid and, if so, whether its exit pixel matches 
      // the current cell's exit pixel, i.e. if paths can be joined.
      if (!growthCell.solid && environment.enoughPorous(growthCell)) { // Else, try to grow into that space
        growthCell.solid = true; 
        
        int MAX_SIMULATION_ATTEMPTS = 10;
        int attempts = 0;
        boolean adequateOrientationFound = false; 
        while (!adequateOrientationFound && (attempts < MAX_SIMULATION_ATTEMPTS)) {
          growthCell.orientation = growthCell.pickNeighbourOrientation(xok, yok, zok, isNearCompleted());
          growthCell.adjustOrientation();
          
          Cell cellInFront = null;
          if (growthCell.getOrientation() == DIRECTION.N) {
            if (growthCellY > 0) {
              cellInFront = environment.getMatrix()[growthCellX][growthCellY-1][growthCellZ];
            }
          }
          if (growthCell.getOrientation() == DIRECTION.S) {
            if (growthCellY < envYMaxUnits-1) {
              cellInFront = environment.getMatrix()[growthCellX][growthCellY+1][growthCellZ];
            }
          }
          if (growthCell.getOrientation() == DIRECTION.W) {
            if (growthCellX > 0) {
              cellInFront = environment.getMatrix()[growthCellX-1][growthCellY][growthCellZ];
            }
          }
          if (growthCell.getOrientation() == DIRECTION.E) {
            if (growthCellX < envXMaxUnits-1) {
              cellInFront = environment.getMatrix()[growthCellX][growthCellX+1][growthCellZ];
            }
          }
          if ((cellInFront != null) && (cellInFront.getOrientation() == growthCell.getOrientation())) {
            if ((int)random(0, 2) == 0) {
              attempts++;
              continue;
            }
          }
          
            
          // PREVENT CELLS STANDING BEHIND OTHERS WITH SAME DIRECTION
          if ((growthCellZ > 0) && (environment.getMatrix()[growthCellX][growthCellY][growthCellZ-1].solid))  {
            growthCell.weight = environment.getMatrix()[growthCellX][growthCellY][growthCellZ-1].weight+cellLoadOffset;
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
            if (growthCell.isPointingOut(isNearCompleted()) || (isNearCompleted() && growthCell.getExitPixelDirection() == DIRECTION.U)) {
              growthCell.exitPixel = growthCell.getRightPixel(growthCell.entryPixel);
            }
          } else {
            growthCell.exitPixel = growthCell.getRightPixel(growthCell.entryPixel);
            if (growthCell.isPointingOut(isNearCompleted()) || (isNearCompleted() && growthCell.getExitPixelDirection() == DIRECTION.U)) {
              growthCell.exitPixel = growthCell.getLeftPixel(growthCell.entryPixel);
            }
          }
          
          if (!growthCell.isPointingOut(isNearCompleted())) {
            adequateOrientationFound = true;
          } else {
            attempts++;
          }
        }
        
        //if (attempts >= MAX_SIMULATION_ATTEMPTS) { 
        //  environment.simulationFailed = true;
        //}
        
        // Make the new cell the current one
//        growthCell.indexOnPath = currentCell.indexOnPath+1;    
        
        // Isolate neighbours
//        environment.isolateNeighbours(growthCellX, growthCellY, growthCellZ);
//        cellsGrown++;
        hasGrown = true;
        cells.add(growthCell);
      } 
    }
    
    //if (!growthPossible && (currentCell.indexOnPath == 1)) {
    // environment.simulationFailed = true;
    //}

    return hasGrown;
  }
  
}