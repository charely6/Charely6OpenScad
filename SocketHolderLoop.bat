for /l %%x in (1,1,13) do (
"C:\Program Files\OpenSCAD\openscad.exe" -o socketHolder%%x.stl -D "selectParm=%%x" SocketHolder.scad
)