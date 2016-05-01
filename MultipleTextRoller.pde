  public static enum TEXTROLLER_MODE {RANDOM, TIMESTAMP};

public class MultipleTextRoller {  
  
  private ParticipativeTextRoller[] textRollerList = new ParticipativeTextRoller[4];

  private TEXTROLLER_MODE mode = TEXTROLLER_MODE.RANDOM;
  private boolean transition;
  private float transitionCtr;
  private float TRANSITION = 5000;
  color c1, c2, c3, c4;
  private long lastSwitchTime;
  private int DURATION = 20000;
  private float BACKGROUND_BRIGHTNESS = 0.8;
  boolean simulationMode = true;
  boolean timeStampMode = true;
  boolean next;
  
  
  public MultipleTextRoller(){

    textRollerList[0] = new ParticipativeTextRoller(FACET.NORTH, 0);
    textRollerList[1] = new ParticipativeTextRoller(FACET.EAST, 0);
    textRollerList[2] = new ParticipativeTextRoller(FACET.SOUTH, 0);
    textRollerList[3] = new ParticipativeTextRoller(FACET.WEST, 0);
    
  }
  
  public void setMode(TEXTROLLER_MODE m){
    mode = m;
  }
  
  public boolean isPixelOn(int i, int j, PIXEL pixel, FACET facet){

    if(facet == FACET.NORTH){
       return textRollerList[0].isPixelOn(i, j, pixel);
    }else if(facet == FACET.SOUTH){
       return textRollerList[1].isPixelOn(i, j, pixel);      
    }else if(facet == FACET.EAST){
       return textRollerList[2].isPixelOn(i, j, pixel);
    }else if(facet == FACET.WEST){
       return textRollerList[3].isPixelOn(i, j, pixel);      
    }else if(facet == FACET.BOTTOM_UP){
      return false;
    }else if(facet == FACET.CEILING_DOWN){
       return false;      
    }
    return false;
    
  }
 
  
  public color getTextColor(FACET facet){
    
    if(facet == FACET.NORTH){
       return textRollerList[0].getCurrentEntry().textColor;
    }else if(facet == FACET.SOUTH){
       return textRollerList[1].getCurrentEntry().textColor;      
    }else if(facet == FACET.EAST){
       return textRollerList[2].getCurrentEntry().textColor;      
    }else if(facet == FACET.WEST){
       return textRollerList[3].getCurrentEntry().textColor;      
    }else if(facet == FACET.BOTTOM_UP){
      return 0;
    }else if(facet == FACET.CEILING_DOWN){
       return textRollerList[4].getCurrentEntry().textColor;      
    } 
    return 0;
  }
  
