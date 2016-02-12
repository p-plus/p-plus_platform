float panUpFactor = 1.0f;
float rotationFactor = 1.0f;
float zoomFactor = 0.5f;

FileExporter fileExporter;
Environment environment;

void setup() {
  size(1280, 720, P3D);
  initialiseEnvironment();
  fileExporter = new FileExporter();
}

void draw() {  
  lights();
  ambientLight(150, 150, 128);
  int concentration = 600;
  spotLight(255, 255, 255, envXMaxUnits/2, envYMaxUnits, envZMaxUnits/2, 0, 1, 0, PI/16, concentration);
  spotLight(255, 255, 255, envXMaxUnits, envYMaxUnits/2, envZMaxUnits/2, 1, 0, 0, PI/16, concentration);
  spotLight(255, 255, 255, envXMaxUnits/2, envYMaxUnits/2, envZMaxUnits, 0, 0, -1, PI/16, concentration);
  
  spotLight(255, 255, 255, envXMaxUnits/2, 0, envZMaxUnits/2, 0, -1, 0, PI/16, concentration);
  spotLight(255, 255, 255, 0, envYMaxUnits/2, envZMaxUnits/2, -1, 0, 0, PI/16, concentration);
  
  evaluateCamera();
  evaluateControllers();
  environment.drawEnvironment();
  drawAxis(); 
  environment.getTextRoller().rollText();
  
  try {
    wait(1000);
  } catch (Exception e) {
  }
}

void initialiseEnvironment() {
  lights();
  background(0);
  noStroke();
  environment = new Environment();
}

void evaluateCamera() {
  float cameraY = height/2.0;
  float fov = PI/3;
  float cameraZ = cameraY / tan(fov / 2.0);
  float aspect = float(width)/float(height);
  perspective(fov, aspect, cameraZ/10.0, cameraZ*10.0);
  
  if (configMode) {
    camera(width/2, height/2, (height/2) / tan(PI/6), width/2, height/2, 0, 0, 1, 0);
  } else {
    camera(cos(rotationFactor)*zoomFactor*2.5*height, sin(rotationFactor)*zoomFactor*2.5*height, zoomFactor*((height/2) / panUpFactor*tan(PI/6)), 0, 0, 0, 0, 0, -1);
  }
}

void drawAxis() {
  // Draw x-axis
  stroke(0, 255, 0);
  line(0, 0, 0, 3*height, 0, 0);
  
  // Draw y-axis
  stroke(255, 0, 0);
  line(0, 0, 0, 0, 3*height, 0);
  
  // Draw z-axis
  stroke(0, 0, 255);
  line(0, 0, 0, 0, 0, 3*height);
  
  // Draw space
  stroke(255);
  int OFF = (configMode)?0:DRAW_OFFSET;
  line(OFF+0, OFF+envYMaxSize, 0, OFF+envXMaxSize, OFF+envYMaxSize, 0);
  line(OFF+envXMaxSize, OFF+0, 0, OFF+envXMaxSize, OFF+envYMaxSize, 0);
  line(OFF+0, OFF+0, 0, OFF+envXMaxSize, OFF+0, 0);
  line(OFF+0, OFF+0, 0, OFF+0, OFF+envYMaxSize, 0);
}