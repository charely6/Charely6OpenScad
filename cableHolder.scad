module cableHole() {
translate ([0,0,5])
cylinder (d1=6, d2=20,h=12,$fn=20,center=true) ;
cylinder (d=7.5, h=15,$fn=20, center =true );
translate ([0,5,2.5])
cube ([7.5,10,18], center =true );
}
$vpr = [65,0,145];
$vpd = 500;
halfWidth=80;
difference () {
hull() {
translate ([halfWidth,0,0])
cylinder (d1=10,d2=30,h=17,center=true);
translate ([-halfWidth,0,0])
cylinder (d1=10,d2=30,h=17,center=true);
} 
hull(){
    translate ([halfWidth,0,8.5])
    cylinder(d1=28, d2=30, h=3, center=true);
    translate ([-halfWidth,0,8.5])
    cylinder(d1=28, d2=30, h=3, center=true);
}
translate ([0,-17, 0])
cube ([200,20,20], center =true );
for(i=[-2:2]){
translate ([i*33,5,-2.5])
cableHole ();
}
translate ([halfWidth,0,0])
rotate ([-90,0,0]){
union () {
translate ([0,0,10])
cylinder (d=9,h=10,center =true) ;
cylinder (d=5,h=30,center =true) ;
} 
} 
translate ([-halfWidth,0,0])
rotate ([-90,0,0]){
union() {
translate ([0,0,10])
cylinder (d=9,h=10,center =true) ;
cylinder (d=5,h=30,center =true) ;
} 
} 
}














