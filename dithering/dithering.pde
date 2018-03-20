import processing.video.*;

Capture webcam;
PImage me;
PImage meCopy;
int factor = 2;
int inc = 1;

void setup(){
  size(640, 480);
  //colorMode(HSB, 255);
  webcam = new Capture(this, 640, 480);
  webcam.start();  
  me = loadImage("me.jpg");
  me.resize(640, 0);
  
  print(me.width);
  print(", ");
  println(me.height);
}

void draw(){
  //if(webcam.available()){
  if(true){
    //webcam.read();
    ////webcam.filter(BLUR, 20);
    //webcam.loadPixels();
    
    //for(int i = 1; i < webcam.width - 1; i++){
    //  for(int j = 0; j < webcam.height - 1; j++){
    //    int loc = i + j * webcam.width;
        
    //    float oldR = red(webcam.pixels[loc]);
    //    float oldG = green(webcam.pixels[loc]);
    //    float oldB = blue(webcam.pixels[loc]);
        
    //    int factor = 1;
    //    //if(factor == 1 || factor == 2){
    //    //  inc *= -1;
    //    //}
    //    //factor += inc;
    //    float newR = round(factor * oldR / 255) * (255/factor);
    //    float newG = round(factor * oldG / 255) * (255/factor);
    //    float newB = round(factor * oldB / 255) * (255/factor);
        
    //    webcam.pixels[loc] = color(newR, newG, newB);
        
    //    float red_error = oldR - newR;
    //    float green_error = oldG - newG;
    //    float blue_error = oldB - newB;
        
    //    newR = red(webcam.pixels[loc + 1]) + red_error * 7/16.0;
    //    newG = green(webcam.pixels[loc + 1]) + green_error * 7/16.0;
    //    newB = blue(webcam.pixels[loc + 1]) + blue_error * 7/16.0;
    //    webcam.pixels[loc + 1] = color(newR, newG, newB);
        
    //    newR = red(webcam.pixels[loc + webcam.width - 1]) + red_error * 3/16.0;
    //    newG = green(webcam.pixels[loc + webcam.width - 1]) + green_error * 3/16.0;
    //    newB = blue(webcam.pixels[loc + webcam.width - 1]) + blue_error * 3/16.0;
    //    webcam.pixels[loc + webcam.width - 1] = color(newR, newG, newB);
        
    //    newR = red(webcam.pixels[loc + webcam.width]) + red_error * 5/16.0;
    //    newG = green(webcam.pixels[loc + webcam.width]) + green_error * 5/16.0;
    //    newB = blue(webcam.pixels[loc + webcam.width]) + blue_error * 5/16.0;
    //    webcam.pixels[loc + webcam.width] = color(newR, newG, newB);
        
    //    newR = red(webcam.pixels[loc + webcam.width + 1]) + red_error * 1/16.0;
    //    newG = green(webcam.pixels[loc + webcam.width + 1]) + green_error * 1/16.0;
    //    newB = blue(webcam.pixels[loc + webcam.width + 1]) + blue_error * 1/16.0;
    //    webcam.pixels[loc + webcam.width + 1] = color(newR, newG, newB);
    //  }
    //}
    //webcam.updatePixels();
    //set(0,0,webcam);
    
    background(255);
    meCopy = me.copy();
    meCopy.loadPixels();
    
    for(int i = 1; i < meCopy.width - 1; i++){
      for(int j = 0; j < meCopy.height - 1; j++){
        int loc = i + j * meCopy.width;
        
        float oldR = red(meCopy.pixels[loc]);
        float oldG = green(meCopy.pixels[loc]);
        float oldB = blue(meCopy.pixels[loc]);
        
        if(factor == 1 || factor == 11){
          inc *= -1;
        }
        factor += inc;
        
        float newR = round(factor * oldR / 255) * (255/factor);
        float newG = round(factor * oldG / 255) * (255/factor);
        float newB = round(factor * oldB / 255) * (255/factor);
        
        meCopy.pixels[loc] = color(newR, newG, newB);
        
        float red_error = oldR - newR;
        float green_error = oldG - newG;
        float blue_error = oldB - newB;
        
        newR = red(meCopy.pixels[loc + 1]) + red_error * 7/16.0;
        newG = green(meCopy.pixels[loc + 1]) + green_error * 7/16.0;
        newB = blue(meCopy.pixels[loc + 1]) + blue_error * 7/16.0;
        meCopy.pixels[loc + 1] = color(newR, newG, newB);
        
        newR = red(meCopy.pixels[loc + meCopy.width - 1]) + red_error * 3/16.0;
        newG = green(meCopy.pixels[loc + meCopy.width - 1]) + green_error * 3/16.0;
        newB = blue(meCopy.pixels[loc + meCopy.width - 1]) + blue_error * 3/16.0;
        meCopy.pixels[loc + meCopy.width - 1] = color(newR, newG, newB);
        
        newR = red(meCopy.pixels[loc + meCopy.width]) + red_error * 5/16.0;
        newG = green(meCopy.pixels[loc + meCopy.width]) + green_error * 5/16.0;
        newB = blue(meCopy.pixels[loc + meCopy.width]) + blue_error * 5/16.0;
        meCopy.pixels[loc + meCopy.width] = color(newR, newG, newB);
        
        newR = red(meCopy.pixels[loc + meCopy.width + 1]) + red_error * 1/16.0;
        newG = green(meCopy.pixels[loc + meCopy.width + 1]) + green_error * 1/16.0;
        newB = blue(meCopy.pixels[loc + meCopy.width + 1]) + blue_error * 1/16.0;
        meCopy.pixels[loc + meCopy.width + 1] = color(newR, newG, newB);
      }
    }
    meCopy.updatePixels();
    set(0,0,meCopy);
  }
}
