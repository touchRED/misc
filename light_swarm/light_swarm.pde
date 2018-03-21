Orb[] orbs = new Orb[20];

void setup(){
  size(600, 600);
  colorMode(HSB, 360, 100, 100);
  
  for(int i = 0; i < orbs.length; i++){
    orbs[i] = new Orb();
  }
}

void draw(){
  //background(255);
  
  for(Orb o : orbs){
    o.update();
  }
  
  loadPixels();
  for(int x = 0; x < width; x++){
    for(int y = 0; y < height; y++){
      int loc = x + y * width;
      float sum = 0;
      for(Orb o : orbs){
        float d = dist(x, y, o.location.x, o.location.y);
        sum += 5 * o.radius / d;
      }
      //float d = dist(x, y, mouseX, mouseY);
      //float c = 5000 / d;
      pixels[loc] = color(190, 100, sum);
    }
  }
  updatePixels();
}
