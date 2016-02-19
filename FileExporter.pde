import java.io.*;

/************************************
/*
/*  Exports the current generated structure as a CSV file, so that
/*  it can be recreated later in other applications (e.g. Rhino).
/*  
/*  Exported file follows the following name format:
/*  ./exportedFiles/envModel_yyyy_mm_dd_HHMMss
/*
*************************************/

public class FileExporter {
  private final String FILE_FOLDER = "exportedFiles/";
  private final String FILE_NAME_PREFIX = "envModel_";
  private long WRITING_PERIOD = 1000;
  
  private PrintWriter writer;
  private boolean exportingFile;
  private long lastWriting;
  
  private XML xml;

  
  public FileExporter() {
  }
  
  public void exportEnvironmentAsXML(Environment env) {
    xml = new XML("Environment");
        
    XML settingsElement = xml.addChild("Settings");
    XML physicalSettingsElement = settingsElement.addChild("Physical");
    physicalSettingsElement.setInt("maxCells", maxCells);
    physicalSettingsElement.setInt("envXMaxSize", envXMaxSize);
    physicalSettingsElement.setInt("envYMaxSize", envYMaxSize);
    physicalSettingsElement.setInt("envZMaxSize", envZMaxSize);
    physicalSettingsElement.setInt("minimumPathHeight", minimumPathHeight);
    XML cellSettingsElement = settingsElement.addChild("Cell");
    cellSettingsElement.setInt("unitSize", unitSize);
    cellSettingsElement.setFloat("cellWeight", cellWeight);
    cellSettingsElement.setFloat("cellMaxLoad", cellMaxLoad);
    cellSettingsElement.setInt("PIXELS_PER_CELL", PIXELS_PER_CELL);
    XML dmxSettingsElement = settingsElement.addChild("DMX");
    dmxSettingsElement.setInt("MAX_LED_STRIP_LENGTH", MAX_LED_STRIP_LENGTH);
    XML modelingSettingsElement = settingsElement.addChild("Modeling");
    modelingSettingsElement.setInt("DRAW_OFFSET", DRAW_OFFSET);
    
    int i_chain = 0;
    for(CellChain k: env.getCellChain()){
      XML cellChainElement = xml.addChild("CellChain");
      for(Cell cell: k.getCells()){
        XML cellElement = cellChainElement.addChild("Cell");
        cellElement.setInt("x", cell.x);
        cellElement.setInt("y", cell.y);
        cellElement.setInt("z", cell.z);
        cellElement.setString("type", cell.getType().toString());
        cellElement.setString("orientation", cell.getOrientation().toString());
        cellElement.setInt("rotation", cell.getRotation());
      }
      i_chain ++;
    }
    
    String filename = FILE_FOLDER + FILE_NAME_PREFIX + getTimestampString() + ".xml";
    saveXML(xml, filename);
    
    println("\n### File " + filename + " exported successfully!\n");

    
  }

  public void exportExnvironmentAsFile(Environment env) {
    
    exportingFile = true;
    lastWriting = millis();
    
    String filename = FILE_FOLDER + FILE_NAME_PREFIX + getTimestampString() + ".txt";
    writer = createWriter(filename);//new PrintWriter(filename, "UTF-8");
    writeEnvironment(env);
    writer.close();
    println("\n### File " + filename + " exported successfully!\n");
    
  }
  
  private void writeEnvironment(Environment env) {
    writeCellChains(env);
    for (int x = 0; x < envXMaxUnits; x++) {
      for (int y = 0; y < envYMaxUnits; y++) {
        for (int z = 0; z < envZMaxUnits; z++) {
          if (env.getMatrix()[x][y][z].solid) {
            writeCell(env.getMatrix()[x][y][z]);
          }
        }
      }
    }
  }
  
  
  private void writeCellChains(Environment env) {
    int i_chain = 0;
    for(CellChain k: env.getCellChain()){
      for(Cell cell: k.getCells()){
        println(i_chain+","+cell.x + "," + cell.y + "," + cell.z + "," + cell.getType() + "," + cell.getOrientation() + "," + cell.getRotation());          
      }
      i_chain ++;
    }
  }
  
  private void writeCell(Cell cell) {
    writer.println(cell.x + "," + cell.y + "," + cell.z + "," + cell.getType() + "," + cell.getOrientation() + "," + cell.getRotation());
  }
  
  private String getTimestampString() {
    return year() + "_" + month() + "_" + day() + "_" + hour() + "" + minute() + second();
  }
  
  public boolean stillWritingFile() {
    if (exportingFile && ((millis() - lastWriting) < WRITING_PERIOD)) {
      return true;
    }
    
    exportingFile = false;
    return false;
  }
}