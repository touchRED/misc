let angle;
let amp = 100;
let maxDistance;
let gui;
let ctrl;

function Controls(){
  this.x = 50;
  this.y = 50;
  this.rotation = PI/6;
  this.speed = 0.08;
  this.width = 50;
  this.height = 50;
  this.horizontalAmplitude = 200;
  this.horizontalOffset = 0.02;
  this.verticalAmplitude = 2;
  this.verticalOffset = 0.02;
  this.rBase = 137;
  this.rMaxAdd = 117;
  this.rOffset = 0.01;
  this.gBase = 139;
  this.gMaxAdd = 117;
  this.gOffset = 0.0135;
  this.bBase = 137;
  this.bMaxAdd = 117;
  this.bOffset = 0.0135;
}

function setup(){
  createCanvas(window.innerWidth, window.innerHeight);
  background(15, 15, 15);
  noStroke();
  
  ctrl = new Controls();
  gui = new dat.GUI();
  
  let genFolder = gui.addFolder("General");
  genFolder.add(ctrl, "x");
  genFolder.add(ctrl, "y");
  genFolder.add(ctrl, "rotation").step(0.1);
  genFolder.add(ctrl, "speed").step(0.01);
  genFolder.add(ctrl, "width");
  genFolder.add(ctrl, "height");
  genFolder.open();
  
  let waveFolder = gui.addFolder("Wave");
  waveFolder.add(ctrl, "horizontalAmplitude").step(5);
  waveFolder.add(ctrl, "verticalAmplitude");
  waveFolder.add(ctrl, "horizontalOffset").step(0.01);
  waveFolder.add(ctrl, "verticalOffset").step(0.01);
  
  let redFolder = gui.addFolder("Red");
  redFolder.add(ctrl, "rBase");
  redFolder.add(ctrl, "rMaxAdd");
  redFolder.add(ctrl, "rOffset").step(0.001);
  
  let greenFolder = gui.addFolder("Green");
  greenFolder.add(ctrl, "gBase");
  greenFolder.add(ctrl, "gMaxAdd");
  greenFolder.add(ctrl, "gOffset").step(0.001);;
  
  let blueFolder = gui.addFolder("Blue");
  blueFolder.add(ctrl, "bBase");
  blueFolder.add(ctrl, "bMaxAdd");
  blueFolder.add(ctrl, "bOffset").step(0.001);;

  angle = random(100);
  maxDistance = dist(0,0, width/2, height/2);
}

function draw(){
  background(15, 15, 15);
  
  for(var i = 0; i < width/2; i++){
    push();
    translate(i - ctrl.x, height + ctrl.y - i);
    // rotate(ctrl.rotation);
    rotate(angle * 0.1);
    let offset = dist(i - ctrl.x, height + ctrl.y - i, width/2, height/2);
    offset = map(offset, 0, maxDistance, 1, 0);
    fill(ctrl.rBase + ctrl.rMaxAdd * sin(angle + (i * ctrl.rOffset)), ctrl.gBase + ctrl.gMaxAdd * sin(angle + (i * ctrl.gOffset)), ctrl.bBase + ctrl.bMaxAdd * sin(angle + (i * ctrl.bOffset)));
    rect(-sin(angle + (i * ctrl.horizontalOffset)) * (ctrl.horizontalAmplitude * offset), cos(angle + (i * ctrl.verticalOffset)) * (ctrl.verticalAmplitude * offset), ctrl.width, ctrl.height);
    pop();
  }
  
  angle += ctrl.speed;
}