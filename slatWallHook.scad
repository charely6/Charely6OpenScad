widthOfHook = 20;
thicknessOfHook=3;
depthOfHook = 10;
lengthOfBar =140;
numberOfHoles = 3;
difference()
{
union(){
translate([-thicknessOfHook/2,0,0])
cube([thicknessOfHook, 16, widthOfHook], center=true);
translate([depthOfHook/2,8-thicknessOfHook/2,0])
cube([depthOfHook, thicknessOfHook, widthOfHook],center=true);

translate([depthOfHook+thicknessOfHook,lengthOfBar/2+16/2-thicknessOfHook,0])
cube([thicknessOfHook*3, lengthOfBar, widthOfHook], center=true);    
}
for(i=[0:numberOfHoles-1]){
translate([depthOfHook+thicknessOfHook,lengthOfBar-i*12-thicknessOfHook,0])
hole();
}
translate ([depthOfHook/2+4, 18+54,0]) 
cube ([2,30, widthOfHook],center =true ) ;
}


module hole(){
    rotate([0,90,0])
    color("red")
    union(){
    cylinder(h=thicknessOfHook*3, d=5, center=true);
    translate([0,0,-thicknessOfHook])
    #cylinder(h=thicknessOfHook, d1=10,d2=5,center=true);
    
    }
}
