
offset = .0001;

socketList = [
[3,1.1],    //1/2 drive     13/16 inch
[3,1.175],  //1/2 drive     7/8 inch
[3,1.255],  //1/2 drive     15/16 inch
[3,1.333] //1/2 drive     1 inch
];
function inchToMM(x) = x*25.4;

function sum(v, i=0, r=0) = i < len(v) ? SUM(v, i+1, r+v[i]) :r;

function sumVec(v, i=0, r=0, index=0) = i < len(v) ? sumVec(v, i+1, r+v[i][index], index) :r;

function maxVec(v, i=0, index=0) = i < len(v)?
    v[i][index] > maxVec(v, i+1, index)? v[i][index]: maxVec(v, i+1,index):0;
    

module Sockets(socketSizes, inch = true){

module Socket(length,diameter, inch = true){
    if(inch){
    cylinder(inchToMM(length)+0.5,d = inchToMM(diameter)+0.5, $fn=90);
    }
    else{
    cylinder(length+0.5,d=diameter+0.5, $fn=90);
    }
    
}


function offsetTotal(set, a) = a==0 ? 0 : set[a][1] + offsetTotal(set,a-1)+offset;
    
for(a = [0 : len(socketSizes) - 1 ])
{
    if(inch){
        translate([inchToMM((socketSizes[a][1]/2)+offsetTotal(socketSizes,a))+5,0,0]){
            Socket(socketSizes[a][0],socketSizes[a][1]);
        }
    }
    else{
        translate([(socketSizes[a][1]/2)+offsetTotal(socketSizes,a)+5,0,0]){
            Socket(socketSizes[a][0],socketSizes[a][1]);
        }
    }
}

}


TotalWidth = sumVec(socketList, index = 1)+offset*len(socketList);
MaxLength = maxVec(socketList, index = 0);
MaxThickness = maxVec(socketList, index =1);

echo(TotalWidth);
echo(MaxLength);
echo(MaxThickness);
difference(){
cube(size = [inchToMM(TotalWidth)+15, inchToMM(MaxLength) +15, inchToMM(MaxThickness)]);
translate([0,6,inchToMM(MaxThickness)]){
rotate([-90,0,0])
{
    Sockets(socketList);
    }
}
for(a=[0:4]){
translate([0,-a/6,a]){
translate([0,3,inchToMM(MaxThickness)-5]){
    rotate([-80,0,0])
    {
    Sockets(socketList);
    }
}
}
}
}



