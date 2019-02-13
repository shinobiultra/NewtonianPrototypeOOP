class Planet {
  PVector position;
  PVector velocity;
  PVector acceleration;
  PVector dimensions;

  float mass;
  float friction;
  float radius;

  boolean isStatic;
  ArrayList<PVector> trajectory;

  final int trajSize = 100; 
  public Planet(PVector initPositon, PVector initDimensions, boolean _isStatic) {
    position = new PVector(initPositon.x, initPositon.y); 
    dimensions = new PVector(initDimensions.x, initDimensions.y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);

    radius = initDimensions.x / 2;
    mass = PI * pow(radius, 2); // area of the planet

    isStatic = _isStatic;
    trajectory = new ArrayList<PVector>(trajSize);
  }

  public void render() {
    fill(255);
    stroke(0);
    strokeWeight(1);
    ellipse(position.x, position.y, dimensions.x, dimensions.y);

    if (trajectory.size() > 3) {
      for (int i = 0; i < trajectory.size() - 1; i++) {
        stroke(255, 30);
        PVector oP = trajectory.get(i);
        PVector sP = trajectory.get(i+1);
        line(oP.x, oP.y, sP.x, sP.y);
      }
    }
  }

  public void move() {
    velocity.add(acceleration);
    position.add(velocity);
    acceleration.mult(0);

    trajectory.add(0, position.copy());
    if (trajectory.size() > 100) {
      trajectory.remove(100);
    }
    if (rollOver) {
      if (position.x < 0) {
        position.x = width; 
        trajectory.clear();
      } else if (position.x > width) {
        position.x = 0;
        trajectory.clear();
      }
      if (position.y < 0) {
        position.y = height; 
        trajectory.clear();
      } else if (position.y > height) {
        position.y = 0;
        trajectory.clear();
      }
    }
  }

  public void calculateVelocity(ArrayList<Planet> allPlanets) {
    if (allPlanets.size() > 1) {
      for (Planet planet : allPlanets) {
        if (planet != this) {
          if (checkCollision(planet)) {
            PVector moveVector = PVector.sub(position, planet.position);

            if (!planet.isStatic) {
              applyForce(moveVector.setMag(planet.mass * planet.velocity.mag()));
              //planet.applyForce(moveVector.setMag(mass * velocity.mag() * -1));
            } else {
              applyForce(moveVector.setMag(planet.mass * planet.velocity.mag()));
            }
            continue;
          }
          PVector forceVector = PVector.sub(planet.position, position);
          float distanceSq = forceVector.magSq();
          float Force = gravityForceSq(distanceSq, planet.mass);
          forceVector.normalize();
          forceVector.mult(Force/mass);
          acceleration.add(forceVector);
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

  public boolean isPointInPrecise(float x, float y) {
    float dist = (x - position.x) * (x - position.x) + (y - position.y) * (y - position.y);
    return dist <= radius * radius;
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
