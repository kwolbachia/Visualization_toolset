# Visualization_toolset

This toolset intends to ease basic manipulation and visualization of multichannel images and stacks.

* __Installation :__
	- Download this repository as .zip by clicking the green button "Code" and unzip it
	- Place the Visualization_toolset.ijm file in the toolset directory of your ImageJ or Fiji application. (ImageJ/Macros/toolsets)
	- You will now find the toolset in the "More Tools" menu of imageJ bar ( [>>] button ).

It provides handy tools for images:

* __Splitview__ :
	For multichannel visualization,
	Splitview creates a RGB montage of composite and splited channels.
	Grayscale splitview creates a linear montage with colored overlay and grey channels.
	You can still navigate through slices or frames.
	In the menu icon, the "Special Splitview" let you choose all color and layout combinasion, with also the possibilitty to add channel labels with colors corresponding to LUTs.

![image](https://github.com/kwolbachia/Visualization_toolset/blob/main/screenshots/Splitview.png)

* __Set image LUTs__ : 
	- A dialog let you select LUTs for each channels and then apply them to your multichannel image. Also possible to set LUTs of all opened images.

![image](https://github.com/kwolbachia/Visualization_toolset/blob/main/screenshots/Set_LUTs.png)

* __Auto-contrast Adjustment__ :
	- Especially usefull for stacks (but not restricted to), this macro resets the min and max based on the entire stack so you can navigate through slices without signal saturation. 

* __gammaLUT Adjustment__ :
	- By only modifying the active LUT of the channel, this tool gives the same visual result than the gamma from the Process/Math menu of imageJ.
	The pixels data isn't modified. It can be applied on a single channel, all channels, all opened images. If you don't like the result, you can reset the primary LUT (for example Cyan).

* Some tools for all opended images :
	
	- __Reset all contrasts__ : runs the auto-contrast tool on all individual channels of all opened images.
	
	- __Maximum Z project all__ : Will run a maximal intensity projection on all opended stacks, close the stacks and run "Tile" to arrange all windows.
	Can be handy to get a quick overview of hyperstacks content.
	
	- __Save all__ : Saves all opened images as Tiff in a specified directory.

* The must-have macro shortcut : (found from Nick George)
	- [Q] easy switch between Color and Composite mode on multichannel images.
	with the settings icon, you can choose to either switch between composite and color / grayscale / or cycle the three.

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
* now when you press space and numerical keys from 1 to 7, you can toggle the corresponding channels.
And if you maintain alt and numercial keys, it works the same for all opened images.


