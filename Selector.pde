class Selector {
  PVector position;
  PVector dimensions;
  boolean isAdding;
  boolean creatingStatic;
  Planet addedPlan;

  Selector() {
    position = new PVector(mouseX, mouseY);
    dimensions = new PVector(30, 30);
  }

  void display() {
    position.x = mouseX;
    position.y = mouseY;

    noFill();
    strokeWeight(1);
    color actColor = get(mouseX, mouseY);
    stroke(255-red(actColor), 255-green(actColor), 255-blue(actColor));
    ellipse(position.x, position.y, dimensions.x, dimensions.y);

    if (isAdding && !creatingStatic) {
      line(position.x, position.y, addedPlan.position.x, addedPlan.position.y);
      PVector distance = addedPlan.position.copy().sub(position);
      float dist = distance.mag();
      float Force = dist * dimensions.x;
      textSize(12);
      fill(0);
      text(int(Force), position.x, position.y);
      fill(255, 0, 0);
      text(int(Force), position.x + 1, position.y + 1);
    }
    if (creatingStatic) {
      textSize(dimensions.x / 2);
      float offsetX = textWidth('S') / 2;
      float offsetY = dimensions.x / 6;
      fill(0);
      text('S', position.x - offsetX, position.y + offsetY);
      fill(255, 0, 0);
      text('S', position.x + 1 - offsetX, position.y + 1 + offsetY);
    }
  }
}
