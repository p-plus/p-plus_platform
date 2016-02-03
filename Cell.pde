public static enum PIXEL {TOP, BOTTOM, LEFT, RIGHT};

public class Cell {
  private PVector[] directions = {new PVector(-1, 0, 0),         //0
                                        new PVector(0, -1, 0),   //1
                                        new PVector(0, 0, -1),   //2
                                        new PVector(1, 0, 0),    //3
                                        new PVector(0, 1, 0)};    //4
//                                        new PVector(0, 0, 1)};   //5 // Suppressed for now so that no light cells faces up
  
  public int x, y, z;
  public boolean solid;
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
  
  public boolean isPointingOut() {
    boolean pointingOut = false;
    
    // Pointing below z
    if (((abs(orientation.x) == 1) || (abs(orientation.y) == 1)) && (exitPixel == PIXEL.BOTTOM)) {
      if ((z == 0) || (environment.matrix[x][y][z-1].weight >= 1) || environment.matrix[x][y][z-1].solid) {
        pointingOut = true;
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
    color boxColour = color(60, 60, 60, 250);
    color faceColour = color(150, 200, 100, 250);
    
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
    
    if (solid && displayFaces) {
      if (orientation.x == 1) {
        // Do nothing
      }
      
      if (orientation.x == -1) {
        rotateZ(radians(180));
      }
      
      if (orientation.y == 1) {
        rotateZ(radians(90));
      }
      
      if (orientation.y == -1) {
        rotateZ(radians(-90));
      }
      
      if (orientation.z == 1) {
        rotateY(radians(-90));
      }
      
      if (orientation.z == -1) {
        rotateY(radians(90));
      }
      
      box(unitSize/6, unitSize, unitSize/4);
      box(unitSize/6, unitSize/4, unitSize);
      
      if (facesDifferentColours) {
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
      
      // Draw wire
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
      
/*
      // x-axis
      if (orientation.x == 1) {
        box(unitSize/6, unitSize, unitSize/4);
        box(unitSize/6, unitSize/4, unitSize);
        if (facesDifferentColours) {
          fill(faceXColour);
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
      }
      
      if (orientation.x == -1) {
       box(unitSize/6, unitSize, unitSize/4);
       box(unitSize/6, unitSize/4, unitSize);
       if (facesDifferentColours) {
         fill(faceXColour);
       } else {  
         fill(faceColour);
       }
       translate(-unitSize/6, 0, 0);
       
       if (pixelColours) {
         fill(color(sin(second())*(y+1)*220, sin(second())*random(0, 255), sin(second())*(y+1)*100));
       }
       box(unitSize/12, unitSize, unitSize/4);
       
       if (pixelColours) {
         fill(color(sin(second())*(y+1)*255, cos(second())*(y+1)*100, random(0, 255)));
       }
       box(unitSize/12, unitSize/4, unitSize);
      }
      
      //y-axis
      if (orientation.y == 1) {
       box(unitSize, unitSize/6, unitSize/4);
       box(unitSize/4, unitSize/6, unitSize);
       if (facesDifferentColours) {
         fill(faceYColour);
       } else {  
         fill(faceColour);
       }
       translate(0, unitSize/6, 0);
       
       if (pixelColours) {
         fill(color(sin(second()*(x+1))*255, cos(second())*255, sin(second())*random(0, 200)));
       }
       box(unitSize, unitSize/12, unitSize/4);
       
       if (pixelColours) {
         fill(color(cos(second())*random(0, 255), cos(second()*(y+1))*random(100, 255), sin((y+1)*second())*200));
       }
       box(unitSize/4, unitSize/12, unitSize);
      }
      
      if (orientation.y == -1) {
       box(unitSize, unitSize/6, unitSize/4);
       box(unitSize/4, unitSize/6, unitSize);
       if (facesDifferentColours) {
         fill(faceYColour);
       } else {  
         fill(faceColour);
       }
       translate(0, -unitSize/6, 0);
       
       if (pixelColours) {
         fill(color(cos(second())*(z+1)*200, cos(second())*random(100, 255), cos(second())*(z+1)*random(0, 200)));
       }
       box(unitSize, unitSize/12, unitSize/4);
       
       if (pixelColours) {
         fill(color(cos(second())*random(0, 220), sin(second())*(x+1)*random(0, 200), cos(second())*(x+1)*255));
       }
       box(unitSize/4, unitSize/12, unitSize);
      }

      //z-axis
      if (orientation.z == 1) {
       box(unitSize/4, unitSize, unitSize/6);
       box(unitSize, unitSize/4, unitSize/6);
       if (facesDifferentColours) {
         fill(faceZColour);
       } else {  
         fill(faceColour);
       }
       translate(0, 0, unitSize/6);
       
       if (pixelColours) {
         fill(color(cos(second())*255, random(0, 200), cos(second())*random(100, 255)));
       }
       box(unitSize/4, unitSize, unitSize/12);
       
       if (pixelColours) {
         fill(color(sin(second())*255, sin(second())*255, sin(second())*random(100, 255)));
       }
       box(unitSize, unitSize/4, unitSize/12);
      }
      
      if (orientation.z == -1) {
       box(unitSize/4, unitSize, unitSize/6);
       box(unitSize, unitSize/4, unitSize/6);
       if (facesDifferentColours) {
         fill(faceZColour);
       } else {  
         fill(faceColour);
       }
       translate(0, 0, -unitSize/6);
       
       if (pixelColours) {
         fill(color(sin(second())*255, sin(second())*random(0, 200), 150));
       }
       box(unitSize/4, unitSize, unitSize/12);
       
       if (pixelColours) {
         fill(color(sin(second())*255, sin(second())*100, sin(second())*random(0, 255)));
       }
       box(unitSize, unitSize/4, unitSize/12);
      }
*/
    } else {
      box(unitSize);
    }
    
    popMatrix();
  }
  
  void reset() {
    solid = false;
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
  public PVector pickNeighbourOrientation(boolean xok, boolean yok, boolean zok) {
    boolean found = false;
    int foundIndex = 0;
    while (!found) {
      int index = int(random(0, directions.length));
      if ((xok && abs(directions[index].x) == 1)
          || (yok && abs(directions[index].y) == 1)
          || (zok && abs(directions[index].z) == 1) && (z >= envZMaxUnitsPath-1)) { // Ensures minimum height for walking 
            foundIndex = index;
            found = true;
       }
    }
    
    return directions[foundIndex];
  }

  private boolean hasPixelWayOut(PIXEL pix) {
     exitPixel = PIXEL.LEFT;
     return isPointingOut();
  }

  private boolean hasOrientationWayOut() {
    boolean hasWayOut = false;
    if ((entryPixel == PIXEL.TOP) || (entryPixel == PIXEL.BOTTOM)) {
      hasWayOut = hasPixelWayOut(PIXEL.LEFT) || hasPixelWayOut(PIXEL.RIGHT);
    } else if ((entryPixel == PIXEL.LEFT) || (entryPixel == PIXEL.RIGHT)) {
      hasWayOut = hasPixelWayOut(PIXEL.TOP) || hasPixelWayOut(PIXEL.BOTTOM);
    }
    
    return hasWayOut;
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
  
}