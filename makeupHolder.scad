circleDiameter =12;
circleThickness =1;
circleHeight =12;
detailLevel = 30;
overlapPercentage = 0.75;
arrayX=5;
arrayY=5;
gapThickness = 1;

module repeatCircle() {
difference () {
cylinder(d=circleDiameter,h=circleHeight, center =true, $fn=detailLevel);
cylinder(d=circleDiameter-2*circleThickness,h=circleHeight, center =true, $fn= detailLevel) ;
rotate ([0, 0, 45])
cube([gapThickness ,circleDiameter, circleHeight], center =true);
}
} 
  union() {
    for( i=[0:arrayX]) {
      for( j=[0:arrayY]) {
        translate ([i*circleDiameter*overlapPercentage, j*circleDiameter*overlapPercentage , 0]) 
           rotate([0,0,90*(j+i)])
             repeatCircle();
      }
    }
  }