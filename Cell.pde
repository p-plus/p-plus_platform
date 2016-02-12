public static enum PIXEL {TOP, BOTTOM, LEFT, RIGHT};
public static enum DIRECTION {N, S, E, W, U, D};
public static enum TYPE {A, B};// A: exit pixel at left; B: exit pixel at right

public class Cell {
  private PVector[] directions = {new PVector(-1, 0, 0),         //0
                                        new PVector(0, -1, 0),   //1
                                        new PVector(0, 0, -1),   //2
                                        new PVector(1, 0, 0),    //3
                                        new PVector(0, 1, 0)};    //4
//                                        new PVector(0, 0, 1)};   //5 // Suppressed for now so that no light cells faces up
  
  public int x, y, z;
  public boolean solid;
  public boolean baseCell;
  public boolean connectingChainInPath;
  public int indexOnPath;
  public float weight;
  public PVector orientation = new PVector(0, 0, 0);
  public int orientationIndex;
  public PIXEL entryPixel;
  public PIXEL exitPixel;
  
  public Cell(int x, int y, int z) {
    this.x = x;
    this.y = y;
    this.z = z;
    
    initialiseOrientation();
  }
  
  public PIXEL getLeftPixel(PIXEL p) {
    PIXEL pix = PIXEL.RIGHT;
    if (p == PIXEL.TOP) {
      pix = PIXEL.RIGHT;
    } else if (p == PIXEL.RIGHT) {
      pix = PIXEL.BOTTOM;
    } else if (p == PIXEL.BOTTOM) {
      pix = PIXEL.LEFT;
    } else if (p == PIXEL.LEFT) {
      pix = PIXEL.TOP;
    }
    
    return pix;
  }
  
  public PIXEL getRightPixel(PIXEL p) {
    PIXEL pix = PIXEL.RIGHT;
    if (p == PIXEL.TOP) {
      pix = PIXEL.LEFT;
    } else if (p == PIXEL.RIGHT) {
      pix = PIXEL.TOP;
    } else if (p == PIXEL.BOTTOM) {
      pix = PIXEL.RIGHT;
    } else if (p == PIXEL.LEFT) {
      pix = PIXEL.BOTTOM;
    }
    
    return pix;
  }
  
  public TYPE getType() {
    TYPE type = null;
    
    if (entryPixel == PIXEL.BOTTOM) { 
      if (exitPixel == PIXEL.LEFT) {
        type = TYPE.A;
      } else if (exitPixel == PIXEL.RIGHT) {
        type = TYPE.B;
      } 
    }
    
    if (entryPixel == PIXEL.TOP) { 
      if (exitPixel == PIXEL.RIGHT) {
        type = TYPE.A;
      } else if (exitPixel == PIXEL.LEFT) {
        type = TYPE.B;
      } 
    }
    
    if (entryPixel == PIXEL.LEFT) { 
      if (exitPixel == PIXEL.TOP) {
        type = TYPE.A;
      } else if (exitPixel == PIXEL.BOTTOM) {
        type = TYPE.B;
      } 
    }
    
    if (entryPixel == PIXEL.RIGHT) { 
      if (exitPixel == PIXEL.BOTTOM) {
        type = TYPE.A;
      } else if (exitPixel == PIXEL.TOP) {
        type = TYPE.B;
      } 
    }
    
    return type;
  }
  
