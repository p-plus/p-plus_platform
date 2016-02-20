import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;

/************************************
/*
/*  Configuration settings 
/*
*************************************/

//////////////////////////////////////
//  Physical environment dimensions
//////////////////////////////////////

// OPTION 1: Possible with $10K
//int maxCells = 50;
//int envXMaxSize = 250; // cm
//int envYMaxSize = 250; // cm

// OPTION 2: Additional $10K
//int maxCells = 200;
//int envXMaxSize = 450; // cm
//int envYMaxSize = 450; // cm
//int envXMaxSize = 650; // cm
//int envYMaxSize = 650; // cm

// OPTION 3: Additional $18K
int maxCells = 100;
//int envXMaxSize = 600; // cm
//int envYMaxSize = 600; // cm
int envXMaxSize = 300; // cm
int envYMaxSize = 300; // cm


int envZMaxSize = 260; //cm
int minimumPathHeight = 210; // cm, minimum height for any walking pathway through the structure

String DISPLAY_TEXT = "HELLO";

//////////////////////////////////////
//  Light cell settings
//////////////////////////////////////
int unitSize = 35; // in pixels, representing cm
float cellWeight = 300; // g
float cellMaxLoad = 1500; // g, the maximum weight that can be added to the top of a cell, without it collapsing
static int PIXELS_PER_CELL = 4;

//////////////////////////////////////
//  DMX settings
//////////////////////////////////////
static int MAX_LED_STRIP_LENGTH = 170; // in pixels

//////////////////////////////////////
//  Modelling settings
//////////////////////////////////////
int DRAW_OFFSET = 0; // Only increase it if you wish to draw the structure away from (0, 0, 0) position in the 3D-environment

//////////////////////////////////////
//  Derived settings
//////////////////////////////////////

float cellLoadOffset = cellWeight/cellMaxLoad;
int envXMaxUnits = envXMaxSize/unitSize;
int envYMaxUnits = envYMaxSize/unitSize;
int envZMaxUnits = envZMaxSize/unitSize;
int envZMaxUnitsPath = minimumPathHeight/unitSize;

int TOTAL_NUMBER_OF_PIXELS = maxCells * PIXELS_PER_CELL;
static int MAX_CELL_CHAIN_LENGTH = MAX_LED_STRIP_LENGTH/PIXELS_PER_CELL;
int NUMBER_OF_CELL_CHAINS = maxCells/MAX_CELL_CHAIN_LENGTH+1;

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