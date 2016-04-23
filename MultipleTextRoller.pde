public class MultipleTextRoller {
  
  private ParticipativeTextRoller[] textRollerList = new ParticipativeTextRoller[5];
  private int mode = 2;
  private boolean transition, transition_c1, transition_c2;
  private float transitionCtr, transitionCtr_c1, transitionCtr_c2;
  private float TRANSITION = 5000;
  private float TRANSITION_DURATION = 25.0;
  private float TRANSITION_STEPS = 60.0;
  private int time_c1, time_c2;
  color c1, c2, c3, c4;
  private long lastSwitchTime;
  private int DURATION = 10000;
  private float BACKGROUND_BRIGHTNESS = 0.3;
  
  
  public MultipleTextRoller(ArrayList<Entry> entriesList){
    // Create text roller
    
    for(int i=0; i<5; i++){
      textRollerList[i] = new ParticipativeTextRoller(entriesList);
    }

  }
  
  public void setMode(){
    
  }
  
  public boolean isPixelOn(int i, int j, PIXEL pixel, FACET facet){
    
    if(mode == 0){
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
         return textRollerList[4].isPixelOn(i, j, pixel);      
      } 
    }else if(mode == 1){
      if(facet == FACET.NORTH){
         return textRollerList[0].isPixelOn(i, j, pixel);
      }else if(facet == FACET.SOUTH){
         return textRollerList[1].isPixelOn(i, j, pixel);      
      }else if(facet == FACET.EAST){
         return false;      
      }else if(facet == FACET.WEST){
         return false;      
      }else if(facet == FACET.BOTTOM_UP){
        return false;
      }else if(facet == FACET.CEILING_DOWN){
         return false;      
      }      
    }else if(mode == 2){
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
  
  
  
  public color getPreviousTextColor(FACET facet){
    
    if(facet == FACET.NORTH){
       return textRollerList[0].getPreviousEntry().textColor;
    }else if(facet == FACET.SOUTH){
       return textRollerList[1].getPreviousEntry().textColor;      
    }else if(facet == FACET.EAST){
       return textRollerList[2].getPreviousEntry().textColor;      
    }else if(facet == FACET.WEST){
       return textRollerList[3].getPreviousEntry().textColor;      
    }else if(facet == FACET.BOTTOM_UP){
      return 0;
    }else if(facet == FACET.CEILING_DOWN){
       return textRollerList[4].getPreviousEntry().textColor;      
    } 
    return 0;
  }
  
  
  
  
  public color getBgColor(int i, int j, PIXEL pixel, FACET facet){
        
    if(mode==0){
      if(facet == FACET.NORTH){
        return textRollerList[0].getCurrentEntry().bgColor;
      }else if(facet == FACET.SOUTH){
        return textRollerList[1].getCurrentEntry().bgColor;      
      }else if(facet == FACET.EAST){
        return textRollerList[2].getCurrentEntry().bgColor;      
      }else if(facet == FACET.WEST){
        return textRollerList[3].getCurrentEntry().bgColor;      
      }else if(facet == FACET.BOTTOM_UP){
        return 0;
      }else if(facet == FACET.CEILING_DOWN){
        return textRollerList[4].getCurrentEntry().bgColor;      
      } 
      return 0;  
    }else if(mode==1){
      
      if(facet == FACET.NORTH){
        return lerpColor(c1, color(0,0,0),(0.5*(abs(sin(((frameCount)/350.0))))*(j)));
      }else if(facet == FACET.SOUTH){
        return c2;      
      }else if(facet == FACET.EAST){
        if(pixel == PIXEL.TOP){
          return lerpColor(c2, c1, (((1.0/envXMaxUnits)*i)+(1.0/(2.0*envXMaxUnits))));  
        }else if(pixel == PIXEL.BOTTOM){
          return lerpColor(c2, c1, (((1.0/envXMaxUnits)*i)+(1.0/(2.0*envXMaxUnits))));   
        }else if(pixel == PIXEL.RIGHT){
          return lerpColor(c2, c1, ((1.0/envXMaxUnits)*i)+(1.0/(3.0*envXMaxUnits))); 
        }else if(pixel == PIXEL.LEFT){
           return lerpColor(c2, c1, ((1.0/envXMaxUnits)*i)); 
        }
      }else if(facet == FACET.WEST){
        if(pixel == PIXEL.TOP){
          return lerpColor(c1, c2, (((1.0/envXMaxUnits)*i)+(1.0/(2.0*envXMaxUnits))));  
        }else if(pixel == PIXEL.BOTTOM){
          return lerpColor(c1, c2, (((1.0/envXMaxUnits)*i)+(1.0/(2.0*envXMaxUnits))));   
        }else if(pixel == PIXEL.RIGHT){
          return lerpColor(c1, c2, ((1.0/envXMaxUnits)*i)+(1.0/(3.0*envXMaxUnits))); 
        }else if(pixel == PIXEL.LEFT){
           return lerpColor(c1, c2, ((1.0/envXMaxUnits)*i)); 
        }     
      }else if(facet == FACET.BOTTOM_UP){
        if(pixel == PIXEL.TOP){
          return lerpColor(c2, c1, (((1.0/envXMaxUnits)*i)+(1.0/(2.0*envXMaxUnits))));  
        }else if(pixel == PIXEL.BOTTOM){
          return lerpColor(c2, c1, (((1.0/envXMaxUnits)*i)+(1.0/(2.0*envXMaxUnits))));   
        }else if(pixel == PIXEL.RIGHT){
          return lerpColor(c2, c1, ((1.0/envXMaxUnits)*i)+(1.0/(3.0*envXMaxUnits))); 
        }else if(pixel == PIXEL.LEFT){
          return lerpColor(c2, c1, ((1.0/envXMaxUnits)*i)); 
        }
      }else if(facet == FACET.CEILING_DOWN){
        if(pixel == PIXEL.TOP){
          return lerpColor(c2, c1, (((1.0/envXMaxUnits)*i)+(1.0/(2.0*envXMaxUnits))));  
        }else if(pixel == PIXEL.BOTTOM){
          return lerpColor(c2, c1, (((1.0/envXMaxUnits)*i)+(1.0/(2.0*envXMaxUnits))));   
        }else if(pixel == PIXEL.RIGHT){
          return lerpColor(c2, c1, ((1.0/envXMaxUnits)*i)+(1.0/(3.0*envXMaxUnits))); 
        }else if(pixel == PIXEL.LEFT){
           return lerpColor(c2, c1, ((1.0/envXMaxUnits)*i)); 
        }
        //return textRollerList[4].bgColor;      
      } 
    }else if(mode==2){
      if(facet == FACET.NORTH){
        return lerpColor(textRollerList[0].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
      }else if(facet == FACET.SOUTH){
        return lerpColor(textRollerList[1].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
      }else if(facet == FACET.EAST){
        return lerpColor(textRollerList[2].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
      }else if(facet == FACET.WEST){
        return lerpColor(textRollerList[3].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
      }else if(facet == FACET.BOTTOM_UP){
        return 0;
      }else if(facet == FACET.CEILING_DOWN){
        return 0;      
      } 
      return 0;  
    }
      return 0;
  }
  
  public color getBgColor(FACET facet){
    
    if(facet == FACET.NORTH){
       return lerpColor(textRollerList[0].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
    }else if(facet == FACET.SOUTH){
       return lerpColor(textRollerList[1].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.EAST){
       return lerpColor(textRollerList[2].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.WEST){
       return lerpColor(textRollerList[3].getCurrentEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.BOTTOM_UP){
      return 0;
    }else if(facet == FACET.CEILING_DOWN){
      return 0;      
    } 
    return 0;
  }
  
  
  
  public color getPreviousBgColor(FACET facet){
    
    if(facet == FACET.NORTH){
       return lerpColor(textRollerList[0].getPreviousEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);
    }else if(facet == FACET.SOUTH){
       return lerpColor(textRollerList[1].getPreviousEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.EAST){
       return lerpColor(textRollerList[2].getPreviousEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.WEST){
       return lerpColor(textRollerList[3].getPreviousEntry().bgColor, color(0,0,0), BACKGROUND_BRIGHTNESS);      
    }else if(facet == FACET.BOTTOM_UP){
      return 0;
    }else if(facet == FACET.CEILING_DOWN){
      return 0;      
    } 
    return 0;
  }
  
  
  
  
  public void rollText(){
    
    if(mode==0){
      for(int i=0; i<textRollerList.length; i++){
        textRollerList[i].rollText();  
      }
    }else if(mode==1){
      textRollerList[0].rollText(); 
      textRollerList[1].rollText(); 
      if(textRollerList[0].getLoopCounter() >= TEXT_ROLLER_LOOPS){
      textRollerList[0].randomEntry(); 
      transition_c1 = true;
      }
      if(textRollerList[1].getLoopCounter() >= TEXT_ROLLER_LOOPS){
      textRollerList[1].randomEntry();         
      transition_c2 = true;
      };
    
      c1 = textRollerList[0].getCurrentEntry().bgColor;
      c2 = textRollerList[1].getCurrentEntry().bgColor;
      
      if(transition_c1){
        //println("transition: "+transitionCtr);
        color zc1 = c1;
        
        c1 = lerpColor(textRollerList[0].getPreviousEntry().bgColor, zc1, transitionCtr_c1);
        
        if(transitionCtr_c1<1){
          if(millis() > time_c1 + (TRANSITION_DURATION/TRANSITION_STEPS)){
            //println(millis());
            time_c1 = millis();
            transitionCtr_c1 += 1.0/TRANSITION_STEPS;
          }
        }else{
          transitionCtr_c1 = 0;
          transition_c1 = false;
        }
      }
    
      if(transition_c2){
        //println("transition: "+transitionCtr);
        color zc2 = c2;
        
        c2 = lerpColor(textRollerList[1].getPreviousEntry().bgColor, zc2, transitionCtr_c2);
        
        if(transitionCtr_c2<1){
          if(millis() > time_c2 + (TRANSITION_DURATION/TRANSITION_STEPS)){
            //println(millis());
            time_c2 = millis();
            transitionCtr_c2 += 1.0/TRANSITION_STEPS;
          }
        }else{
          transitionCtr_c2 = 0;
          transition_c2 = false;
        }  
       }
    }else if(mode==2){
      
      textRollerList[0].rollText(); 
      textRollerList[1].rollText();
      textRollerList[2].rollText(); 
      textRollerList[3].rollText(); 
      
      if(millis()-lastSwitchTime >= DURATION){
        lastSwitchTime = millis(); 
        transition = true;
        transitionCtr = millis();
        textRollerList[0].randomEntry(); 
        textRollerList[1].randomEntry(); 
        textRollerList[2].randomEntry(); 
        textRollerList[3].randomEntry();
      }
      
      if(transition){
        
        if(millis()-transitionCtr < TRANSITION){
       
          //c1 = lerpColor(textRollerList[0].getPreviousEntry().bgColor, color(0,0,0), (millis()-transitionCtr)/TRANSITION); 
          //c2 = lerpColor(textRollerList[1].getPreviousEntry().bgColor, color(0,0,0), (millis()-transitionCtr)/TRANSITION); 
          //c3 = lerpColor(textRollerList[2].getPreviousEntry().bgColor, color(0,0,0), (millis()-transitionCtr)/TRANSITION);
          //c4 = lerpColor(textRollerList[3].getPreviousEntry().bgColor, color(0,0,0), (millis()-transitionCtr)/TRANSITION);  
             
        }else{
          transition = false; 
          //c1 = textRollerList[0].getCurrentEntry().bgColor;
          //c2 = textRollerList[1].getCurrentEntry().bgColor;
          //c3 = textRollerList[2].getCurrentEntry().bgColor;
          //c4 = textRollerList[3].getCurrentEntry().bgColor;
        }
        
      }
      
      
    }
  }
  
  public boolean isTransition(){
    return transition;
  }
  
  public float transitionProgress(){
    return (millis()-transitionCtr)/TRANSITION;
  }
  
  /*public void nextEntry() {
    if(counter<entriesList.size()-1){
      counter++;
    }else {
      counter=0;
    }
    
    //println(counter+" "+entriesList.size());

    if ((entriesList != null) && !entriesList.isEmpty()) {
      super.setText(entriesList.get(counter).message);
      bgColor = entriesList.get(counter).bgcolor;
      textColor = entriesList.get(counter).textcolor;
    }
  }
  
  public void rollText(){
    
    super.rollText();
    if(super.getLoopCounter()>=TEXT_ROLLER_LOOPS){
      nextEntry();
    }
    
    for(int i=0; i<textRollerList.length; i++){
      TextRoller tR = textRollerList[i];
      tR.rollText();
      if(tR.getLoopCounter()>=TEXT_ROLLER_LOOPS){
        int randomNumber = (int)random(0, entriesList.size()-1);
        tR.setText(entriesList.get(randomNumber).message);
        bgColor[i] = entriesList.get(randomNumber).bgcolor;
        textColor[i] = entriesList.get(randomNumber).bgcolor;
      }  
    }
  }
  
  public color getBgColor(FACET facet){
       
    color rgb = 0;
    if(facet == FACET.NORTH){
      rgb = bgColor[0];
    }else if(facet == FACET.SOUTH){
      rgb = bgColor[1];
    }else if(facet == FACET.EAST){
      rgb = bgColor[2];  
    }else if(facet == FACET.WEST){
      rgb = bgColor[3];  
    }else if(facet == FACET.BOTTOM_UP){
      rgb = bgColor[4];   
    }
    return rgb;
  }
  
  public color getTextColor(FACET facet){
       
    color rgb = 0;
    if(facet == FACET.NORTH){
      rgb = textColor[0];
    }else if(facet == FACET.SOUTH){
      rgb = textColor[1];
    }else if(facet == FACET.EAST){
      rgb = textColor[2];  
    }else if(facet == FACET.WEST){
      rgb = textColor[3];  
    }else if(facet == FACET.BOTTOM_UP){
      rgb = textColor[4];   
    }
    return rgb;
  }*/
  
  
}