  public boolean isPointingOut(boolean cellChainNearCompleted) {
    boolean pointingOut = false;
    
    if (!cellChainNearCompleted) {
      // Pointing below z
      if (((abs(orientation.x) == 1) || (abs(orientation.y) == 1)) && (exitPixel == PIXEL.BOTTOM)) {
        if ((z == 0) || (environment.matrix[x][y][z-1].weight >= 1) || environment.matrix[x][y][z-1].solid) {
          pointingOut = true;
        }
      }
    }
    
    //Pointing above z
    if (((abs(orientation.x) == 1) || (abs(orientation.y) == 1)) && (exitPixel == PIXEL.TOP)) {
      if ((z+1 >= envZMaxUnits) || (environment.matrix[x][y][z+1].weight >= 1) || environment.matrix[x][y][z+1].solid) {
        pointingOut = true;
      }
    }
    
    // Pointing under x
    if (((orientation.y == 1) && (exitPixel == PIXEL.LEFT))
          || ((orientation.y == -1) && (exitPixel == PIXEL.RIGHT))
          || ((orientation.z == 1) && (exitPixel == PIXEL.TOP))
          || ((orientation.z == -1) && (exitPixel == PIXEL.BOTTOM))) {
        if ((x == 0) || (environment.matrix[x-1][y][z].weight >= 1) || environment.matrix[x-1][y][z].solid) {
          pointingOut = true;
        }
    }
    
    // Pointing beyond x
    if (((orientation.y == 1) && (exitPixel == PIXEL.RIGHT))
          || ((orientation.y == -1) && (exitPixel == PIXEL.LEFT))
          || ((orientation.z == 1) && (exitPixel == PIXEL.BOTTOM))
          || ((orientation.z == -1) && (exitPixel == PIXEL.TOP))) {
        if ((x+1 >= envXMaxUnits) || (environment.matrix[x+1][y][z].weight >= 1) || environment.matrix[x+1][y][z].solid) {
          pointingOut = true;
        }
    }
    
    // Pointing under y
    if (((orientation.x == 1) && (exitPixel == PIXEL.RIGHT))
          || ((orientation.x == -1) && (exitPixel == PIXEL.LEFT))
          || ((abs(orientation.z) == 1) && (exitPixel == PIXEL.RIGHT))) {
        if ((y == 0) || (environment.matrix[x][y-1][z].weight >= 1) || environment.matrix[x][y-1][z].solid) {
          pointingOut = true;
        }
    }
    
    // Pointing beyond y
    if (((orientation.x == 1) && (exitPixel == PIXEL.LEFT))
          || ((orientation.x == -1) && (exitPixel == PIXEL.RIGHT))
          || ((abs(orientation.z) == 1) && (exitPixel == PIXEL.LEFT))) {
        if ((y+1 >= envYMaxUnits) || (environment.matrix[x][y+1][z].weight >= 1) || environment.matrix[x][y+1][z].solid) {
          pointingOut = true;
        }
    }
    
    return pointingOut;
  }
  
  boolean isCellFacingDisplayedFacet() {
    if (facetDisplayed != FACET.ALL) {
      if ((facetDisplayed == FACET.WEST) && (orientation.x == -1)) {
        return true;
      }
      
      if ((facetDisplayed == FACET.EAST) && (orientation.x == 1)) {
        return true;
      }
      
      if ((facetDisplayed == FACET.SOUTH) && (orientation.y == 1)) {
        return true;
      }
      
      if ((facetDisplayed == FACET.NORTH) && (orientation.y == -1)) {
        return true;
      }
      
      if ((facetDisplayed == FACET.BOTTOM_UP) && (orientation.z == 1)) {
        return true;
      }
      
      if ((facetDisplayed == FACET.CEILING_DOWN) && (orientation.z == -1)) {
        return true;
      }
      
      return false;
    }
    
    return true;
  }
  
