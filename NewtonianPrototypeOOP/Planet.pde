class Planet {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector dimensions;

  float mass;
  float friction;
  float radius;

  Planet(PVector initPositon, PVector initDimensions) {
    position = new PVector(initPositon.x, initPositon.y); 
    dimensions = new PVector(initDimensions.x, initDimensions.y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    radius = initDimensions.x / 2;
    mass = PI * pow(radius, 2); // area of the planet
  }

  void render() {
    velocity.add(acceleration);
    acceleration.mult(0);
    position.add(velocity);

    fill(radius*2, radius/2, radius*2);
    stroke(0);
    ellipse(position.x, position.y, dimensions.x, dimensions.y);
  }

  void calculateVelocity(ArrayList<Planet> allPlanets) {
    if (allPlanets.size() > 1) {
      for (Planet planet : allPlanets) {
        if (planet != this) {
          PVector forceVector = PVector.sub(planet.position, position);
          float distanceSq = forceVector.magSq();
          float Force = gravityForceSq(distanceSq, planet.mass);
          forceVector.normalize();
          forceVector.mult(Force/mass);
          acceleration.add(forceVector);
        }
      }
    }
    /*
    if (position.x > width || position.x < 0) {
      velocity.x *= -1;
    }
    if (position.y > height || position.y < 0) {
      velocity.y *= -1;
    }*/
    //println("Position: " + position + "  Velocity: " + velocity);
  }
  
  boolean isPointIn(float x, float y){
    float lx = position.x - radius;
    float ly = position.y - radius;
    if(x >= lx && x <= (lx + dimensions.x) && y >= ly && y <= (ly + dimensions.y)){
      return true;
    }
    return false;
  }

  private float gravityForce(float distance, float planetMass) {
    float F = G * mass*planetMass / pow(distance, 2);
    return F;
  }
  
  private float gravityForceSq(float distanceSq, float planetMass) {
    float F = G * mass*planetMass / distanceSq;
    return F;
  }
}
