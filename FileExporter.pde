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
  
  public FileExporter() {
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
  
  private void writeCell(Cell cell) {
//    writer.println(cell.x + "," + cell.y + "," + cell.z + "," + cell.orientationIndex);
    writer.println(cell.x + "," + cell.y + "," + cell.z + "," + cell.getType() + "," + cell.getOrientation());
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