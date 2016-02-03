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
int maxCells = 200;
int envXMaxSize = 450; // cm
int envYMaxSize = 450; // cm

// OPTION 3: Additional $18K
//int maxCells = 300;
//int envXMaxSize = 600; // cm
//int envYMaxSize = 600; // cm

//int envZMaxSize = 250; //cm
int envZMaxSize = 250; //cm

int minimumPathHeight = 210; // cm, minimum height for any walking pathway through the structure

//////////////////////////////////////
//  Light cell settings
//////////////////////////////////////
int unitSize = 36; // in pixels, representing cm
float cellWeight = 300; // g
float cellMaxLoad = 1500; // g, the maximum weight that can be added to the top of a cell, without it collapsing

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