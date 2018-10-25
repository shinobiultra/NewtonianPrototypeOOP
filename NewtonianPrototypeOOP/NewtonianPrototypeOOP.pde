ArrayList<Planet> planets;
Selector selector;


float G = 0.1;
float distThreshold = 50;
boolean paused = false;
boolean randomizeSelector = false;
void setup() {
  size(1280, 720);

  planets = new ArrayList<Planet>();
  selector = new Selector();
  //frameRate(5);
}

void draw() {
  background(240, 240, 255); 

  if (!paused) {
    for (Planet planet : planets) {
      planet.calculateVelocity(planets);
      planet.move();
      planet.render();
      println(planet.velocity.mag());
    }
  } else {
    for (Planet planet : planets) {
      planet.render();
    }
  }
  selector.display();
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  selector.dimensions.add(-e, -e);
  if (selector.dimensions.x < 1) {
    selector.dimensions.set(1, 1);
  }
}

void mousePressed() {
  planets.add(new Planet(selector.position, selector.dimensions));
  if (randomizeSelector) {
    int rndSize = int(random(1, 100));
    selector.dimensions.set(rndSize, rndSize);
  }
}

void keyPressed() {
  if (key == ' ') {
    paused = !paused;
  } else if (key == 'r' || key == 'R') {
    randomizeSelector = !randomizeSelector;
  }
}
