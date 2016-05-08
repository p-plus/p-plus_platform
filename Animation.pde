public class Animation {
  
  ArrayList<PGraphics> pgList;
  PImage pgNorth, pgSouth, pgEast, pgWest, pgBottomUp, pgCeilingDown;
  PImage imgNorth, imgSouth, imgEast, imgWest, imgBottomUp, imgCeilingDown;
  

  public void addGraphics(FACET f, PGraphics pg){
  
    switch(f) {
      case ALL:
      
      case NORTH:
        pgNorth = pg;
        break;
      case SOUTH:
        pgSouth = pg;
        break;
      case EAST:
        pgEast = pg;
        break;        
      case WEST:
        pgWest = pg;     
        break;        
      case BOTTOM_UP:
        pgBottomUp = pg;      
        break;
      case CEILING_DOWN:
        pgCeilingDown = pg;  
        break;        
      
    }
  }
 
  
  public void resizeAnimation(){
   
   imgNorth = pgNorth.get();
   imgNorth.resize(envXMaxUnits*3, envZMaxUnits*3);
   
   imgSouth = pgSouth.get();
   imgSouth.resize(envXMaxUnits*3, envZMaxUnits*3);
   
   imgEast = pgEast.get();
   imgEast.resize(envYMaxUnits*3, envZMaxUnits*3);
   
   imgWest = pgWest.get();
   imgWest.resize(envYMaxUnits*3, envZMaxUnits*3);
   
   imgBottomUp = pgBottomUp.get();
   imgBottomUp.resize(envXMaxUnits*3, envYMaxUnits*3);
   
   imgCeilingDown = pgCeilingDown.get();
   imgCeilingDown.resize(envXMaxUnits*3, envYMaxUnits*3);
   
  }
  
  public color getPixel(int i, int j, FACET f, PIXEL pixel){
    color c = color(255,255,255);
    
    switch(f) {
      case NORTH:
        if(pixel == PIXEL.BOTTOM){
          //println("getpixel: "+i*3+1+" "+3*j);
          c = imgNorth.get(i*3+1,((envZMaxUnits-1)*3)-3*j);
          //c = pg.pixels[(i*3+1)*pg.width+3*j];
        }else if(pixel == PIXEL.RIGHT){
          c = imgNorth.get(i*3+2,((envZMaxUnits-1)*3)-3*j+1);
          //c = pg.pixels[(i*3+2)*pg.width+3*j+1];
        }else if(pixel == PIXEL.TOP){
          c = imgNorth.get(i*3+1,((envZMaxUnits-1)*3)-3*j+2);
          //c = pg.pixels[(i*3+1)*pg.width+3*j+2];
        }else if(pixel == PIXEL.LEFT){
          c = imgNorth.get(i*3,((envZMaxUnits-1)*3)-3*j+1);
          //c = pg.pixels[i*3*pg.width+3*j+1];
        }
        break;
      case SOUTH:
        if(pixel == PIXEL.BOTTOM){
          //println("getpixel: "+i*3+1+" "+3*j);
          c = imgSouth.get(i*3+1,((envZMaxUnits-1)*3)-3*j);
          //c = pg.pixels[(i*3+1)*pg.width+3*j];
        }else if(pixel == PIXEL.RIGHT){
          c = imgSouth.get(i*3+2,((envZMaxUnits-1)*3)-3*j+1);
          //c = pg.pixels[(i*3+2)*pg.width+3*j+1];
        }else if(pixel == PIXEL.TOP){
          c = imgSouth.get(i*3+1,((envZMaxUnits-1)*3)-3*j+2);
          //c = pg.pixels[(i*3+1)*pg.width+3*j+2];
        }else if(pixel == PIXEL.LEFT){
          c = imgSouth.get(i*3,((envZMaxUnits-1)*3)-3*j+1);
          //c = pg.pixels[i*3*pg.width+3*j+1];
        }
        break;        
      case EAST:
        if(pixel == PIXEL.BOTTOM){
          //println("getpixel: "+i*3+1+" "+3*j);
          c = imgEast.get(i*3+1,((envZMaxUnits-1)*3)-3*j);
          //c = pg.pixels[(i*3+1)*pg.width+3*j];
        }else if(pixel == PIXEL.RIGHT){
          c = imgEast.get(i*3+2,((envZMaxUnits-1)*3)-3*j+1);
          //c = pg.pixels[(i*3+2)*pg.width+3*j+1];
        }else if(pixel == PIXEL.TOP){
          c = imgEast.get(i*3+1,((envZMaxUnits-1)*3)-3*j+2);
          //c = pg.pixels[(i*3+1)*pg.width+3*j+2];
        }else if(pixel == PIXEL.LEFT){
          c = imgEast.get(i*3,((envZMaxUnits-1)*3)-3*j+1);
          //c = pg.pixels[i*3*pg.width+3*j+1];
        }
        break;
      case WEST:
        if(pixel == PIXEL.BOTTOM){
          //println("getpixel: "+i*3+1+" "+3*j);
          c = imgWest.get(i*3+1,((envZMaxUnits-1)*3)-3*j);
          //c = pg.pixels[(i*3+1)*pg.width+3*j];
        }else if(pixel == PIXEL.RIGHT){
          c = imgWest.get(i*3+2,((envZMaxUnits-1)*3)-3*j+1);
          //c = pg.pixels[(i*3+2)*pg.width+3*j+1];
        }else if(pixel == PIXEL.TOP){
          c = imgWest.get(i*3+1,((envZMaxUnits-1)*3)-3*j+2);
          //c = pg.pixels[(i*3+1)*pg.width+3*j+2];
        }else if(pixel == PIXEL.LEFT){
          c = imgWest.get(i*3,((envZMaxUnits-1)*3)-3*j+1);
          //c = pg.pixels[i*3*pg.width+3*j+1];
        }
        break;
        case BOTTOM_UP:
        if(pixel == PIXEL.BOTTOM){
          //println("getpixel: "+i*3+1+" "+3*j);
          c = imgBottomUp.get(i*3+1,((envYMaxUnits-1)*3)-3*j);
          //c = pg.pixels[(i*3+1)*pg.width+3*j];
        }else if(pixel == PIXEL.RIGHT){
          c = imgBottomUp.get(i*3+2,((envYMaxUnits-1)*3)-3*j+1);
          //c = pg.pixels[(i*3+2)*pg.width+3*j+1];
        }else if(pixel == PIXEL.TOP){
          c = imgBottomUp.get(i*3+1,((envYMaxUnits-1)*3)-3*j+2);
          //c = pg.pixels[(i*3+1)*pg.width+3*j+2];
        }else if(pixel == PIXEL.LEFT){
          c = imgBottomUp.get(i*3,((envYMaxUnits-1)*3)-3*j+1);
          //c = pg.pixels[i*3*pg.width+3*j+1];
        }
        break;
        case CEILING_DOWN:
        if(pixel == PIXEL.BOTTOM){
          //println("getpixel: "+i*3+1+" "+3*j);
          c = imgCeilingDown.get(i*3+1,((envYMaxUnits-1)*3)-3*j);
          //c = pg.pixels[(i*3+1)*pg.width+3*j];
        }else if(pixel == PIXEL.RIGHT){
          c = imgCeilingDown.get(i*3+2,((envYMaxUnits-1)*3)-3*j+1);
          //c = pg.pixels[(i*3+2)*pg.width+3*j+1];
        }else if(pixel == PIXEL.TOP){
          c = imgCeilingDown.get(i*3+1,((envYMaxUnits-1)*3)-3*j+2);
          //c = pg.pixels[(i*3+1)*pg.width+3*j+2];
        }else if(pixel == PIXEL.LEFT){
          c = imgCeilingDown.get(i*3,((envYMaxUnits-1)*3)-3*j+1);
          //c = pg.pixels[i*3*pg.width+3*j+1];
        }
        //pgList.get(0).endDraw();
        break;
    }
    
    return c;  
  }
  
  
  
  
}