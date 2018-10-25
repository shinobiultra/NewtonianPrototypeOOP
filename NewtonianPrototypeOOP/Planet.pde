class Planet {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector dimensions;

  float mass;
  float friction;
  float radius;

  boolean collided;
  public Planet(PVector initPositon, PVector initDimensions) {
    position = new PVector(initPositon.x, initPositon.y); 
    dimensions = new PVector(initDimensions.x, initDimensions.y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    radius = initDimensions.x / 2;
    mass = PI * pow(radius, 2); // area of the planet
  }

  public void render() {
    fill(radius*2, radius/2, radius*2);
    stroke(0);
    ellipse(position.x, position.y, dimensions.x, dimensions.y);
  }

  public void move() {
    velocity.add(acceleration);
    acceleration.mult(0);
    position.add(velocity);
  }

  public void calculateVelocity(ArrayList<Planet> allPlanets) {
    if (allPlanets.size() > 1) {
      for (Planet planet : allPlanets) {
        if (planet != this) {
          if (checkCollision(planet) && !collided && !planet.collided) {
            collided = true;
            planet.collided = true;
            PVector moveVector = PVector.sub(position, planet.position);
            float moveAmount = planet.radius + radius - position.dist(planet.position);
            //float massRatio = mass / planet.mass;
            //moveAmount = moveAmount / 2;
            //moveVector.setMag(moveAmount);
            //position.sub(moveVector);
            //velocity.add(planet.velocity);
            applyForce(moveVector.setMag(planet.mass * planet.velocity.mag()));
            planet.applyForce(moveVector.setMag(mass * velocity.mag() * -1));
            
            continue;
          }
          PVector forceVector = PVector.sub(planet.position, position);
          float distanceSq = forceVector.magSq();
          float Force = gravityForceSq(distanceSq, planet.mass);
          forceVector.normalize();
          forceVector.mult(Force/mass);
          acceleration.add(forceVector);
          collided = false;
          planet.collided = false;
        }
      }
    }
  }

  public boolean isPointIn(float x, float y) {
    float lx = position.x - radius;
    float ly = position.y - radius;
    if (x >= lx && x <= (lx + dimensions.x) && y >= ly && y <= (ly + dimensions.y)) {
      return true;
    }
    return false;
  }

  public boolean checkCollision(Planet planet) {
    float distance = position.dist(planet.position);
    if (distance <= radius + planet.radius) {
      return true;
    }
    return false;
  }

  public void applyForce(PVector force) {
    PVector F = force.copy();
    acceleration.add(F.div(mass));
  }

  private float gravityForce(float distance, float planetMass) {
    float F = G * mass*planetMass / pow(distance, 2);
    return F;
  }

  private float gravityForceSq(float distanceSq, float planetMass) {
    float F = G * mass*planetMass / distanceSq;
    return F;
  }

  private float momentumForce() {
    PVector acc = acceleration.copy();
    return acc.mult(mass).mag();
  }
}
