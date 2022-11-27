include <functional.scad>

offset = .0001;

function inchToMM(x) = x*25.4;

function sum(v, i=0, r=0) = i < len(v) ? SUM(v, i+1, r+v[i]) :r;

function sumVec(v, i=0, r=0, index=0) = i < len(v) ? sumVec(v, i+1, r+v[i][index], index) :r;


module Sockets(socketSizes){

module Socket(length,diameter){
    cylinder(inchToMM(length),d = inchToMM(diameter));
}


function offsetTotal(set, a) = a==0 ? 0 : set[a][1] + offsetTotal(set,a-1)+offset;
    
for(a = [0 : len(socketSizes) - 1 ])
{
    translate([inchToMM((socketSizes[a][1]/2)+offsetTotal(socketSizes,a)),0,0]){
        Socket(socketSizes[a][0],socketSizes[a][1]);
    }
}

}

socketList = [
[3,1.1],    //1/2 drive     13/16 inch
[3,1.175],  //1/2 drive     7/8 inch
[3,1.255],  //1/2 drive     15/16 inch
[3,1.333] //1/2 drive     1 inch
];

TotalWidth = sumVec(socketList, index = 1);

echo(TotalWidth);

Sockets(socketList);



