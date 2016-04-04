public class TextRoller {
  
  private final long ROLL_INTERVAL = 250; // in ms
  private final int SCREEN_WIDTH = envXMaxUnits; // for now, let's assume envXMaxUnits == envYMaxUnits
  private final int ROLL_END_OFFSET = 0; 
  
  private int textStartPosition;
  private long lastMoveTime;
  private int loopCounter;
  private TextString textString;
  
  public TextRoller() {
    textString = new TextString();
  }
  
  public void setText(String text) {
    textString.setText(text);
    textStartPosition = SCREEN_WIDTH;
    loopCounter = 0;
  }
    
  public void rollText() {
    if ((millis() - lastMoveTime) > ROLL_INTERVAL*3) {
      lastMoveTime = millis();
      textStartPosition--;
      if (textStartPosition < (-1)*(textString.getColumns().size())-ROLL_END_OFFSET) {
        textStartPosition = SCREEN_WIDTH;
        loopCounter++;
      }
      //textStartPosition++;
      //if (textStartPosition > SCREEN_WIDTH + ROLL_END_OFFSET) {
      //  textStartPosition = -textString.getColumns().size();
      //}
    }
  }
  
  public boolean isPixelOn(int i, int j, PIXEL pixel) {
    boolean isOn = false;
    
    int columnCoordinate = i;
    int pixelSetCoordinate = j;
    
    if (pixelSetCoordinate < TextCharacter.PIXEL_SET_COLUMN_HEIGHT) {
      int columnIndex = columnCoordinate - textStartPosition;
      if ((columnIndex >= 0) && (columnIndex < textString.getColumns().size())) {
        PixelSetColumn pixelColumn = (PixelSetColumn)textString.getColumns().get(columnIndex);
        PixelSet pixelSet = pixelColumn.getPixelSets()[j];
        if (PIXEL.BOTTOM == pixel) {
          isOn = pixelSet.getPixels()[0];
        } else if (PIXEL.RIGHT == pixel) {
          isOn = pixelSet.getPixels()[1];
        } else if (PIXEL.TOP == pixel) {
          isOn = pixelSet.getPixels()[2];
        } else {
          isOn = pixelSet.getPixels()[3];
        }
      }
    }
    
    return isOn;
  }
  
   public boolean isPixelOn(int i, int j, PIXEL pixel, int delayPosition) {
    boolean isOn = false;
    
    int columnCoordinate = i;
    int pixelSetCoordinate = j;
    
    if (pixelSetCoordinate < TextCharacter.PIXEL_SET_COLUMN_HEIGHT) {
      int columnIndex = columnCoordinate - textStartPosition+delayPosition;
      if ((columnIndex >= 0) && (columnIndex < textString.getColumns().size())) {
        PixelSetColumn pixelColumn = (PixelSetColumn)textString.getColumns().get(columnIndex);
        PixelSet pixelSet = pixelColumn.getPixelSets()[j];
        if (PIXEL.BOTTOM == pixel) {
          isOn = pixelSet.getPixels()[0];
        } else if (PIXEL.RIGHT == pixel) {
          isOn = pixelSet.getPixels()[1];
        } else if (PIXEL.TOP == pixel) {
          isOn = pixelSet.getPixels()[2];
        } else {
          isOn = pixelSet.getPixels()[3];
        }
      }
    }
    
    return isOn;
  }
  
  public float getTimeInPercentUntilRoll(){
    float timeInPercent = 1.0;
    if ((millis() - lastMoveTime) < ROLL_INTERVAL){
     timeInPercent = (millis() - lastMoveTime)/((float)ROLL_INTERVAL);
    }
    //println(timeInPercent);
    return timeInPercent;
  }
  
  public int getLoopCounter(){
    return loopCounter;  
  }
}