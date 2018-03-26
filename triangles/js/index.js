function sign (p1, p2, p3){
  return (p1.x - p3.x) * (p2.y - p3.y) - (p2.x - p3.x) * (p1.y - p3.y);
}

function PointInTriangle (pt, v1, v2, v3){
  var b1;
  var b2;
  var b3;
  
  b1 = sign(pt, v1, v2) < 0;
  b2 = sign(pt, v2, v3) < 0;
  b3 = sign(pt, v3, v1) < 0;
  
  return ((b1 == b2) && (b2 == b3));
}

class Edge{
  constructor(a_, b_){
    this.a = a_;
    this.b = b_;
    this.available = true;
  }
}

class Triangle{
  
  constructor(points_){
    this.points = [];
    for(var i = 0; i < 3; i++){
      this.points[i] = points_[i];
    }
    this.edges = [];
    this.edges[0] = new Edge(this.points[0], this.points[1]);
    this.edges[1] = new Edge(this.points[0], this.points[2]);
    this.edges[2] = new Edge(this.points[1], this.points[2]);
    this.selected = false;
    
    this.mirrors = [];
    
    for(var i = 0; i < 3; i++){
      var randomA = this.points[i];
      var randomB = this.points[(i + 1) % 3];
      var randomC = this.points[(i + 2) % 3];
      // console.log(i, (i + 1) % 3, (i + 2) % 3);


      var bToA = p5.Vector.sub(randomA, randomB);
      bToA.mult(0.5);
      var midPoint = p5.Vector.add(randomB, bToA);

      var midPointToC = p5.Vector.sub(randomC, midPoint);

      var newVertex = p5.Vector.sub(midPoint, midPointToC);

      var newTriPoints = [randomA, randomB, newVertex];
      // fill(255);
      // triangle(randomA.x, randomA.y, randomB.x, randomB.y, newVertex.x, newVertex.y);
      this.mirrors.push(newTriPoints);
    }
  }
  
  draw(){
    stroke(0);
    strokeWeight(1);
    fill(255);
    if(this.selected){
      noFill();
      for(let m of this.mirrors){
        triangle(m[0].x, m[0].y, m[1].x, m[1].y, m[2].x, m[2].y);
      }
      fill(0);
    }
    triangle(this.points[0].x, this.points[0].y, this.points[1].x, this.points[1].y, this.points[2].x, this.points[2].y);
  }

}

var tris = [];
var nextTriPoints = [];
var triCount = 0;

function setup(){
  createCanvas(window.innerWidth, window.innerHeight);
}

function draw(){
  clear(255, 255, 255);
  fill(0);
  noStroke();
  text("shortcuts", 10, height - 25);
  // text("c – create", 10, height - 55);
  // text("d - draw", 10, height - 40);
  text("r - reset", 10, height - 10);
  // text("m - move", 10, height - 10);
  
  for(let t of tris){
    t.draw();
  }
  
  for(let p of nextTriPoints){
    fill(0);
    noStroke();
    ellipse(p.x, p.y, 3, 3);
  }
}

function mouseClicked(){
  for(let t of tris){
    if(t.selected){
      for(var i = 0; i < t.mirrors.length; i++){
        if(PointInTriangle(createVector(mouseX, mouseY), t.mirrors[i][0], t.mirrors[i][1], t.mirrors[i][2])){
          var newTri = new Triangle(t.mirrors[i]);
          // newTri.mirrors.splice(newTri.mirrors.indexOf(t.points), 1);
          tris.push(newTri);
          t.mirrors.splice(i, 1);
          t.selected = false;
          return;
        }
      }
    }
    if(PointInTriangle(createVector(mouseX, mouseY), t.points[0], t.points[1], t.points[2])){
      // t.selected = !t.selected;
      // t.grow();
      return;
    }
  }
  
  if(nextTriPoints.length < 2){
    nextTriPoints.push(createVector(mouseX, mouseY));
  }else{
    nextTriPoints.push(createVector(mouseX, mouseY));
    tris.push(new Triangle(nextTriPoints));
    nextTriPoints = [];
  }
}

function mouseDragged(){
  if(dist(pmouseX, pmouseY, mouseX, mouseY) < 3) return;
  for(let t of tris){
    for(var i = 0; i < t.mirrors.length; i++){
      if(PointInTriangle(createVector(mouseX, mouseY), t.mirrors[i][0], t.mirrors[i][1], t.mirrors[i][2])){
        var newTri = new Triangle(t.mirrors[i]);
        // newTri.mirrors.splice(newTri.mirrors.indexOf(t.points), 1);
        tris.push(newTri);
        t.mirrors.splice(i, 1);
        t.selected = false;
        return;
      }
    }
  }
}

function keyPressed(){
  console.log(keyCode);
  if(keyCode == 82){
    tris = [];
    nextTriPoints = [];
  }
}
