widthOfHook = 20;
thicknessOfHook=3;
depthOfHook = 10;
lengthOfBar =160;
numberOfHoles = 3;
difference()
{
union(){
translate([-thicknessOfHook/2,0,0])
cube([thicknessOfHook, 16, widthOfHook], center=true);
translate([depthOfHook/2,8-thicknessOfHook/2,0])
cube([depthOfHook, thicknessOfHook, widthOfHook],center=true);

translate([depthOfHook+thicknessOfHook*1.25,lengthOfBar/2+16/2-thicknessOfHook,0])
cube([thicknessOfHook*3.5, lengthOfBar, widthOfHook], center=true);    
}
for(i=[0:numberOfHoles-1]){
translate([depthOfHook+thicknessOfHook,lengthOfBar-i*12-thicknessOfHook,0])
hole();
}
translate ([depthOfHook/2+6, 18+54+12,0]) 
cube ([7,50, widthOfHook*1.2],center =true ) ;
}


module hole(){
    rotate([0,90,0])
    color("red")
    union(){
    cylinder(h=thicknessOfHook*4, d=5, center=true);
    translate([0,0,-thicknessOfHook])
    #cylinder(h=thicknessOfHook, d1=10,d2=5,center=true);
    
    }
}
