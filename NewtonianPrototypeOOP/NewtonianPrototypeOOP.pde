ArrayList<Planet> planets;
Selector selector;


float G = 0.01;
float distThreshold = 50;
void setup() {
  size(1280, 720);
  
  planets = new ArrayList<Planet>();
  selector = new Selector();
}

void draw() {
  background(24, 24, 81); 
  
  selector.display();
  for(Planet planet : planets){
    planet.calculateVelocity(planets);
    planet.render(); 
  }
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  selector.dimensions.add(-e, -e);
}

void mousePressed(){
  planets.add(new Planet(selector.position, selector.dimensions));
}
