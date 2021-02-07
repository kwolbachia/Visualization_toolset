# Visualization_toolset

This toolset intends to ease basic manipulation and visualization of multichannel images and stacks.

The Visualization_Toolset.ijm file has been written in the most
readable way possible (well I did my best) in order to be easily customized or adjusted.
For example if you don't like keyboard shortcuts, you can delete them or change the [key].

It provides 3 handy tools for images:

* __Splitview__ :
	For multichannel visualization,
	Splitview creates a RGB montage of composite and splited channels.
	Grayscale splitview creates a linear montage with colored overlay and grey channels.
	You can still navigate through slices or frames.

![image](https://github.com/kwolbachia/Visualization_toolset/blob/main/screenshots/Splitview.png)

* __Set image LUTs__ : 
	- A dialog let you select LUTs for each channels and then apply them to your multichannel image.

![image](https://github.com/kwolbachia/Visualization_toolset/blob/main/screenshots/Set_LUTs.png)

* __Auto-contrast Adjustment__ :
	- Especially usefull for stacks (but not restricted to), this macro resets the min and max based on the entire stack so you can navigate through slices without signal saturation. 


* Some tools for all opended images :

	- __Set all LUTs__ : applies the chosen LUTs to all images.
	
	- __Reset all contrasts__ : applies the contrast adjustment tool to all individual channels of all opened images.
	
	- __Maximum Z project all__ : Will run a maximal intensity projection on all opended stacks, close the  stacks and run "Tile" to see all windows.
	Can be handy to get a quick overview of hyperstacks content.
	
	- __Save all__ : Saves all opened images as Tiff in a specified directory.

* The must-have macro shortcut : (from Nick George)
	- [Q] easy switch between Color and Composite mode on multichannel images

* A collection of __keyboard shortcuts__ for some macros and additionnal shortcuts for frequently used commands when handling stacks or hyperstacks: 

	Macro shortcut :
	- [A] Enhance Contrast, saturated=0.3 : almost same as "Auto" button in Brightness tool
	- [r] Auto-contrast on active channel of selected image
	- [R] Auto-contrast on all channels of selected image
	- [S] Colored splitview tool
	- [p] Grayscale splitview 

	Frequently used commands :

	- [E] Tile : reorder windows to see all
	- [y] Open the usefull tool 'synchronize windows'
	- [q] Arrange channels order
	- [d] Split Channels
	- [M] Merge channels
	- [D] Duplicate (complete image or selection)
	- [g] Z projection dialog 
	- [G] run a maximal intensity projection
	- [T] Save as Tiff

* 6 numerical keys shortcuts for basic LUTs:
	- [n1]  Grays
	- [n2]  Green
	- [n3]  Red
	- [n4]  Cyan
	- [n5]  Magenta
	- [n6]  yellow

* __Installation :__
	- put the Visualization_toolset.ijm file in the toolset directory of your ImageJ or Fiji application.
	- You will now find the toolset in the toolset menu of imageJ bar [>>] button