  void drawCell() {
    if (!isCellFacingDisplayedFacet()) {
      return;
    }
    
    //color boxColour = color(255, 0, 0, 50);
    color boxColour = color(40, 40, 40, 200);
    color boxOffColour = color(230, 50, 190, 250);
    color faceColour = color(150, 200, 100, 250);
    color textColour = color(50, 255, 255);
    
    color faceXColour = color(150, 0, 100, 250);
    color faceYColour = color(200, 200, 30, 250);
    color faceZColour = color(00, 200, 200, 250);
    
    if (runningSimulation) {
      noStroke();
      
      if (solid) {
        fill(boxColour);        
      } else if ((weight > 0) && (displayWeights)) {
          fill(0, 0, weight*255, 100);
      } else {
        noFill();
      }
    } else {
      noStroke();
      if (solid) {
        fill(boxColour);
      } else if ((weight > 0) && (displayWeights)) {
          fill(0, 0, weight*255, 100);
      } else {
        noFill();
      }
    }
    
    pushMatrix();
    
    int OFF = (configMode)?0:DRAW_OFFSET;
    translate(OFF+unitSize/2+x*unitSize, OFF+unitSize/2+y*unitSize, unitSize/2+z*unitSize);
    
    int projCoord_i = 0;
    int projCoord_j = 0;
    if (solid && displayFaces) {
      if (orientation.x == 1) {
        // Do not need to rotate
        projCoord_i = envYMaxUnits-1-y;
        projCoord_j = z;
      }
      
      if (orientation.x == -1) {
        rotateZ(radians(180));
        projCoord_i = y;
        projCoord_j = z;
      }
      
      if (orientation.y == 1) {
        rotateZ(radians(90));
        projCoord_i = x;
        projCoord_j = z;
      }
      
      if (orientation.y == -1) {
        rotateZ(radians(-90));
        projCoord_i = envXMaxUnits-1-x;
        projCoord_j = z;
      }
      
      if (orientation.z == 1) {
        rotateY(radians(-90));
        projCoord_i = envYMaxUnits-1-y;
        projCoord_j = envXMaxUnits-1-x;
      }
      
      if (orientation.z == -1) {
        rotateY(radians(90));
        projCoord_i = envYMaxUnits-1-y;
        projCoord_j = x;
      }
      
      box(unitSize/6, unitSize, unitSize/4);
      box(unitSize/6, unitSize/4, unitSize);
      
      if (rollingText) {
        fill(boxOffColour);
        shininess(5.0);
        specular(255, 255, 255);
      } else if (facesDifferentColours) {
        if (abs(orientation.x) == 1) {
          fill(faceXColour);
        } else if (abs(orientation.y) == 1) {
          fill(faceYColour);
        } else if (abs(orientation.z) == 1) {
          fill(faceZColour);
        }
      } else {  
        fill(faceColour);
      }
      
      translate(unitSize/6, 0, 0);
       
      if (pixelColours) {
        fill(color(cos(second()*(z+1))*255, cos(second()*(x+1))*200, cos(second()*(y+1))*255));
      }
      box(unitSize/12, unitSize, unitSize/4);
     
      if (pixelColours) {
        fill(color(cos(second()*(y+1))*255, cos(second())*180, sin(second()*(y+1))*200));
      }
      box(unitSize/12, unitSize/4, unitSize);
      
      if (rollingText) {
        //Draw pixel at BOTTOM
        fill(boxOffColour);
        if (environment.getTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.BOTTOM)) {
          fill(textColour);
          pushMatrix();
          translate(2, 0, -unitSize/4);
          box(unitSize/12, unitSize/4, unitSize/2);
          scale(0.5);
          popMatrix();
        }
        //Draw pixel at RIGHT
        fill(boxOffColour);
        if (environment.getTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.RIGHT)) {
          fill(textColour);
          pushMatrix();
          translate(2, -unitSize/4, 0);
          box(unitSize/12, unitSize/2, unitSize/4);
          popMatrix();
        }
        
        //Draw pixel at TOP
        fill(boxOffColour);
        if (environment.getTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.TOP)) {
          fill(textColour);
          pushMatrix();
          translate(2, 0, unitSize/4);
          box(unitSize/12, unitSize/4, unitSize/2);
          popMatrix();
        }
        
