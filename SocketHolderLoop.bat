for /l %%x in (8,1,13) do (
"C:\Program Files\OpenSCAD\openscad.exe" -o socketHolder%%x.stl -D "selectParm=%%x" SocketHolder.scad
)