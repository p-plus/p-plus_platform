import java.io.*;

public class FileImporter{
  
  private long lastReading;
  private XML xml;
  private boolean importingFile;
  
  public FileImporter() {
  }
  
  public void loadEnvironmentFromXML(){
    
    //initialise Environment
    //derivedSettings();
    //environment = new Environment();
    environment.clearEnvironment();
    
    if(!importingFile){
    lastReading = millis();
    importingFile = true;
    delay(500);
    selectInput("Select a folder to process:", "fileSelected", null, this);
    }    
  }
  
  void initEnvironmentFromXML(XML xml) {

    //XML environmentElement = xml.getChild("Environment");
    XML settingsElement = xml.getChild("Settings");
    XML physicalSettingsElement = settingsElement.getChild("Physical");
    maxCells = physicalSettingsElement.getInt("maxCells", maxCells);
    envXMaxSize = physicalSettingsElement.getInt("envXMaxSize", envXMaxSize);
    envYMaxSize = physicalSettingsElement.getInt("envYMaxSize", envYMaxSize);
    envZMaxSize = physicalSettingsElement.getInt("envZMaxSize", envZMaxSize);
    minimumPathHeight = physicalSettingsElement.getInt("minimumPathHeight", minimumPathHeight);
    XML cellSettingsElement = settingsElement.getChild("Cell");
    unitSize = cellSettingsElement.getInt("unitSize", unitSize);
    cellWeight = cellSettingsElement.getFloat("cellWeight", cellWeight);
    cellMaxLoad = cellSettingsElement.getFloat("cellMaxLoad", cellMaxLoad);
    PIXELS_PER_CELL = cellSettingsElement.getInt("PIXELS_PER_CELL", PIXELS_PER_CELL);
    XML dmxSettingsElement = settingsElement.getChild("DMX");
    MAX_LED_STRIP_LENGTH = dmxSettingsElement.getInt("MAX_LED_STRIP_LENGTH", MAX_LED_STRIP_LENGTH);
    XML modelingSettingsElement = settingsElement.getChild("Modeling");
    DRAW_OFFSET = modelingSettingsElement.getInt("DRAW_OFFSET", DRAW_OFFSET);
    
    derivedSettings();    
    environment = new Environment();
        
    XML[] cellChainElements = xml.getChildren("CellChain");
    
    for(int i=0; i<cellChainElements.length; i++) {
      int id = cellChainElements[i].getInt("id"); 
      XML[] cellElements = cellChainElements[i].getChildren("Cell");
      println("\nCellChain: "+i);
      for(int j=0; j<cellElements.length; j++) {
        int x = cellElements[j].getInt("x");   
        int y = cellElements[j].getInt("y");   
        int z = cellElements[j].getInt("z");
        String type = cellElements[j].getString("type");   
        String orientation = cellElements[j].getString("orientation");
        int rotation = cellElements[j].getInt("rotation");   
        println("Cell: "+j+", orientation: "+orientation+", rotation: "+rotation+", type: "+type+", x: "+x+", y: "+y+", z: "+z);
        environment.setCell(x, y, z, type, orientation, rotation);
      }
    }
    
  }
  
  void fileSelected(File selection) {
    if (selection == null) {
      println("Window was closed or the user hit cancel.");
    } else {
      println("User selected " + selection.getAbsolutePath());
      String[] path = selection.getAbsolutePath().split("/");
      String filename = path[path.length-1];
      String extension = filename.split("\\.")[1];
      if(extension.contains("xml")){
        xml = loadXML(selection.getAbsolutePath());
        initEnvironmentFromXML(xml);
      } else {
        println("Selected file is not of type xml");  
      }

    }
    importingFile = false;
  }
  
  public boolean importingFile() {
    return importingFile;
  }
 
  
}