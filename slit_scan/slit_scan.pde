import processing.video.*;

Capture webcam;

int webcamX;
int screenX;

void setup(){
  size(640, 480);
  
  webcam = new Capture(this, 640, 480);
  webcam.start();  
  
  print(webcam.width);
  print(", ");
  println(webcam.height);
  
  webcamX = webcam.width / 2;
  screenX = width - 1;
  background(0);
}

void draw(){
  if(webcam.available()){
    webcam.read();
    webcam.loadPixels();
    
    loadPixels();
    for (int y = 0; y < webcam.height; y++){
      int setPixelIndex = y*width + screenX;
      int getPixelIndex = y*webcam.width  + webcamX;
      pixels[setPixelIndex] = webcam.pixels[getPixelIndex];
    }
    updatePixels();
    
    screenX--;
    if (screenX < 0) {
      screenX = width - 1;
    }
  }
}