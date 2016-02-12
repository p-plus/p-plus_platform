public class TextString {
  private static final int MAX_TEXT_LENGTH = 144;

  private ArrayList<PixelSetColumn> columns;
  private TextCharacterCatalog catalog;
  
  public TextString() {
    columns = new ArrayList<PixelSetColumn>();
    catalog = new TextCharacterCatalog();
  }
  
  public ArrayList<PixelSetColumn> getColumns() {
    return columns;
  }
  
  public void setText(String text) {
    columns.clear();
    int textLength = min(text.length(), MAX_TEXT_LENGTH);
    
    String uppercaseText = text.toUpperCase();
    for (int i = 0; i < textLength; i++) {
      PixelSetColumn[] charColumns = catalog.get(uppercaseText.substring(i, i+1)).getColumns();
      for (int j = 0; j < charColumns.length; j++) {
        columns.add(charColumns[j]);
      }
    }
  }

}