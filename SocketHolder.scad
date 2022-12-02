borderTop = 1.5;//approximate thickness of the top/bottom border (not exact due to slate stuff)
borderSides=.8; // approximate thickness of the side borders
offset = 1.5; // approximate distance between the sockets (seting to zero can cause sockets overlapping openscad doesn't like that)
slantOffset =2.5; //manually coded lengthening to account for the slant being taller than the sockets if there are knotches in the end of the socket holes increase this to length the whole thing until they go away
slantThickness=6; // manually coded approximate thickness for the slant below the socket regular base. If for some reason you want the bottom of a slant to be thicker increase this ( I did for my vase mode hacking)
oversize=0.5; // manually coded oversize value if your printer undersizes stuff you could bump this up to account for it. this only oversizes the diameters

socketListInch = 0;

selectParm = socketListInch==0? 1: 0; // select parameter for CLI interface
SocketSelecter = selectParm;

socketList =  //this is the list of actual socket sizes Yes this selection thing looks like a weird mess I couldn't figure out how to do this with regular if statements so this is what I made (seems to work though) if you want to add more you should be able to duplicate and entry from SocketSelector to ]: and put it between the ending : and 0
//If you don't want to deal with this "garbarge" I made you can add -D "socketList = [[50,20],[50,15]]" in a command line run of it.
SocketSelecter==0? 
vecInchToMM(socketListInch)
: 
SocketSelecter==1? [ //1/2 inch drive deep sockets Quinn set Imperial
[76.2,22.098],
[76.2,22.098],
[76.2,22.352],
[76.2,24.0284],
[76.2,26.035]]
: 
SocketSelecter==2? [
[76.2,27.94],
[76.2,29.845],
[76.2,31.877],
[76.2,33.8582],
]:
SocketSelecter==3? [ //3/8 inch drive deep sockets Quinn set Imperial
[62.83,17.00],
[62.83,17.00],
[62.83,17.90],
[62.83,19.88],
[62.83,21.80],
]:
SocketSelecter==4?[
[62.83,23.90],
[62.83,25.90],
[62.83,27.81],
[62.83,29.80]
]:
SocketSelecter==5? [ //1/4 inch drive deep sockets Quinn set Imperial
[50,12.00],
[50,12.00],
[50,12.00],
[50,12.00],
[50,12.00],
]:
SocketSelecter==6?[ 
[50,13.25],
[50,14.80],
[50,15.95],
[50,17.95],
[50,20.00]
]:
SocketSelecter==7?[ //1/2 inch drive deep sockets Quinn set Metric
[77.00,22.20],
[77.00,22.20],
[77.00,22.20],
[77.00,22,20],
[77.00,24.10],
]:
SocketSelecter==8?[
[77.00,26.00],
[77.00,26.10],
[77.00,27.90],
[77.00,30.00],
[77.00,32.00]
]:
SocketSelecter==9?[ //3/8 inch drive deep sockets Quinn set Metric
[63.25,17.00],
[63.25,17.00],
[63.25,18.00],
[63.25,18.00],
[63.25,20.00]
]: 
SocketSelecter==10?[
[63.25,22.00],
[63.25,22.00],
[63.25,24.10],
[63.25,26.00],
[63.25,26.00]
]:
SocketSelecter==11?[//1/4 inch drive deep sockets Quinn set Metric
[50,12.05],
[50,12.05],
[50,12.05],
[50,12.05],
[50,12.05],
]:
SocketSelecter==12?[
[50,13.50],
[50,14.00],
[50,16.00],
[50,17.00],
[50,18.10],
[50,20.00]
]:
SocketSelecter==13?[//sparkPlug Sockets 1/2 & 3/8
[65.10,22.10],
[65.10,22.10],
[65.10,28.00],
[65.10,28.00]
]:0;

inch = false;
function inchToMM(x) = x*25.4;
function vecInchToMM(x)=[ for(vec = x)[inchToMM(vec[0]),inchToMM(vec[1])]];
function sum(v, i=0, r=0) = i < len(v) ? SUM(v, i+1, r+v[i]) :r;

function sumVec(v, i=0, r=0, index=0) = i < len(v) ? sumVec(v, i+1, r+v[i][index], index) :r;

function maxVec(v, i=0, index=0) = i < len(v)?
    v[i][index] > maxVec(v, i+1, index)? v[i][index]: maxVec(v, i+1,index):0;
    
module Sockets(socketSizes, inch = true){
module Socket(length,diameter){
    cylinder(length,d=diameter+oversize, $fn=90);           
}
function offsetTotal(set, a) = a==0 ? set[0][1]+oversize : set[a][1]+oversize + offsetTotal(set,a-1);
    
for(a = [0 : len(socketSizes) - 1 ])
{
        translate([(offsetTotal(socketSizes,a)-(socketSizes[a][1]+oversize)/2)+ (offset*a)+borderSides,0,0]){
            Socket(socketSizes[a][0],socketSizes[a][1]);
        }   
}

}


module SocketsSlant(socketSizes, inch = true){
module Socket(length,diameter){
    cylinder(length,d=diameter+oversize, $fn=90);           
}
function offsetTotal(set, a) = a==0 ? set[0][1]+oversize : set[a][1]+oversize + offsetTotal(set,a-1);
    
for(a = [0 : len(socketSizes) - 1 ])
{
    hull(){
    for(b=[0:1])
    {
        translate([(offsetTotal(socketSizes,a)-(socketSizes[a][1]+oversize)/2)+ (offset*a)+borderSides,-b*10,0]){
            Socket(socketSizes[a][0],socketSizes[a][1]);
        }   
    }
}
}

}

TotalWidth = sumVec(socketList, index = 1)+((offset)*(len(socketList)))+(borderSides*2)+oversize*len(socketList);
MaxLength = maxVec(socketList, index = 0);
MaxThickness = maxVec(socketList, index =1)+oversize;
echo(socketList);
difference()
{
cube(size = [TotalWidth, MaxLength+borderTop*2+slantOffset, MaxThickness/2+slantThickness]);
translate([borderSides,borderTop+slantOffset,MaxThickness/2+slantThickness])
{
rotate([-90,0,0])
{
    Sockets(socketList, false);
    }
}
translate([borderSides,borderTop,MaxThickness/2+slantThickness-5])
{
    {
        {
            rotate([-80,0,0])
            {
                translate([0,0,0])
                {
                    SocketsSlant(socketList, false);
                }
            }
         }
     }
 }
};