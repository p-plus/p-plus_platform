public class MultipleTextRoller {
  
  private ParticipativeTextRoller[] textRollerList = new ParticipativeTextRoller[5];
  private int mode = 1;
  
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
    }
    return false;
  }
  
  public color getTextColor(FACET facet){
    
    if(facet == FACET.NORTH){
       return textRollerList[0].textColor;
    }else if(facet == FACET.SOUTH){
       return textRollerList[1].textColor;      
    }else if(facet == FACET.EAST){
       return textRollerList[2].textColor;      
    }else if(facet == FACET.WEST){
       return textRollerList[3].textColor;      
    }else if(facet == FACET.BOTTOM_UP){
      return 0;
    }else if(facet == FACET.CEILING_DOWN){
       return textRollerList[4].textColor;      
    } 
    return 0;
  }
  
  public color getBgColor(int i, int j, PIXEL pixel, FACET facet){
    
    if(mode==0){
      if(facet == FACET.NORTH){
        return textRollerList[0].bgColor;
      }else if(facet == FACET.SOUTH){
        return textRollerList[1].bgColor;      
      }else if(facet == FACET.EAST){
        return textRollerList[2].bgColor;      
      }else if(facet == FACET.WEST){
        return textRollerList[3].bgColor;      
      }else if(facet == FACET.BOTTOM_UP){
        return 0;
      }else if(facet == FACET.CEILING_DOWN){
        return textRollerList[4].bgColor;      
      } 
      return 0;  
    }else if(mode==1)
      if(facet == FACET.NORTH){
        return textRollerList[0].bgColor;
      }else if(facet == FACET.SOUTH){
        return textRollerList[1].bgColor;      
      }else if(facet == FACET.EAST){
        if(pixel == PIXEL.TOP){
          return lerpColor(textRollerList[1].bgColor, textRollerList[0].bgColor, (((1.0/envXMaxUnits)*i)+(1.0/(2.0*envXMaxUnits))));  
        }else if(pixel == PIXEL.BOTTOM){
          return lerpColor(textRollerList[1].bgColor, textRollerList[0].bgColor, (((1.0/envXMaxUnits)*i)+(1.0/(2.0*envXMaxUnits))));   
        }else if(pixel == PIXEL.RIGHT){
          return lerpColor(textRollerList[1].bgColor, textRollerList[0].bgColor, ((1.0/envXMaxUnits)*i)+(1.0/(3.0*envXMaxUnits))); 
        }else if(pixel == PIXEL.LEFT){
           return lerpColor(textRollerList[1].bgColor, textRollerList[0].bgColor, ((1.0/envXMaxUnits)*i)); 
        }
      }else if(facet == FACET.WEST){
        if(pixel == PIXEL.TOP){
          return lerpColor(textRollerList[0].bgColor, textRollerList[1].bgColor, (((1.0/envXMaxUnits)*i)+(1.0/(2.0*envXMaxUnits))));  
        }else if(pixel == PIXEL.BOTTOM){
          return lerpColor(textRollerList[0].bgColor, textRollerList[1].bgColor, (((1.0/envXMaxUnits)*i)+(1.0/(2.0*envXMaxUnits))));   
        }else if(pixel == PIXEL.RIGHT){
          return lerpColor(textRollerList[0].bgColor, textRollerList[1].bgColor, ((1.0/envXMaxUnits)*i)+(1.0/(3.0*envXMaxUnits))); 
        }else if(pixel == PIXEL.LEFT){
           return lerpColor(textRollerList[0].bgColor, textRollerList[1].bgColor, ((1.0/envXMaxUnits)*i)); 
        }     
      }else if(facet == FACET.BOTTOM_UP){
        if(pixel == PIXEL.TOP){
          return lerpColor(textRollerList[1].bgColor, textRollerList[0].bgColor, (((1.0/envXMaxUnits)*i)+(1.0/(2.0*envXMaxUnits))));  
        }else if(pixel == PIXEL.BOTTOM){
          return lerpColor(textRollerList[1].bgColor, textRollerList[0].bgColor, (((1.0/envXMaxUnits)*i)+(1.0/(2.0*envXMaxUnits))));   
        }else if(pixel == PIXEL.RIGHT){
          return lerpColor(textRollerList[1].bgColor, textRollerList[0].bgColor, ((1.0/envXMaxUnits)*i)+(1.0/(3.0*envXMaxUnits))); 
        }else if(pixel == PIXEL.LEFT){
          return lerpColor(textRollerList[1].bgColor, textRollerList[0].bgColor, ((1.0/envXMaxUnits)*i)); 
        }
      }else if(facet == FACET.CEILING_DOWN){
        if(pixel == PIXEL.TOP){
          return lerpColor(textRollerList[1].bgColor, textRollerList[0].bgColor, (((1.0/envXMaxUnits)*i)+(1.0/(2.0*envXMaxUnits))));  
        }else if(pixel == PIXEL.BOTTOM){
          return lerpColor(textRollerList[1].bgColor, textRollerList[0].bgColor, (((1.0/envXMaxUnits)*i)+(1.0/(2.0*envXMaxUnits))));   
        }else if(pixel == PIXEL.RIGHT){
          return lerpColor(textRollerList[1].bgColor, textRollerList[0].bgColor, ((1.0/envXMaxUnits)*i)+(1.0/(3.0*envXMaxUnits))); 
        }else if(pixel == PIXEL.LEFT){
           return lerpColor(textRollerList[1].bgColor, textRollerList[0].bgColor, ((1.0/envXMaxUnits)*i)); 
        }
        //return textRollerList[4].bgColor;      
      } 
      return 0;
  }
  
  public color getBgColor(FACET facet){
    
    if(facet == FACET.NORTH){
       return textRollerList[0].bgColor;
    }else if(facet == FACET.SOUTH){
       return textRollerList[1].bgColor;      
    }else if(facet == FACET.EAST){
       return textRollerList[2].bgColor;      
    }else if(facet == FACET.WEST){
       return textRollerList[3].bgColor;      
    }else if(facet == FACET.BOTTOM_UP){
      return 0;
    }else if(facet == FACET.CEILING_DOWN){
      return textRollerList[4].bgColor;      
    } 
    return 0;
  }
  
  public void rollText(){
    
    for(int i=0; i<textRollerList.length; i++){
      textRollerList[i].rollText();  
    }
    
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