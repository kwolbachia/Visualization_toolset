# Visualization_toolset

There is a lot of great tools and plugins for Imagej to process, analyze and get statistical data from images. 
But it can be tedious for pure visualization and basic handling of multichannels stacks.
This toolset intends to ease manipulation and basic visualization of multichannel images and stacks.

Note : The Visualization_Toolset.ijm file has been written in the most
readable way possible (well I did my best) in order to be easily customized or adjusted.
For example if you don't like keyboard shortcuts, you can delete them or change the [key].

It provides 3 handy tools for images:

* Splitview :
	For multichannel visualization,
	Splitview creates a RGB montage of composite and splited channels.
	Grayscale splitview creates a linear montage with colored overlay and grey channels.
	You can still navigate through slices or frames.

* Set image LUTs : 
	A dialog let you select LUTs for each channels and then apply them to your multichannel image.

* Auto-contrast Adjustment :
	Especially usefull for stacks (but not restricted to), this macro resets the min and max based on the entire stack so you can navigate through slices without signal saturation. 


* Some tools for all opended images :

	- Set all LUTs : applies the chosen LUTs to all images.
	
	- Reset all contrasts : applies the contrast adjustment tool to all individual channels of all opened images.
	
	- Maximum Z project all : Will run a maximal intensity projection on all opended stacks, close the  stacks and run "Tile" to see all windows.
	Can be handy to get a quick overview of hyperstacks content.
	
	- Save all : Saves all opened images as Tiff in a specified directory.

* The must-have macro shortcut : (from Nick George)
	- [Q] easy switch between Color and Composite mode on multichannel images

* And finally a collection of keyboard shortcuts for some of the tools and for what I think are frequently used commands in Imagej when handling stacks or hyperstacks: 

	Macro shortcut :
	- [A] Enhance Contrast, saturated=0.3 : almost same as "Auto" button in Brightness tool
	- [E] Tile : reorder windows to see all
	- [R] Auto-contrast on all channels of selected image
	- [r] Auto-contrast on active channel of selected image
	Frequently used commands
	- [y] Open the usefull tool 'synchronize windows'
	- [q] Arrange channels order
	- [S] Splitview : shortcut for the colored splitview tool
	- [p] Grayscale splitview shortcut
	- [d] Split Channels
	- [D] Duplicate (complete image or selection)
	- [M] Merge channels
	- [g] Z projection dialog 
	- [G] run a maximal intensity projection
	- [T] Save as Tiff

* Finally, 6 numerical keys shortcuts for basic LUTs:
	- [n1]  Grays
	- [n2]  Green
	- [n3]  Red
	- [n4]  Cyan
	- [n5]  Magenta
	- [n6]  yellow

