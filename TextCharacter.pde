/***************************************
  TEXT CHARACTER
***************************************/
public abstract class TextCharacter {
  protected static final int PIXEL_SET_LENGTH = 4;
  protected static final int PIXEL_SET_COLUMN_HEIGHT = 3; // in PixelSets
  
  protected PixelSetColumn[] columns;
  
  private TextCharacter() {
  }
  
  protected void initColumns(int numberOfColumns) {
    columns = new PixelSetColumn[numberOfColumns]; 
    for (int i = 0; i < numberOfColumns; i++) {
      columns[i] = new PixelSetColumn();
    }
  }
  
  protected abstract void initPixels();
  
  public PixelSetColumn[] getColumns() {
    return columns;
  }
}

/***************************************
  PIXEL SET
***************************************/
static class PixelSet {
  private boolean pixels[];
  
  public PixelSet() {
    pixels = new boolean[TextCharacter.PIXEL_SET_LENGTH];
  }
  
  public boolean[] getPixels() {
    return pixels;
  }
}

/***************************************
  PIXEL SET COLUMN
***************************************/
public static class PixelSetColumn {
  private PixelSet[] pixelSets;
  
  public PixelSetColumn() {
    pixelSets = new PixelSet[TextCharacter.PIXEL_SET_COLUMN_HEIGHT];
    for (int i = 0; i < pixelSets.length; i++) {
      pixelSets[i] = new PixelSet();
    }
  }
  
  public PixelSet[] getPixelSets() {
    return pixelSets;
  }
}