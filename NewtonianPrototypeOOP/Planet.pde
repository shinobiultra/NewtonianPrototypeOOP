class Planet {
  PVector position;
  PVector dimensions;
  PVector velocity;
  float mass;
  float friction;

  Planet(PVector initPositon, PVector initDimensions) {
    position = new PVector(initPositon.x, initPositon.y); 
    dimensions = new PVector(initDimensions.x, initDimensions.y);
    velocity = new PVector(0, 0);

    float radius = initDimensions.x / 2;
    mass = PI * pow(radius, 2); // area of the planet
    friction = mass / 10000; // fine-tune this
  }

  void render() {
    position.add(velocity);

    fill(dimensions.x, dimensions.y, dimensions.x);
    ellipse(position.x, position.y, dimensions.x, dimensions.y);
  }

  void calculateVelocity(ArrayList<Planet> allPlanets) {
    if (allPlanets.size() > 1) {
      for (Planet planet : allPlanets) {
        if (planet != this) {
          float distance = abs(PVector.dist(position, planet.position));
          float Force = gravityForce(distance, planet.mass);
          println("Dist: " + distance + "F : " + Force);
          PVector forceVector = PVector.sub(planet.position, position);
          forceVector.normalize();
          forceVector.mult(Force);
          forceVector.mult(friction);
          velocity.add(forceVector);
        }
      }
    }
    println("Position: " + position + "  Velocity: " + velocity);
  }

  private float gravityForce(float distance, float planetMass) {
    float F = G * ((mass*planetMass) / pow(distance, 2));
    return F;
  }
}
