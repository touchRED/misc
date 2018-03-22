class Particle extends VerletParticle{
  
  Particle(float x, float y, float z){
    super(x, y, z);
  }
  
  void display(){
    fill(255);
    stroke(0);
    ellipse(x, y, 3, 3);
  }
}
