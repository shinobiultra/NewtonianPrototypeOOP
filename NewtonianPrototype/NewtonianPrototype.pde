PVector vec, pos;
PVector center;
PVector momentum;
float G = 1;

void setup() {
  size(1280, 720);
  pos = new PVector(100, 100);
  momentum = new PVector(0,0);
  
  center = new PVector(width/2,height/2);
}

void draw() {
  background(51);
  fill(#F6FF03);
  ellipse(width/2, height/2, 100, 100);
  if (mousePressed) {
    pos.x = mouseX;
    pos.y = mouseY;
    
    momentum.x = mouseX - pmouseX;
    momentum.y = mouseY - pmouseY;
    
    momentum.div(2);
  }
  vec = CalculateVector(pos, center); 
  //println(vec);
  momentum.add(vec);
  pos.add(momentum);
  
  fill(0,0,255);
  ellipse(pos.x, pos.y, 50, 50);
}

PVector CalculateVector(PVector firstPosition, PVector secondPosition) { //attracts first to second
  float dx = secondPosition.x - firstPosition.x;
  float dy = secondPosition.y - firstPosition.y;
  float distance = pow(dx,2) + pow(dy,2); //r^2
  float F = (G * 10000) / distance; 
  
  float normalizedDX = map(dx, 0, width, 0, 1);
  float normalizedDY = map(dy, 0, height, 0, 1);
  PVector result = new PVector(normalizedDX * F, normalizedDY * F);
  return result;
}