        //Draw pixel at LEFT
        fill(boxOffColour);
        if (environment.getTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.LEFT)) {
          fill(textColour);
          pushMatrix();
          translate(2, unitSize/4, 0);
          box(unitSize/12, unitSize/2, unitSize/4);
          popMatrix();
        }
      }
      
      emissive(0, 0, 0);
      shininess(0.0);

      // Draw wire
      if (!pixelColours && !rollingText) {
        fill(0, 255, 0);
        pushMatrix();
        if ((entryPixel == PIXEL.BOTTOM) || (exitPixel == PIXEL.BOTTOM)) {
          translate(2, 0, -unitSize/4);
          box(unitSize/12, unitSize/16, unitSize/2);
        }
        popMatrix();
        pushMatrix();
        if ((entryPixel == PIXEL.TOP) || (exitPixel == PIXEL.TOP)) {
          translate(2, 0, unitSize/4);
          box(unitSize/12, unitSize/16, unitSize/2);
        } 
        popMatrix();
        pushMatrix();
        if ((entryPixel == PIXEL.LEFT) || (exitPixel == PIXEL.LEFT)) {
          translate(2, unitSize/4, 0);
          box(unitSize/12, unitSize/2, unitSize/16);
        }
        popMatrix();
        pushMatrix();
        if ((entryPixel == PIXEL.RIGHT) || (exitPixel == PIXEL.RIGHT)) {
          translate(2, -unitSize/4, 0);
          box(unitSize/12, unitSize/2, unitSize/16);
        }
        popMatrix();
      }
    } else {
      box(unitSize);
    }
    
    popMatrix();
  }
  
  void reset() {
    solid = false;
    indexOnPath = 0;
    baseCell = false;
    connectingChainInPath = false;
  }
  
  public void initialiseOrientation() {
    orientationIndex = int(random(0, directions.length));
    
    // PERHAPS TEMPORARY: Make sure no cell faces up
    while ((z < envZMaxUnitsPath-1) && (orientationIndex == 2)) {
       orientationIndex = int(random(0, directions.length));
    }
    
    orientation = directions[orientationIndex];
    adjustOrientation();
  }
  
  
  /* 
   * Computes an adequate orientation for a neighbouring cell,
   * so that it does not conflict with the current cell's orientation.
   */
  public PVector pickNeighbourOrientation(boolean xok, boolean yok, boolean zok, boolean nearCompleted) {
    boolean found = false;
    int foundIndex = 0;
    while (!found) {
      int index = int(random(0, directions.length));
      if ((xok && abs(directions[index].x) == 1)
          || (yok && abs(directions[index].y) == 1)
          || (zok && abs(directions[index].z) == 1) && (z >= envZMaxUnitsPath-1) && !nearCompleted) { // Ensures minimum height for walking 
            foundIndex = index;
            found = true;
       }
    }
    
    return directions[foundIndex];
  }

  /* 
   * Adjusts the orientation of cells facing up or down,
   * so that only cells closer to the top face down,
   * and only those closer to the floor face up.
   */
  public void adjustOrientation() {
    if (abs(orientation.x) == 1) {
     if (x < envXMaxUnits/2) {
       orientation.x = -1;
     } else {
       orientation.x = 1;
     }
    } else if (abs(orientation.y) == 1) {
     if (y < envYMaxUnits/2) {
       orientation.y = -1;
     } else {
       orientation.y = 1;
     }
    } else if (abs(orientation.z) == 1) {
     if (z < envZMaxUnits/2) {
       orientation.z = 1; // z-coordinate should face inward
     } else {
       orientation.z = -1;
     }
    }
  }
  
  public int getRotation() {
    if (entryPixel == PIXEL.RIGHT) {
       return 90;
    }
    
    if (entryPixel == PIXEL.TOP) {
       return 180;
    }
    
    if (entryPixel == PIXEL.LEFT) {
       return 270;
    }
    
    return 0;
  }
  
  public DIRECTION getOrientation() {
    if (orientation.x == 1) {
      return DIRECTION.E;
    }
    
    if (orientation.x == -1) {
      return DIRECTION.W;
    }
    
    if (orientation.y == 1) {
      return DIRECTION.S;
    }
    
    if (orientation.y == -1) {
      return DIRECTION.N;
    }
    
    if (orientation.z == 1) {
      return DIRECTION.U;
    }
    
    if (orientation.z == -1) {
      return DIRECTION.D;
    }
    
    return null;
  }
  
  public DIRECTION getExitPixelDirection() {
    DIRECTION exitPixelDirection = null;
    
    // Orientation: NORTH
    if (getOrientation() == DIRECTION.N) {
      if (entryPixel == PIXEL.BOTTOM) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.W;
        } else {
          exitPixelDirection = DIRECTION.E;
        }
      }
      if (entryPixel == PIXEL.TOP) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.E;
        } else {
          exitPixelDirection = DIRECTION.W;
        }
      }
      if (entryPixel == PIXEL.LEFT) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.D;
        } else {
          exitPixelDirection = DIRECTION.U;
        }
      }
      if (entryPixel == PIXEL.RIGHT) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.U;
        } else {
          exitPixelDirection = DIRECTION.D;
        }
      }
    }
    
    // Orientation:SOUTH
    if (getOrientation() == DIRECTION.S) {
      if (entryPixel == PIXEL.BOTTOM) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.E;
        } else {
          exitPixelDirection = DIRECTION.W;
        }
      }
      if (entryPixel == PIXEL.TOP) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.W;
        } else {
          exitPixelDirection = DIRECTION.E;
        }
      }
      if (entryPixel == PIXEL.LEFT) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.D;
        } else {
          exitPixelDirection = DIRECTION.U;
        }
      }
      if (entryPixel == PIXEL.RIGHT) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.U;
        } else {
          exitPixelDirection = DIRECTION.D;
        }
      }
    }
    
    // Orientation: EAST
    if (getOrientation() == DIRECTION.E) {
      if (entryPixel == PIXEL.BOTTOM) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.N;
        } else {
          exitPixelDirection = DIRECTION.S;
        }
      }
      if (entryPixel == PIXEL.TOP) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.S;
        } else {
          exitPixelDirection = DIRECTION.N;
        }
      }
      if (entryPixel == PIXEL.LEFT) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.D;
        } else {
          exitPixelDirection = DIRECTION.U;
        }
      }
      if (entryPixel == PIXEL.RIGHT) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.U;
        } else {
          exitPixelDirection = DIRECTION.D;
        }
      }
    }
    
    // Orientation: WEST
    if (getOrientation() == DIRECTION.W) {
      if (entryPixel == PIXEL.BOTTOM) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.S;
        } else {
          exitPixelDirection = DIRECTION.N;
        }
      }
      if (entryPixel == PIXEL.TOP) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.N;
        } else {
          exitPixelDirection = DIRECTION.S;
        }
      }
      if (entryPixel == PIXEL.LEFT) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.D;
        } else {
          exitPixelDirection = DIRECTION.U;
        }
      }
      if (entryPixel == PIXEL.RIGHT) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.U;
        } else {
          exitPixelDirection = DIRECTION.D;
        }
      }
    }
    
    // Orientation: UP
    if (getOrientation() == DIRECTION.U) {
      if (entryPixel == PIXEL.BOTTOM) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.N;
        } else {
          exitPixelDirection = DIRECTION.S;
        }
      }
      if (entryPixel == PIXEL.TOP) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.S;
        } else {
          exitPixelDirection = DIRECTION.N;
        }
      }
      if (entryPixel == PIXEL.LEFT) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.E;
        } else {
          exitPixelDirection = DIRECTION.W;
        }
      }
      if (entryPixel == PIXEL.RIGHT) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.W;
        } else {
          exitPixelDirection = DIRECTION.E;
        }
      }
    }
    
    // Orientation: DOWN
    if (getOrientation() == DIRECTION.D) {
      if (entryPixel == PIXEL.BOTTOM) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.N;
        } else {
          exitPixelDirection = DIRECTION.S;
        }
      }
      if (entryPixel == PIXEL.TOP) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.S;
        } else {
          exitPixelDirection = DIRECTION.N;
        }
      }
      if (entryPixel == PIXEL.LEFT) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.W;
        } else {
          exitPixelDirection = DIRECTION.E;
        }
      }
      if (entryPixel == PIXEL.RIGHT) {
        if (exitPixel == PIXEL.RIGHT) {
          exitPixelDirection = DIRECTION.E;
        } else {
          exitPixelDirection = DIRECTION.W;
        }
      }
    } 
    
    return exitPixelDirection;
  }
  
  public boolean isAvailable() {
    return !solid && (weight < 1);
  }
  
}