  public color getBgColor(FACET facet){
    
    //environment.matrix[0][0][0] = Cell;
    
    if(facet == FACET.NORTH){
       return lerpColor(textRollerList[0].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
    }else if(facet == FACET.SOUTH){
       return lerpColor(textRollerList[1].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.EAST){
       return lerpColor(textRollerList[2].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.WEST){
       return lerpColor(textRollerList[3].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.BOTTOM_UP){
      return color(255,255,255);
    }else if(facet == FACET.CEILING_DOWN){
      return color(255,255,255);      
    } 
    return 0;
  }
  
  public color getBgColor(FACET facet, FACET f2){
    
    //environment.matrix[0][0][0] = Cell;
    
    if(facet == FACET.NORTH){
       return lerpColor(textRollerList[0].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
    }else if(facet == FACET.SOUTH){
       return lerpColor(textRollerList[1].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.EAST){
       return lerpColor(textRollerList[2].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.WEST){
       return lerpColor(textRollerList[3].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.BOTTOM_UP){
      if(f2 == FACET.NORTH){
        return lerpColor(textRollerList[0].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }else if(f2 == FACET.SOUTH){
        return lerpColor(textRollerList[1].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }else if(f2 == FACET.EAST){
        return lerpColor(textRollerList[2].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }else if(f2 == FACET.WEST){
        return lerpColor(textRollerList[3].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }
    }else if(facet == FACET.CEILING_DOWN){
      if(f2 == FACET.NORTH){
        return lerpColor(textRollerList[0].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }else if(f2 == FACET.SOUTH){
        return lerpColor(textRollerList[1].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }else if(f2 == FACET.EAST){
        return lerpColor(textRollerList[2].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }else if(f2 == FACET.WEST){
        return lerpColor(textRollerList[3].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }
    } 
    return 0;
  }
  
  public color getNextBgColor(FACET facet){
    
    if(facet == FACET.NORTH){
       return lerpColor(textRollerList[0].getNextEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
    }else if(facet == FACET.SOUTH){
       return lerpColor(textRollerList[1].getNextEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.EAST){
       return lerpColor(textRollerList[2].getNextEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.WEST){
       return lerpColor(textRollerList[3].getNextEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.BOTTOM_UP){
      return 0;
    }else if(facet == FACET.CEILING_DOWN){
      return 0;      
    } 
    return 0;
    
  }
  
  
  public color getNextBgColor(FACET facet, FACET f2){
    
    if(facet == FACET.NORTH){
       return lerpColor(textRollerList[0].getNextEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
    }else if(facet == FACET.SOUTH){
       return lerpColor(textRollerList[1].getNextEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.EAST){
       return lerpColor(textRollerList[2].getNextEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.WEST){
       return lerpColor(textRollerList[3].getNextEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.BOTTOM_UP){
      
      if(f2 == FACET.NORTH){
        return lerpColor(textRollerList[0].getNextEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }else if(f2 == FACET.SOUTH){
        return lerpColor(textRollerList[1].getNextEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }else if(f2 == FACET.EAST){
        return lerpColor(textRollerList[2].getNextEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }else if(f2 == FACET.WEST){
        return lerpColor(textRollerList[3].getNextEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }
      
    }else if(facet == FACET.CEILING_DOWN){

      if(f2 == FACET.NORTH){
        return lerpColor(textRollerList[0].getNextEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }else if(f2 == FACET.SOUTH){
        return lerpColor(textRollerList[1].getNextEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }else if(f2 == FACET.EAST){
        return lerpColor(textRollerList[2].getNextEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }else if(f2 == FACET.WEST){
        return lerpColor(textRollerList[3].getNextEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }
    
    } 
    return 0;
    
  }
    
  
  public void rollText(){
    
   if(mode==TEXTROLLER_MODE.RANDOM){
      
      if(millis()-lastSwitchTime >= DURATION){
        lastSwitchTime = millis(); 
        transition = true;
        transitionCtr = millis();
        for(int i=0; i<4; i++){
          textRollerList[i].prepareRandomEntry(); 
        }
      }
      
      for(int i=0; i<4; i++){
        textRollerList[i].rollText(); 
      }
      
      if(transition){
        if(millis()-transitionCtr > TRANSITION){      
          transition = false; 
          //println("nextEntry");
          for(int i=0; i<4; i++){
            textRollerList[i].nextEntry(); 
          }
        }
      }
      
    }else if(mode==TEXTROLLER_MODE.TIMESTAMP){
     
      Date d = new Date();
      long current=d.getTime()/1000;
      
      if(simulationMode){
        current = current - (timeStampStart-1462031990);
      }
       
      next = false;
      
      for(int i=0; i<4; i++){   
        if(current >= textRollerList[i].getLastEntry().timeStamp){
          timeStampMode = false;  
        }
        if(timeStampMode){
          if(current >= textRollerList[i].getNextEntry().timeStamp){
            do{
              next = true;
              textRollerList[i].prepareNextEntry();
            }while(current >= textRollerList[i].getNextEntry().timeStamp);
          }
        }
      }
      
      if(!timeStampMode){
          //println("time-stamp mode false");
          if(millis()-lastSwitchTime >= DURATION){
            lastSwitchTime = millis(); 
            next = true;
            transitionCtr = millis();
            textRollerList[0].prepareRandomEntry(); 
            textRollerList[1].prepareRandomEntry(); 
            textRollerList[2].prepareRandomEntry(); 
            textRollerList[3].prepareRandomEntry();
          }  
      }
      
      if(next){ 
        //println("Next");
        next = false;
        transition = true;
        lastSwitchTime = millis(); 
        transition = true;
        transitionCtr = millis();
      }
      
      for(int i=0; i<4; i++){
        textRollerList[i].rollText(); 
      }
      
      if(transition){
        if(millis()-transitionCtr > TRANSITION){      
          transition = false; 
          //println("nextEntry");
          for(int i=0; i<4; i++){
            textRollerList[i].nextEntry(); 
          }
        }
      }  
    }
  }
  
  public void switchEntry(){
    //if(mode==TEXTROLLER_MODE.RANDOM){
      lastSwitchTime = millis(); 
      transition = true;
      transitionCtr = millis();
      textRollerList[0].prepareRandomEntry(); 
      textRollerList[1].prepareRandomEntry(); 
      textRollerList[2].prepareRandomEntry(); 
      textRollerList[3].prepareRandomEntry();
    //}
  }
  
  public boolean isTransition(){
    return transition;
  }
  
  public float transitionProgress(){
    return (millis()-transitionCtr)/TRANSITION;
  }
   
}