import toxi.physics.*;
import toxi.physics.behaviors.*;
import toxi.physics.constraints.*;

import toxi.geom.*;
import toxi.geom.mesh.*;
import toxi.geom.mesh.subdiv.*;
import toxi.geom.mesh2d.*;
import toxi.math.*;
import toxi.math.conversion.*;
import toxi.math.noise.*;
import toxi.math.waves.*;
import toxi.util.*;
import toxi.util.datatypes.*;
import toxi.util.events.*;

VerletPhysics physics;

int rows = 40;
int cols = 40;

Particle[][] particles = new Particle[rows][cols];
ArrayList<Spring> springs;

void setup(){
  size(600, 400, P3D);
  translate(width/2, height/2);
  //particles = new ArrayList<Particle>();
  springs = new ArrayList<Spring>();
  
  physics = new VerletPhysics();
  Vec3D gravity = new Vec3D(0, 0.5, 0);
  GravityBehavior gb = new GravityBehavior(gravity);
  physics.addBehavior(gb);
  
  float z = 0;
  for(int i = 0; i < rows; i++){
    float x = 100;
    for(int j = 0; j < cols; j++){
      Particle p = new Particle(x, 100, z);
      particles[i][j] = p;
      //particles.add(p);
      physics.addParticle(p);
      x += 10;
    }
    z += 10;
  }
  
  for(int i = 0; i < rows-1; i++){
    for(int j = 0; j < cols-1; j++){
      Particle a = particles[i][j];
      Particle b = particles[i + 1][j];
      Particle c = particles[i][j + 1];
      Particle d = particles[i + 1][j + 1];
      
      Spring s = new Spring(a, b);
      Spring s2 = new Spring(a, c);
      Spring s3 = new Spring(a, d);
      
      springs.add(s);
      physics.addSpring(s);
      
      springs.add(s2);
      physics.addSpring(s2);
      
      //springs.add(s3);
      //physics.addSpring(s3);
    }
  }
  
  particles[0][0].lock();
  particles[0][rows - 1].lock();
  //particles[cols - 1][0].lock();
  //particles[rows - 2][cols - 2].lock();
}

void draw(){
  background(255);
  physics.update();
  
  for(int i = 0; i < rows; i++){
    for(int j = 0; j < cols; j++){
      //particles[i][j].display();
    }
  }
  
  for(Spring s : springs){
    s.display();
  }
}

void mouseDragged(){
  for(Spring s : springs){
    if(intersects(pmouseX, pmouseY, mouseX, mouseY, s.a.x, s.a.y, s.b.x, s.b.y)){
      physics.removeSpring(s);
      springs.remove(s);
      break;
    }
  }
}

boolean intersects(float x1, float y1, float x2, float y2, float x3, float y3, float x4, float y4){
  float numerator1 = (x4 - x3) * (y1 - y3) - (y4 - y3) * (x1 - x3);
  float numerator2 = (x2 - x1) * (y1 - y3) - (y2 - y1) * (x1 - x3);
  float denominator = (y4 - y3)*(x2 - x1) - (x4 - x3)*(y2 - y1);
  return (denominator != 0) && (numerator1/denominator > 0) && (numerator1/denominator < 1) && (numerator2/denominator > 0) && (numerator2/denominator < 1);
}
