circleDiameter =12;
circleThickness =1;
circleHeight =12;
detailLevel = 30;
overlapPercentage = 0.65;

module repeatCircle() {
difference () {
cylinder(d=circleDiameter,h=circleHeight, center =true, $fn=detailLevel);
cylinder(d=circleDiameter-2*circleThickness,h=circleHeight, center =true, $fn= detailLevel) ;
}
} 
for( i=[0:10]) {
for( j=[0:10]) {
translate ([i*circleDiameter*overlapPercentage, j*circleDiameter*overlapPercentage , 0] ) 
repeatCircle();
}
} 