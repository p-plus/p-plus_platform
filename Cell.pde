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
  public boolean front;
  public boolean baseCell;
  public boolean connectingChainInPath;
  public boolean setupInstallation = true;
  public int indexOnPath;
  public float weight;
  public PVector orientation = new PVector(0, 0, 0);
  public int orientationIndex;
  public PIXEL entryPixel;
  public PIXEL exitPixel;
  public FACET facet;
  public color topCol, bottomCol, leftCol, rightCol;
  
  // Helper variables for drawing shapes with better performance - some values are hardcoded for convenience
  private final int rr0 = unitSize/20;
  private final int rr1 = unitSize/5;
  private final int rr2 = unitSize/7;
  private final int h = unitSize/2;
  private final float sin0 = sin( radians(0) );
  private final float cos0 = cos( radians(0) );
  private final float sin90 = sin( radians(90) );
  private final float cos90 = cos( radians(90) );
  private final float sin180 = sin( radians(180) );
  private final float cos180 = cos( radians(180) );
  private final float sin270 = sin( radians(270) );
  private final float cos270 = cos( radians(270) );
  private final float sin360 = sin( radians(360) );
  private final float cos360 = cos( radians(360) );
  
  
  public Cell(int x, int y, int z) {
    this.x = x;
    this.y = y;
    this.z = z;
    
    initialiseOrientation();
  }
  
  public Cell(int x, int y, int z, String type, String orientation, int rotation) {
    this.x = x;
    this.y = y;
    this.z = z;
    
    if(orientation.equals("N")){
      this.orientation.y = -1;
      this.facet = FACET.NORTH;
    }else if(orientation.equals("S")){
      this.orientation.y = 1;
      this.facet = FACET.SOUTH;
    }else if(orientation.equals("E")){
      this.orientation.x = 1;
      this.facet = FACET.EAST;
    }else if(orientation.equals("W")){
      this.orientation.x = -1;
      this.facet = FACET.WEST;
    }else if(orientation.equals("U")){
      this.orientation.z = 1;
      this.facet = FACET.BOTTOM_UP;
    }else if(orientation.equals("D")){
      this.orientation.z = -1;
      this.facet = FACET.CEILING_DOWN;
    }
    
    if(type.equals("A")){
      if(rotation==0){
        entryPixel = PIXEL.BOTTOM;
        exitPixel = PIXEL.LEFT;
      }else if(rotation==90){
        entryPixel = PIXEL.RIGHT;
        exitPixel = PIXEL.BOTTOM;
      }else if(rotation==180){
        entryPixel = PIXEL.TOP;
        exitPixel = PIXEL.RIGHT;        
      }else if(rotation==270){
        entryPixel = PIXEL.LEFT;
        exitPixel = PIXEL.TOP;        
      }
    }else if(type.equals("B")){
      if(rotation==0){
        entryPixel = PIXEL.BOTTOM;
        exitPixel = PIXEL.RIGHT;
      }else if(rotation==90){
        entryPixel = PIXEL.RIGHT;
        exitPixel = PIXEL.TOP;
      }else if(rotation==180){
        entryPixel = PIXEL.TOP;
        exitPixel = PIXEL.LEFT;        
      }else if(rotation==270){
        entryPixel = PIXEL.LEFT;
        exitPixel = PIXEL.BOTTOM;        
      }
    }
    
    this.solid = true;
    
    //initialiseOrientation();
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
  
  //void drawCell() {
  //  if (!isCellFacingDisplayedFacet()) {
  //    return;
  //  }
    
  //  //color boxColour = color(255, 0, 0, 50);
  //  color boxColour = color(40, 40, 40, 200);
  //  color boxOffColour = color(230, 50, 190, 250);
  //  color faceColour = color(150, 200, 100, 250);
  //  color textColour = color(50, 255, 255);
    
  //  color faceXColour = color(150, 0, 100, 255);
  //  color faceYColour = color(200, 200, 30, 255);
  //  color faceZColour = color(00, 200, 200, 255);
    
  //  if (runningSimulation) {
  //    noStroke();
      
  //    if (solid) {
  //      fill(boxColour);        
  //    } else if ((weight > 0) && (displayWeights)) {
  //        fill(0, 0, weight*255, 100);
  //    } else {
  //      noFill();
  //    }
  //  } else {
  //    noStroke();
  //    if (solid) {
  //      fill(boxColour);
  //    } else if ((weight > 0) && (displayWeights)) {
  //        fill(0, 0, weight*255, 100);
  //    } else {
  //      noFill();
  //    }
  //  }
    
  //  pushMatrix();
    
  //  int OFF = (configMode)?0:DRAW_OFFSET;
  //  translate(OFF+unitSize/2+x*unitSize, OFF+unitSize/2+y*unitSize, unitSize/2+z*unitSize);
    
  //  int projCoord_i = 0;
  //  int projCoord_j = 0;
  //  if (solid && displayFaces) {
  //    if (orientation.x == 1) {
  //      // Do not need to rotate
  //      projCoord_i = envYMaxUnits-1-y;
  //      projCoord_j = z;
  //    }
      
  //    if (orientation.x == -1) {
  //      rotateZ(radians(180));
  //      projCoord_i = y;
  //      projCoord_j = z;
  //    }
      
  //    if (orientation.y == 1) {
  //      rotateZ(radians(90));
  //      projCoord_i = x;
  //      projCoord_j = z;
  //    }
      
  //    if (orientation.y == -1) {
  //      rotateZ(radians(-90));
  //      projCoord_i = envXMaxUnits-1-x;
  //      projCoord_j = z;
  //    }
      
  //    if (orientation.z == 1) {
  //      rotateY(radians(-90));
  //      projCoord_i = envYMaxUnits-1-y;
  //      projCoord_j = envXMaxUnits-1-x;
  //    }
      
  //    if (orientation.z == -1) {
  //      rotateY(radians(90));
  //      projCoord_i = envYMaxUnits-1-y;
  //      projCoord_j = x;
  //    }
      
  //    box(unitSize/6, unitSize, unitSize/4);
  //    box(unitSize/6, unitSize/4, unitSize);
      
  //    if (rollingText) {
  //      fill(boxOffColour);
  //      shininess(5.0);
  //      specular(255, 255, 255);
  //    } else if (facesDifferentColours) {
  //      if (abs(orientation.x) == 1) {
  //        fill(faceXColour);
  //      } else if (abs(orientation.y) == 1) {
  //        fill(faceYColour);
  //      } else if (abs(orientation.z) == 1) {
  //        fill(faceZColour);
  //      }
  //    } else {  
  //      fill(faceColour);
  //    }
      
  //    translate(unitSize/6, 0, 0);
       
  //    if (pixelColours) {
  //      fill(color(cos(second()*(z+1))*255, cos(second()*(x+1))*200, cos(second()*(y+1))*255));
  //      emissive(color(cos(second()*(z+1))*255, cos(second()*(x+1))*200, cos(second()*(y+1))*255));
  //    }
  //    box(unitSize/12, unitSize, unitSize/4);
     
  //    if (pixelColours) {
  //      fill(color(cos(second()*(y+1))*255, cos(second())*180, sin(second()*(y+1))*200));
  //      emissive(color(cos(second()*(y+1))*255, cos(second())*180, sin(second()*(y+1))*200));
  //    }
  //    box(unitSize/12, unitSize/4, unitSize);
      
  //    if (rollingText) {
  //      //Draw pixel at BOTTOM
  //      fill(boxOffColour);
  //      if (environment.getTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.BOTTOM)) {
  //        fill(textColour);
  //        emissive(textColour);
  //        pushMatrix();
  //        translate(2, 0, -unitSize/4);
  //        box(unitSize/12, unitSize/4, unitSize/2);
  //        scale(0.5);
  //        popMatrix();
  //      }
  //      //Draw pixel at RIGHT
  //      fill(boxOffColour);
  //      if (environment.getTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.RIGHT)) {
  //        fill(textColour);
  //        emissive(textColour);
  //        pushMatrix();
  //        translate(2, -unitSize/4, 0);
  //        box(unitSize/12, unitSize/2, unitSize/4);
  //        popMatrix();
  //      }
        
  //      //Draw pixel at TOP
  //      fill(boxOffColour);
  //      if (environment.getTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.TOP)) {
  //        fill(textColour);
  //        emissive(textColour);
  //        pushMatrix();
  //        translate(2, 0, unitSize/4);
  //        box(unitSize/12, unitSize/4, unitSize/2);
  //        popMatrix();
  //      }
        
  //      //Draw pixel at LEFT
  //      fill(boxOffColour);
  //      if (environment.getTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.LEFT)) {
  //        fill(textColour);
  //        emissive(textColour);
  //        pushMatrix();
  //        translate(2, unitSize/4, 0);
  //        box(unitSize/12, unitSize/2, unitSize/4);
  //        popMatrix();
  //      }
  //    }
      
  //    emissive(0, 0, 0);
  //    shininess(0.0);

  //    // Draw wire
  //    if (!pixelColours && !rollingText) {
  //      fill(0, 255, 0);
  //      pushMatrix();
  //      if ((entryPixel == PIXEL.BOTTOM) || (exitPixel == PIXEL.BOTTOM)) {
  //        translate(2, 0, -unitSize/4);
  //        box(unitSize/12, unitSize/16, unitSize/2);
  //      }
  //      popMatrix();
  //      pushMatrix();
  //      if ((entryPixel == PIXEL.TOP) || (exitPixel == PIXEL.TOP)) {
  //        translate(2, 0, unitSize/4);
  //        box(unitSize/12, unitSize/16, unitSize/2);
  //      } 
  //      popMatrix();
  //      pushMatrix();
  //      if ((entryPixel == PIXEL.LEFT) || (exitPixel == PIXEL.LEFT)) {
  //        translate(2, unitSize/4, 0);
  //        box(unitSize/12, unitSize/2, unitSize/16);
  //      }
  //      popMatrix();
  //      pushMatrix();
  //      if ((entryPixel == PIXEL.RIGHT) || (exitPixel == PIXEL.RIGHT)) {
  //        translate(2, -unitSize/4, 0);
  //        box(unitSize/12, unitSize/2, unitSize/16);
  //      }
  //      popMatrix();
  //    }
  //  } else {
  //    box(unitSize);
  //  }
    
  //  popMatrix();
  //}
  
  void drawCell() {
    
    if (!isCellFacingDisplayedFacet()) {
      return;
    }
    
    //color boxColour = color(255, 0, 0, 50);
    color boxColour = color(40, 40, 40, 200);
    //color boxOffColour = color(230, 50, 190, 250);
    color boxOffColour = color(1.2*(x+3)/envXMaxUnits*230, 1.2*(y+3)/envYMaxUnits*50, 1.2*(envZMaxUnits-z+2)/envZMaxUnits*190, 255);
    color faceColour = color(150, 200, 100, 250);
    color textColour = color(50, 255, 255);
    
    color faceXColour = color(150, 0, 100, 255);
    color faceYColour = color(200, 200, 30, 255);
    color faceZColour = color(00, 200, 200, 255);
    
    color faceNorth = color(0,255,0);
    color faceEast = color(255,255,0);
    color faceSouth = color(255,0,0);
    color faceWest = color(0,255,255);
    color faceUp = color(255,0,255);
    color faceDown = color(0,0,255);
    
    color baseColour = color(255, 255, 255, 255); // base plates
    //color baseProjectedColour = color(100, 100, 100, 150); // base plates
    color baseProjectedColour = color(100, 100, 100, 0); // base plates
    
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
    
    if (displayBases) {
      if (solid) {
        pushMatrix();
        translate(0, 0, -z*unitSize-unitSize/2);
        if (z == 0) {
          fill(baseColour);
        } else {
          fill(baseProjectedColour);
        }
        box(unitSize, unitSize, 1);
        popMatrix();
      }
    } else if (solid && displayFaces) {
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
      
      if (defaultShapes) {
        box(unitSize/6, unitSize, unitSize/4);
        box(unitSize/6, unitSize/4, unitSize);
      } else {
        pushMatrix();
        translate(-unitSize/10, 0, 0);
        rotateZ(radians(180));
        drawShape(0);
        drawShape(90);
        drawShape(270);
        drawShape(180);
        popMatrix();
      }
      
      if (multipleText) {
        fill(0,0,0);  
      }else if (participatoryText) {
        fill(environment.getParticipativeTextRoller().getCurrentEntry().bgColor);  
      } else if (rollingText) {
        fill(boxOffColour);
        //shininess(5.0);
        //specular(255, 255, 255);
      } else if(setupInstallation) {
        if(front){
        if (orientation.x == 1) {
          fill(faceEast);
          fillPixelWithOneColour(faceEast);
        } else if (orientation.x == -1) {
          fill(faceWest);
          fillPixelWithOneColour(faceWest);
        } else if (orientation.y == -1) {
          fill(faceNorth);
          fillPixelWithOneColour(faceNorth);
        } else if (orientation.y == 1) {
          fill(faceSouth);
          fillPixelWithOneColour(faceSouth);
        } else if (orientation.z == 1) {
          fill(faceUp);
          fillPixelWithOneColour(faceUp);
        } else if (orientation.z == -1) {
          fill(faceDown);
          fillPixelWithOneColour(faceDown);
        }
        }
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
      
      if (defaultShapes) {
        translate(unitSize/6, 0, 0);
      }
       
      if (pixelColours) {
        fill(color(cos(second()*(z+1))*255, cos(second()*(x+1))*200, cos(second()*(y+1))*255));
        emissive(color(cos(second()*(z+1))*255, cos(second()*(x+1))*200, cos(second()*(y+1))*255));
      }
      if (defaultShapes) {
        box(unitSize/12, unitSize, unitSize/4);
      } else {
        drawShape(90);
        drawShape(270);
      }
     
      if (pixelColours) {
        fill(color(cos(second()*(y+1))*255, cos(second())*180, sin(second()*(y+1))*200));
        emissive(color(cos(second()*(y+1))*255, cos(second())*180, sin(second()*(y+1))*200));
      }
      if (defaultShapes) {
        box(unitSize/12, unitSize/4, unitSize);
      } else {
        drawShape(0);
        drawShape(180);
      }

      environment.getParticipativeTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.BOTTOM);
      
      if (participatoryText) {
        //Draw pixel at BOTTOM
        fill(0,0,0);
        emissive(0,0,0);
        if (environment.getParticipativeTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.BOTTOM)) {
          fill(environment.getParticipativeTextRoller().getCurrentEntry().textColor);
          emissive(environment.getParticipativeTextRoller().getCurrentEntry().textColor);
          pushMatrix();
          if (defaultShapes) {
            translate(2, 0, -unitSize/4);
            box(unitSize/12, unitSize/4, unitSize/2);
          } else {
            drawShape(0);
          }
//          scale(0.5);
          popMatrix();
        }
        //Draw pixel at RIGHT
        emissive(boxOffColour);
        if (environment.getParticipativeTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.RIGHT)) {
          fill(environment.getParticipativeTextRoller().getCurrentEntry().textColor);
          emissive(environment.getParticipativeTextRoller().getCurrentEntry().textColor);
          pushMatrix();
          if (defaultShapes) {
            translate(2, -unitSize/4, 0);
            box(unitSize/12, unitSize/2, unitSize/4);
          } else {
            drawShape(270);
          }
          popMatrix();
        }
        
        //Draw pixel at TOP
        emissive(boxOffColour);
        if (environment.getParticipativeTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.TOP)) {
          fill(environment.getParticipativeTextRoller().getCurrentEntry().textColor);
          emissive(environment.getParticipativeTextRoller().getCurrentEntry().textColor);
          pushMatrix();
          if (defaultShapes) {
            translate(2, 0, unitSize/4);
            box(unitSize/12, unitSize/4, unitSize/2);
          } else {
            drawShape(180);
          }
          popMatrix();
        }
        
        //Draw pixel at LEFT
        emissive(boxOffColour);
        if (environment.getParticipativeTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.LEFT)) {
          fill(environment.getParticipativeTextRoller().getCurrentEntry().textColor);
          emissive(environment.getParticipativeTextRoller().getCurrentEntry().textColor);
          pushMatrix();
          if (defaultShapes) {
            translate(2, unitSize/4, 0);
            box(unitSize/12, unitSize/2, unitSize/4);
          } else {
            drawShape(90);
          }
          popMatrix();
        }
      }
      
      if (rollingText) {
        //Draw pixel at BOTTOM
        fill(0,0,0);
        emissive(0,0,0);
        if (environment.getTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.BOTTOM)) {
          fill(textColour);
          emissive(textColour);
          pushMatrix();
          if (defaultShapes) {
            translate(2, 0, -unitSize/4);
            box(unitSize/12, unitSize/4, unitSize/2);
          } else {
            drawShape(0);
          }
//          scale(0.5);
          popMatrix();
        }
        //Draw pixel at RIGHT
        emissive(boxOffColour);
        if (environment.getTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.RIGHT)) {
          fill(textColour);
          emissive(textColour);
          pushMatrix();
          if (defaultShapes) {
            translate(2, -unitSize/4, 0);
            box(unitSize/12, unitSize/2, unitSize/4);
          } else {
            drawShape(270);
          }
          popMatrix();
        }
        
        //Draw pixel at TOP
        emissive(boxOffColour);
        if (environment.getTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.TOP)) {
          fill(textColour);
          emissive(textColour);
          pushMatrix();
          if (defaultShapes) {
            translate(2, 0, unitSize/4);
            box(unitSize/12, unitSize/4, unitSize/2);
          } else {
            drawShape(180);
          }
          popMatrix();
        }
        
        //Draw pixel at LEFT
        emissive(boxOffColour);
        if (environment.getTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.LEFT)) {
          fill(textColour);
          emissive(textColour);
          pushMatrix();
          if (defaultShapes) {
            translate(2, unitSize/4, 0);
            box(unitSize/12, unitSize/2, unitSize/4);
          } else {
            drawShape(90);
          }
          popMatrix();
        }
      }
      
      
      if (multipleText) {
        //Draw pixel at BOTTOM
        bottomCol = environment.getMultipleTextRoller().getBgColor(projCoord_i, projCoord_j, PIXEL.BOTTOM, facet);
        fill(bottomCol);
        emissive(environment.getMultipleTextRoller().getBgColor(projCoord_i, projCoord_j, PIXEL.BOTTOM, facet));
        if (environment.getMultipleTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.BOTTOM, facet) && front) {
          bottomCol = environment.getMultipleTextRoller().getTextColor(facet);
          fill(bottomCol);
          emissive(environment.getMultipleTextRoller().getTextColor(facet));
        }else if(environment.getMultipleTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.BOTTOM, facet) && !frontMode) {
          bottomCol = environment.getMultipleTextRoller().getTextColor(facet);
          fill(bottomCol);
          emissive(environment.getMultipleTextRoller().getTextColor(facet)); 
        }
          pushMatrix();
          if (defaultShapes) {
            translate(2, 0, -unitSize/4);
            box(unitSize/12, unitSize/4, unitSize/2);
          } else {
            drawShape(0);
          }
