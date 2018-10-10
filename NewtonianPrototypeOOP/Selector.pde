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
     stroke(255);
     ellipse(position.x, position.y, dimensions.x, dimensions.y);
  }
}
