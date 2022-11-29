borderTop = 1.5;
borderSides=.8;
offset = 1;
Thinner = 8;
slantOffset =2.1;

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
[76.2,22.098],//[3,0.870],
[76.2,22.098],//[3,0.870],
[76.2,22.352],//[3,0.88],
[76.2,24.0284],//[3,0.946],
[76.2,26.035],//[3,1.025],
//[76.2,27.94],//[3,1.1],    //1/2 drive     13/16 inch
//[76.2,29.845],//[3,1.175],  //1/2 drive     7/8 inch
//[76.2,31.877],//[3,1.255],  //1/2 drive     15/16 inch
//[76.2,33.8582],//[3,1.333] //1/2 drive     1 inch
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
    cylinder(length,d=diameter, $fn=90);
            
}


function offsetTotal(set, a) = a==0 ? set[0][1] : set[a][1] + offsetTotal(set,a-1);
    
for(a = [0 : len(socketSizes) - 1 ])
{
    if(inch){
        translate(
        [inchToMM((offsetTotal(socketSizes,a)-(socketSizes[a][1])/2)+(offset*a)+borderSides),0,0]){
            Socket(inchToMM(socketSizes[a][0]),inchToMM(socketSizes[a][1]));
        } 
    }
    else{
        translate([(offsetTotal(socketSizes,a)-(socketSizes[a][1])/2)+ (offset*a)+borderSides,0,0]){
            Socket(socketSizes[a][0],socketSizes[a][1]);
        }
    }
}

}


TotalWidth = sumVec(socketList, index = 1)+(offset*(len(socketList)-1))+(borderSides*2);
MaxLength = maxVec(socketList, index = 0);
MaxThickness = maxVec(socketList, index =1);
echo (TotalWidth);


difference()
{
cube(size = [TotalWidth+borderSides*2, MaxLength+borderTop*2+slantOffset, MaxThickness-Thinner]);
translate([borderSides,borderTop+slantOffset,MaxThickness-Thinner]){
rotate([-90,0,0])
{
    Sockets(socketList, false);
    }
}
translate([borderSides,borderTop,MaxThickness-(Thinner+5)])
            {
for(a=[0:4])
    {
    rotate([-80,0,0])
{
translate([0,-a,0])
        {

    Sockets(socketList, false);
    }
}
}
}
}


