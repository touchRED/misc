class Orb{
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector mouse;
  int radius;
  
  Orb(){
    location = new PVector(random(0, width), random(0, height));
    velocity = new PVector(0,0);
    mouse = new PVector(); 
    radius = 20;
  }
  
  void update(){
    mouse.x = mouseX;
    mouse.y = mouseY;
    
    acceleration = PVector.sub(mouse, location);
    acceleration.setMag(0.7);
    velocity.limit(10);
    
    location.add(velocity);
    velocity.add(acceleration);
  }
  
  void draw(){
    fill(0);
    ellipse(location.x, location.y, 25, 25);
  }
}
