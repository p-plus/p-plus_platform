import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import artnet4j.*;
import artnet4j.events.*;
import artnet4j.packets.*;

/************************************
/*
/*  Configuration settings 
/*
*************************************/

int maxCells, envXMaxSize, envYMaxSize, envZMaxSize, minimumPathHeight;
int unitSize;
float cellWeight, cellMaxLoad;
static int PIXELS_PER_CELL;
static int MAX_LED_STRIP_LENGTH;
int DRAW_OFFSET;
String DISPLAY_TEXT = "Hello";
int TEXT_ROLLER_LOOPS = 1;

int PORTS_PER_IP_ADRESS = 4;
String[] ip_adresses = { "192.168.0.98", "192.168.0.99" };
ArtNet artnet;

float cellLoadOffset;
int envXMaxUnits, envYMaxUnits, envZMaxUnits, envZMaxUnitsPath;
int TOTAL_NUMBER_OF_PIXELS;
static int MAX_CELL_CHAIN_LENGTH;
int NUMBER_OF_CELL_CHAINS;
String fileName = "";


public void derivedSettings(){
  cellLoadOffset = cellWeight/cellMaxLoad;
  envXMaxUnits = envXMaxSize/unitSize;
  envYMaxUnits = envYMaxSize/unitSize;
  envZMaxUnits = envZMaxSize/unitSize;
  envZMaxUnitsPath = minimumPathHeight/unitSize;

  TOTAL_NUMBER_OF_PIXELS = maxCells * PIXELS_PER_CELL;
  MAX_CELL_CHAIN_LENGTH = MAX_LED_STRIP_LENGTH/PIXELS_PER_CELL;
  NUMBER_OF_CELL_CHAINS = maxCells/MAX_CELL_CHAIN_LENGTH+1;
}

public void loadConfigFile() {
  
  Properties prop = new Properties();
  InputStream input = null;
   
  try {
               
    input = createInput("config.properties");
     
    prop.load(input);

    // get the property value and print it out
    maxCells = Integer.parseInt(prop.getProperty("maxcells"));
    envXMaxSize = Integer.parseInt(prop.getProperty("envxmaxsize"));
    envYMaxSize = Integer.parseInt(prop.getProperty("envymaxsize"));
    envZMaxSize = Integer.parseInt(prop.getProperty("envzmaxsize"));
    minimumPathHeight = Integer.parseInt(prop.getProperty("minimumpathheight"));
     
    unitSize = Integer.parseInt(prop.getProperty("unitsize"));
    cellWeight = Integer.parseInt(prop.getProperty("cellweight"));
    cellMaxLoad = Integer.parseInt(prop.getProperty("cellmaxload"));
    PIXELS_PER_CELL = Integer.parseInt(prop.getProperty("pixelspercell"));
     
    MAX_LED_STRIP_LENGTH = Integer.parseInt(prop.getProperty("maxledstriplength"));
     
    DRAW_OFFSET = Integer.parseInt(prop.getProperty("drawoffset"));

    derivedSettings();

  } catch (IOException ex) {
    ex.printStackTrace();
  } finally {
    if (input != null) {
      try {
        input.close();
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
  }
}