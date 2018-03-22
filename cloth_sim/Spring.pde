class Spring extends VerletSpring{
  
  Spring(Particle a, Particle b){
    super(a, b, 10, 0.9);
  }
  
  void display(){
    stroke(150);
    line(a.x, a.y, a.z, b.x, b.y, b.z);
  }
}
