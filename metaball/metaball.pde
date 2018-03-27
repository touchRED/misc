//a 2d surface (like a computer screen) implements a function that outputs a color

//Blob b;
Blob[] blobs = new Blob[10];

void setup(){
  size(600, 600);
  colorMode(HSB, 360, 100, 100);
  for(int i = 0; i < blobs.length; i++){
    blobs[i] = new Blob(250, 250);
  }
}

void draw(){
  //background(255);
  
  loadPixels();
  for(int i = 0; i < width; i++){
    for(int j = 0; j < height; j++){
      int loc = i + j * width;
      float sum = 0;
      for(Blob b : blobs){
        float d = dist(i, j, b.position.x, b.position.y);
        sum += b.radius / d;
      }
      //println(sum);
      //pixels[loc] = color(round(sum/2000) * 255);
      pixels[loc] = color(float(mouseX) / width * 360, constrain(round(sum/8) * 60, 0, 60), 100);
    }
  }
  updatePixels();
  
  for(int i = 0; i < blobs.length; i++){
    blobs[i].update();
    //blobs[i].draw();
  }
}
