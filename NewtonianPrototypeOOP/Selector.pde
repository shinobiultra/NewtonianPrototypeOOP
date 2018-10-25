class Selector {
  PVector position;
  PVector dimensions;
  
  Selector(){
    position = new PVector(mouseX, mouseY);
    dimensions = new PVector(10, 10); 
  }
  
  void display(){
     position.x = mouseX;
     position.y = mouseY;
     
     noFill();
     color actColor = get(mouseX, mouseY);
     stroke(255-red(actColor), 255-green(actColor), 255-blue(actColor));
     ellipse(position.x, position.y, dimensions.x, dimensions.y);
  }
}
