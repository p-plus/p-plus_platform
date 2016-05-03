ArrayList<Fire> hanabi = new ArrayList();

final int FIRE_COUNT = 1000;
final float X = 200;
final float Y = 50;

final float G = 0.04;

class Fire{
  float x;
  float y;
  float vx;
  float vy;
  
  color col;
  
  float lifetime = 100;
  
  Fire(float x, float y, float vx, float vy, color col){
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.col = col;
  }
}

public void drawFirework(){
  
  pgOff.beginDraw();
  //pgOff.colorMode(HSB, 360, 100, 100);
  pgOff.noStroke();
  pgOff.fill(0,0,0,40);
  pgOff.rect(0,0,width,height);
  
  pgOff.fill(200);
  pgOff.text("click anywhere" , 10,380); 
  
  for(Fire fire : hanabi){ 
    fire.vx += 0;
    fire.vy += G;
    
    fire.x += fire.vx;
    fire.y += fire.vy;
    
    if(fire.lifetime-50>0){
      pgOff.noStroke();
      color c = fire.col;
      float hue = c >> 16 & 0xFF; 
      float saturation = c >> 8 & 0xFF; 
      float brightness = c & 0xFF; 
      pgOff.fill(hue, saturation, brightness, // RGB
         fire.lifetime-50); //Alpha
        
      pgOff.ellipse(fire.x,fire.y,4,4); // draw the fire
      fire.lifetime -= 0.5; // decrease lifetime
    }else{
    }
  }
  //pgOff.fill(255,100,100);
  //pgOff.rect(0,0,50,frameCount%pgOff.height);
  pgOff.endDraw();
  
}

void mousePressed()
{
    hanabi.clear();
    
    color c = color(0,0,0);
    if(frameCount%2==0){
      c = color(random(0,60),random(80,100),random(50,100));
    }else{
      c = color(random(260,360),random(80,100),random(50,100));

    }
    for(int i=0; i<FIRE_COUNT; i++){
     float r = random(0,TWO_PI);
     float R = random(0,2);
     
     //hanabi.add(new Fire((int)random(30,40),(int)(0.8*envZMaxUnits*3*2),R*sin(r),R*cos(r),c));
     hanabi.add(new Fire((int)(envXMaxUnits*3),(int)-(0.2*envZMaxUnits*3*2),R*sin(r),R*cos(r),c));

   }
}