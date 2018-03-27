class Blob{
  PVector position;
  PVector v;
  PVector acc;
  float radius;
  
  Blob(float x, float y){
    position = new PVector(x, y);
    radius = random(30, 60);
    v = PVector.random2D();
    v.mult(random(2, 5));
    acc = new PVector(0,0);
  }
  
  void update(){
    //acc.setMag(0);
    for(Blob b : blobs){
      PVector attract = PVector.sub(b.position, position);
      //float d = dist(position.x, position.y, b.position.x, b.position.y);
      //float m = attract.mag();
      attract.mult(0.001);
      acc.add(attract);
    }
    v.add(acc);
    v.limit(3);
    position.add(v);
    
    if(position.x - radius <= 0 || position.x + radius >= width){
      position.x = constrain(position.x, 1 + radius, width - 1 - radius);
      v.x *= -1;
    }
    
    if(position.y - radius <= 0 || position.y + radius >= height){
      position.y = constrain(position.y, 1 + radius, height - 1 - radius);
      v.y *= -1;
    }
    
   
  }
  
  void draw(){
    noFill();
    stroke(360);
    strokeWeight(1);
    ellipse(position.x, position.y, radius * 2, radius * 2);
  }
}