//          scale(0.5);
          popMatrix();
        
        //Draw pixel at RIGHT
        //emissive(boxOffColour);
        rightCol = environment.getMultipleTextRoller().getBgColor(projCoord_i, projCoord_j, PIXEL.RIGHT, facet);
        fill(rightCol);
        emissive(environment.getMultipleTextRoller().getBgColor(projCoord_i, projCoord_j, PIXEL.RIGHT, facet));
        if (environment.getMultipleTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.RIGHT, facet) && front) {
          rightCol = environment.getMultipleTextRoller().getTextColor(facet);
          fill(rightCol);
          emissive(environment.getMultipleTextRoller().getTextColor(facet));
        }else if (environment.getMultipleTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.RIGHT, facet) && !frontMode) {
          rightCol = environment.getMultipleTextRoller().getTextColor(facet);
          fill(rightCol);
          emissive(environment.getMultipleTextRoller().getTextColor(facet));
        }
          pushMatrix();
          if (defaultShapes) {
            translate(2, -unitSize/4, 0);
            box(unitSize/12, unitSize/2, unitSize/4);
          } else {
            drawShape(270);
          }
          popMatrix();
        
        
        //Draw pixel at TOP
        topCol = environment.getMultipleTextRoller().getBgColor(projCoord_i, projCoord_j, PIXEL.TOP, facet);
        fill(topCol);
        emissive(environment.getMultipleTextRoller().getBgColor(projCoord_i, projCoord_j, PIXEL.TOP, facet));        
        //emissive(boxOffColour);
        if (environment.getMultipleTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.TOP, facet) && front) {
          topCol = environment.getMultipleTextRoller().getTextColor(facet);
          fill(topCol);
          emissive(environment.getMultipleTextRoller().getTextColor(facet));
        } else if (environment.getMultipleTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.TOP, facet) && !frontMode) {
          topCol = environment.getMultipleTextRoller().getTextColor(facet);
          fill(topCol);
          emissive(environment.getMultipleTextRoller().getTextColor(facet));
        }
          pushMatrix();
          if (defaultShapes) {
            translate(2, 0, unitSize/4);
            box(unitSize/12, unitSize/4, unitSize/2);
          } else {
            drawShape(180);
          }
          popMatrix();
        
        
        //Draw pixel at LEFT
        leftCol = environment.getMultipleTextRoller().getBgColor(projCoord_i, projCoord_j, PIXEL.LEFT, facet);
        fill(leftCol);
        emissive(environment.getMultipleTextRoller().getBgColor(projCoord_i, projCoord_j, PIXEL.LEFT, facet));
        //emissive(boxOffColour);
        if (environment.getMultipleTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.LEFT, facet) && front) {
          leftCol = environment.getMultipleTextRoller().getTextColor(facet);
          fill(leftCol);
          emissive(environment.getMultipleTextRoller().getTextColor(facet));
        }else if (environment.getMultipleTextRoller().isPixelOn(projCoord_i, projCoord_j, PIXEL.TOP, facet) && !frontMode) {
          topCol = environment.getMultipleTextRoller().getTextColor(facet);
          fill(topCol);
          emissive(environment.getMultipleTextRoller().getTextColor(facet));
        }
          pushMatrix();
          if (defaultShapes) {
            translate(2, unitSize/4, 0);
            box(unitSize/12, unitSize/2, unitSize/4);
          } else {
            drawShape(90);
          }
          popMatrix();
        }
      


      
      if(animation && !runningSimulation){
        //Draw pixel at BOTTOM
        emissive(boxOffColour);
        color pixel = environment.getAnimation().getPixel(projCoord_i, projCoord_j, facet, PIXEL.BOTTOM);
        fill(pixel);
        emissive(pixel);
        pushMatrix();
        if (defaultShapes) {
          translate(2, 0, -unitSize/4);
          box(unitSize/12, unitSize/4, unitSize/2);
        } else {
          drawShape(0);
        }
        popMatrix();
        
        //Draw pixel at RIGHT
        emissive(boxOffColour);
        pixel = environment.getAnimation().getPixel(projCoord_i, projCoord_j, facet, PIXEL.RIGHT);
        fill(pixel);
        emissive(pixel);
        pushMatrix();
        if (defaultShapes) {
          translate(2, -unitSize/4, 0);
          box(unitSize/12, unitSize/2, unitSize/4);
        } else {
          drawShape(270);
        }
        popMatrix();
        
        //Draw pixel at TOP
        emissive(boxOffColour);
        pixel = environment.getAnimation().getPixel(projCoord_i, projCoord_j, facet, PIXEL.TOP);
        fill(pixel);
        emissive(pixel);
        pushMatrix();
        if (defaultShapes) {
          translate(2, 0, unitSize/4);
          box(unitSize/12, unitSize/4, unitSize/2);
        } else {
          drawShape(180);
        }
        popMatrix();   
        
        //Draw pixel at LEFT
        emissive(boxOffColour);
        pixel = environment.getAnimation().getPixel(projCoord_i, projCoord_j, facet, PIXEL.LEFT);
        fill(pixel);
        emissive(pixel);
        pushMatrix();
        if (defaultShapes) {
          translate(2, unitSize/4, 0);
          box(unitSize/12, unitSize/2, unitSize/4);
        } else {
          drawShape(90);
        }
        popMatrix();
        
        
      }
      
      emissive(0, 0, 0);
      shininess(0.0);

      // Draw wire
      if (!pixelColours && !rollingText && !animation && !participatoryText && !multipleText && !setupInstallation) {
        fill(0, 255, 0);
        pushMatrix();
        if ((entryPixel == PIXEL.BOTTOM) || (exitPixel == PIXEL.BOTTOM)) {
          if (defaultShapes) {
            translate(2, 0, -unitSize/4);
            box(unitSize/12, unitSize/16, unitSize/2);
          } else {
            drawShape(0);
          }
        }
        popMatrix();
        pushMatrix();
        if ((entryPixel == PIXEL.TOP) || (exitPixel == PIXEL.TOP)) {
          if (defaultShapes) {
            translate(2, 0, unitSize/4);
            box(unitSize/12, unitSize/16, unitSize/2);
          } else {
            drawShape(180);
          }
        } 
        popMatrix();
        pushMatrix();
        if ((entryPixel == PIXEL.LEFT) || (exitPixel == PIXEL.LEFT)) {
          if (defaultShapes) {
            translate(2, unitSize/4, 0);
            box(unitSize/12, unitSize/2, unitSize/16);
          } else {
            drawShape(90);
          }
        }
        popMatrix();
        pushMatrix();
        if ((entryPixel == PIXEL.RIGHT) || (exitPixel == PIXEL.RIGHT)) {
          if (defaultShapes) {
            translate(2, -unitSize/4, 0);
            box(unitSize/12, unitSize/2, unitSize/16);
          } else {
            drawShape(270);
          }
        }
        popMatrix();
      }
    } else {
      box(unitSize);
    }
    
    popMatrix();
  }
  
  void drawShape(int rotation) {
    int sides = 4;
    //int r0 = unitSize/20;
    //int r1 = unitSize/5;
    //int r2 = unitSize/7;
    //int h = unitSize/2;
    boolean half = true;
    pushMatrix();
    rotateX(radians(rotation));
    drawCylinder(sides, rr0, rr1, h/4, half);
    translate(0, 0, -h/4);
    drawCylinder(sides, rr1, rr2, 3*h/4, half);
    popMatrix();
  }
  
  void drawCylinder(int sides, float r1, float r2, float h, boolean half) {
      float angle = (360 / sides) + 90;
      if (half) {
        angle = angle/2;
      }

      // top
      beginShape();
      //for (int i = 0; i < sides; i++) {
      //    float x = cos( radians( i * angle ) ) * r1;
      //    float y = sin( radians( i * angle ) ) * r1;
      //    vertex( x, y, 0);
      //}
      // OPTIMISED CODE
      vertex(cos0 * r1, sin0 * r1, 0);
      vertex(cos90 * r1, sin90 * r1, 0);
      vertex(cos180 * r1, sin180 * r1, 0);
      vertex(cos270 * r1, sin270 * r1, 0);
      endShape(CLOSE);
      // bottom
      beginShape();
      //for (int i = 0; i < sides; i++) {
      //   float x = cos( radians( i * angle ) ) * r2;
      //   float y = sin( radians( i * angle ) ) * r2;
      //   vertex( x, y, -h);
      //}
      // OPTIMISED CODE
      vertex(cos0 * r2, sin0 * r2, -h);
      vertex(cos90 * r2, sin90 * r2, -h);
      vertex(cos180 * r2, sin180 * r2, -h);
      vertex(cos270 * r2, sin270 * r2, -h);
      endShape(CLOSE);
      // draw body
      beginShape(TRIANGLE_STRIP);
      //for (int i = 0; i < sides + 1; i++) {
      //  float x1 = cos( radians( i * angle ) ) * r1;
      //  float y1 = sin( radians( i * angle ) ) * r1;
      //  float x2 = cos( radians( i * angle ) ) * r2;
      //  float y2 = sin( radians( i * angle ) ) * r2;
      //  vertex( x1, y1, 0);
      //  vertex( x2, y2, -h);
      //}
      // OPTIMISED CODE
      float x1 = cos0 * r1;
      float y1 = sin0 * r1;
      float x2 = cos0 * r2;
      float y2 = sin0 * r2;
      vertex( x1, y1, 0);
      vertex( x2, y2, -h);
      
      x1 = cos90 * r1;
      y1 = sin90 * r1;
      x2 = cos90 * r2;
      y2 = sin90 * r2;
      vertex( x1, y1, 0);
      vertex( x2, y2, -h);
      
      x1 = cos180 * r1;
      y1 = sin180 * r1;
      x2 = cos180 * r2;
      y2 = sin180 * r2;
      vertex( x1, y1, 0);
      vertex( x2, y2, -h);
      
      x1 = cos270 * r1;
      y1 = sin270 * r1;
      x2 = cos270 * r2;
      y2 = sin270 * r2;
      vertex( x1, y1, 0);
      vertex( x2, y2, -h);
      
      x1 = cos360 * r1;
      y1 = sin360 * r1;
      x2 = cos360 * r2;
      y2 = sin360 * r2;
      vertex( x1, y1, 0);
      vertex( x2, y2, -h);
      
      endShape(CLOSE);
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
          || ((zok && abs(directions[index].z) == 1) && (z >= envZMaxUnitsPath-1) && !nearCompleted)) { // Ensures minimum height for walking 
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
  
  public void fillPixelWithOneColour(color c){
    topCol = c; 
    bottomCol = c; 
    leftCol = c; 
    rightCol = c;  
  }
  
}