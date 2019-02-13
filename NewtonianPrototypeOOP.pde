ArrayList<Planet> planets;
Selector selector;

float G = 0.05;
boolean paused = false;
boolean randomizeSelector = false;
boolean showGravity = false;
boolean rollOver = false;

float gravGranularity = 10;
void setup() {
  size(1280, 720);
  //fullScreen();
  planets = new ArrayList<Planet>();
  selector = new Selector();
}

void draw() {
  background(10); 

  if (showGravity) {
    displayGravitationalField();
  }

  if (!paused) {
    for (Planet planet : planets) {
      if (!planet.isStatic) {
        planet.calculateVelocity(planets);
        planet.move();
      }
      planet.render();
    }
  } else {
    for (Planet planet : planets) {
      planet.render();
    }
    strokeWeight(8);
    stroke(255, 0, 0);
    noFill();
    rect(0, 0, width, height);
  }
  selector.display();

  fill(255);
  textSize(16);
  text("G: " + G + " [+/-]", 20, 20);
  text("Showing Grav: " + showGravity + " [G]", 20, 40);
  text("Grav. granularity: " + gravGranularity + " [,/.]", 20, 60);
  text("Roll Over: " + rollOver + " [O]", 20, 80);
}

void mouseWheel(MouseEvent event) {
  float e = event.getCount();
  selector.dimensions.add(-e, -e);
  if (selector.dimensions.x < 1) {
    selector.dimensions.set(1, 1);
  }
}

void mousePressed() {
  if (mouseButton == RIGHT) {
    if (selector.isAdding) {
      selector.addedPlan.applyForce(selector.addedPlan.position.copy().sub(selector.position).mult(selector.dimensions.x));
      selector.isAdding = false;
    } else {
      planets.add(new Planet(selector.position, selector.dimensions, selector.creatingStatic));
      selector.addedPlan = planets.get(planets.size()-1);
      selector.isAdding = true;
    }
  } else if (!selector.isAdding) {
    planets.add(new Planet(selector.position, selector.dimensions, selector.creatingStatic));
  }
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
  } else if (key == 's' || key == 'S') {
    selector.creatingStatic = !selector.creatingStatic;
  } else if (key == 'q' || key == 'Q') {
    planets.clear();
  } else if (key == '+') {
    G += 0.01;
  } else if (key == '-') {
    G -= 0.01;
  } else if (key == 'g' || key == 'G') {
    showGravity = !showGravity;
  } else if (key == '.') {
    gravGranularity++;
  } else if (key == ',') {
    if (gravGranularity > 1) {
      gravGranularity--;
    }
  } else if (key == 'o' || key == 'O'){
    rollOver = !rollOver; 
  }
}

void displayGravitationalField() {
  for (int x = 0; x < width; x+=gravGranularity) {
    for (int y = 0; y < height; y+=gravGranularity) {
      PVector ForceSum = new PVector(0,0);
      for (Planet planet : planets) {
        PVector dist = planet.position.copy().sub(new PVector(x,y));
        float F = G * planet.mass / dist.magSq();
        ForceSum.add(dist.normalize().mult(F));
      }
      float r = ForceSum.magSq() * 100000;
      float b = ForceSum.magSq() * 200000;
      stroke(r, 0, b);
      fill(r, 0, b);
      square(x, y, gravGranularity);
    }
  }
}
