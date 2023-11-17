module cableHole() {
translate ([0,0,5])
cylinder (d1=6, d2=18,h=10,$fn=20,center=true) ;
cylinder (d=7.5, h=10,$fn=20, center =true );
translate ([0,5,2.5])
cube ([7.5,10,15], center =true );
}
difference () {
hull() {
translate ([70,0,0])
cylinder (d1=10,d2=30,h=15,center=true);
translate ([-70,0,0])
cylinder (d1=10,d2=30,h=15,center=true);
} 
translate ([0,-15, 0])
cube ([200,20,20], center =true );
for(i=[-3:3]){
translate ([i*20,5,-2.5])
cableHole ();
}
translate ([70,0,0])
rotate ([-90,0,0]){
union () {
translate ([0,0,10])
cylinder (d=9,h=10,center =true) ;
cylinder (d=5,h=30,center =true) ;
} 
} 
translate ([-70,0,0])
rotate ([-90,0,0]){
union() {
translate ([0,0,10])
cylinder (d=9,h=10,center =true) ;
cylinder (d=5,h=30,center =true) ;
} 
} 
}
echo("test");













