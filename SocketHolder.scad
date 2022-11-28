border = 0;
offset = 0.1;
overSize = 0;

/*socketList = [
[3,0870],
[3,0870],
[3,0880],
[3,0946],
[3,1025],
[3,1100],    //1/2 drive     13/16 inch
[3,1175],  //1/2 drive     7/8 inch
[3,1255],  //1/2 drive     15/16 inch
[3,1333] //1/2 drive     1 inch
];
*/

socketList = [
[3,0.870],
[3,0.870],
[3,0.88],
[3,0.946],
[3,1.025],
[3,1.1],    //1/2 drive     13/16 inch
[3,1.175],  //1/2 drive     7/8 inch
[3,1.255],  //1/2 drive     15/16 inch
[3,1.333] //1/2 drive     1 inch
];
/*
socketList = [
[77,26],
[77,26]
];
*/
inch = false;
function inchToMM(x) = x*25.4;

function sum(v, i=0, r=0) = i < len(v) ? SUM(v, i+1, r+v[i]) :r;

function sumVec(v, i=0, r=0, index=0) = i < len(v) ? sumVec(v, i+1, r+v[i][index], index) :r;

function maxVec(v, i=0, index=0) = i < len(v)?
    v[i][index] > maxVec(v, i+1, index)? v[i][index]: maxVec(v, i+1,index):0;
    

module Sockets(socketSizes, inch = true){

module Socket(length,diameter){
    cylinder(length+overSize,d=diameter+overSize, $fn=90);
        echo("Diameter");
        echo(diameter);
            
}


function offsetTotal(set, a) = a==0 ? set[a][1] : set[a][1] + offsetTotal(set,a-1);
    
for(a = [0 : len(socketSizes) - 1 ])
{
    if(inch){
        translate([inchToMM((+offsetTotal(socketSizes,a)-(socketSizes[a][1]+overSize)/2)),0,0]){
            Socket(inchToMM(socketSizes[a][0]),inchToMM(socketSizes[a][1]));
        } 
    }
    else{
        translate([(offsetTotal(socketSizes,a)-(socketSizes[a][1]+overSize)/2),0,0]){
            echo("translate");
            echo(((socketSizes[a][1]+overSize)/2)+offsetTotal(socketSizes,a));
            Socket(socketSizes[a][0],socketSizes[a][1]);
        }
    }
}

}


TotalWidth = sumVec(socketList, index = 1)+offset*len(socketList)+(border*2);
MaxLength = maxVec(socketList, index = 0);
MaxThickness = maxVec(socketList, index =1);
echo(TotalWidth);
echo(MaxLength);
echo(MaxThickness);

difference(){
cube(size = [inchToMM(TotalWidth)+15, inchToMM(MaxLength) +9, inchToMM(MaxThickness)-10]);
translate([0,6,inchToMM(MaxThickness)-10]){
rotate([-90,0,0])
{
    Sockets(socketList);
    }
}
for(a=[0:4]){
translate([0,-a/6,a]){
translate([0,3,inchToMM(MaxThickness)-15]){
    rotate([-80,0,0])
    {
    Sockets(socketList);
    }
}
}
}
}


