# Charely6OpenScad
My OpenScad Projects
Place to put my OpenScad projects as I make them.

## CableHolder
working on a wall mounted cableholer for beefy cables (display or tower power) this is my current version


## MakeupHolder
someone on reddit wanted one of those rubbery makeup or whatever holders built into gridfinity and someone else mentioned it could be done in openscad and I got carried away


## SocketHolder
This is custom socket holder. Mostly for Deepwell sockets I guess it could be used for shallow ones but I didn't really design it for that.

By making a list of socket measurements using millimeters and putting in this format [Length,Diameter] and putting them together in a list it will generate a holder to hold all these sockets.

Its not perfect there is kind of a range of sizes that work. the 1/4 drive ones included are a little small for the slant (because the slant is a bit more hard coded than I would like) but I think they work okay.

The batch script included will generate all of them in just numbered stls rather than proper named ones (might change this who knows) they do take a bit to generate, because the way I am making the slant is not very efficent or that good. I would love to learn about a better way to do it.

I have been playing with printing them in vase mode using a janky "structural" vase mode hack in the slicer by adding really flat negative volume blocks. If it turns out well and I like them if I have time I might try to impliment them here in openscad so they will be toggleable.

If anyone out there has a better way to get all the socket outside dimensions of a set without measuring each one that could be cool and I would love to hear about it. (probably would impliment it in python or something and call this with cli, who know).
