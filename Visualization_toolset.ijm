//Bundle of macros for image visualization and handling in ImageJ / Fiji
//kevin.terretaz@gmail.com

//1.0 210207
//1.1 210208 forgotten adjustments + up to 7 Set LUTs
//1.2 210215 bugs correction (Splitviews, Max all)
//1.3 210228 add settings for composite switch and auto-contrast icon
		  // add toggle channels shortcuts tools.
//1.4 210411 gammaLUTs, better SplitView and all images channel toggle key
//2.0 220704 remove gamma icon, add multiTool icon (with gammaLUT inside), add borders to SplitView
//3.0 230428 Big refont, add action bars, new tools for the MultiTool and web documentation
//3.1 231002 bug corrections, refactoring code and adding default border to splitviews

/*This is free and unencumbered software released into the public domain. Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled binary, for any purpose, commercial or non-commercial, and by any means.
In jurisdictions that recognize copyright laws, the author or authors of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of relinquishment in perpetuity of all present and future rights to this software under copyright law.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
For more information, please refer to <http://unlicense.org/>
*/

//for image window size backup (macro[2])
var POSITION_BACKUP_TITLE = "";
var X_POSITION_BACKUP = 300;
var Y_POSITION_BACKUP = 300;
var WIDTH_POSITION_BACKUP = 400;
var HEIGHT_POSITION_BACKUP = 400;

// for quick Set LUTs
var CHOSEN_LUTS = get_Pref_LUTs_List(newArray("Cyan","Magenta","Yellow","Red","Green","Blue","Grays","k_Blue","k_Magenta","k_Orange","k_Green"));
var NOICE_LUTs = 0;

// For split_View
var	COLOR_MODE = "Colored";
var MONTAGE_STYLE = "Linear";
var LABELS = "No labels";
var BORDER_SIZE = "Auto";
var FONT_SIZE = 30;
var CHANNEL_LABELS = newArray("GFP","RFP","DNA","Other","DIC");
var TILES = newArray(1);

// For MultiTool
var	MAIN_TOOL = "Move Windows";
var MULTITOOL_LIST = newArray("Move Windows", "Slice / Frame Tool", "LUT Gamma Tool", "Curtain Tool", "Magic Wand", "Scale Bar Tool", "Multi-channel Plot Tool");
var LAST_CLICK_TIME = 0;

//For wand tool
var WAND_BOX_SIZE = 5;
var ADD_TO_MANAGER = 0;
var TOLERANCE_THRESHOLD = 40;
var EXPONENT = 2;
var FIT_MODE = "None";

// title of the assigned target image : space + [7] key 
var TARGET_IMAGE_TITLE = ""; 

// for Scale Bar Tool
var REMOVE_SCALEBAR_TEXT = false; 

// for multitool switch
var LAST_TOOL = 0;

// for Action Bars
var ACTION_BAR_STRING = "";

//--------------------------------------------------------------------------------------------------------------------------------------
//		MULTI TOOL
//--------------------------------------------------------------------------------------------------------------------------------------
macro "Multi Tool (double click to configure) - icon:viz_toolset_1.png" {
	multi_Tool();
}
macro "Multi Tool (double click to configure) Options" {
	Dialog.createNonBlocking("Multitool Options");
	Dialog.addRadioButtonGroup("__________________ __ Main Tool : __________________ __", MULTITOOL_LIST, 4, 2, MAIN_TOOL);
	Dialog.addCheckbox("Remove text under scale bar?", REMOVE_SCALEBAR_TEXT);
	Dialog.addMessage("________________ Magic Wand options : ______________");
	Dialog.addNumber("Detection window size", WAND_BOX_SIZE);
	Dialog.addSlider("Tolerance estimation threshold", 0, 100, TOLERANCE_THRESHOLD);
	Dialog.addSlider("Adjustment speed", 1, 2, EXPONENT);
	Dialog.addCheckbox("Auto add ROI to manager?", ADD_TO_MANAGER);
	Dialog.addChoice("Fit selection? How?", newArray("None","Fit Spline","Fit Ellipse"), FIT_MODE);
	Dialog.addHelp("https://kwolby.notion.site/Multi-Tool-526950d8bafc41fd9402605c60e74a99");
	Dialog.show();
	MAIN_TOOL =				Dialog.getRadioButton();	
	REMOVE_SCALEBAR_TEXT = 	Dialog.getCheckbox();
	WAND_BOX_SIZE =			Dialog.getNumber();
	TOLERANCE_THRESHOLD =	Dialog.getNumber();
	EXPONENT =				Dialog.getNumber();
	ADD_TO_MANAGER =		Dialog.getCheckbox();
	FIT_MODE =				Dialog.getChoice();
	save_Main_Tool(MAIN_TOOL);
}

macro "Stacks Menu Built-in Tool" {}
// macro "LUT Menu Built-in Tool" {}

//--------------------------------------------------------------------------------------------------------------------------------------
//------POPUP
//--------------------------------------------------------------------------------------------------------------------------------------
var pmCmds = newMenu("Popup Menu",
	newArray("Set Main Tool", "Remove Overlay", "Duplicate...","Set LUTs","Set active path", "Set target image",
	 "-", "Record...", "Monitor Memory...","Control Panel...", "Startup Macros..."));
macro "Popup Menu" {
	command = getArgument(); 
	if 		(command == "Set Main Tool") 		show_main_Tools_Popup_Bar();
	else if (command == "Set LUTs") 			{get_LUTs_Dialog(); apply_LUTs();}
	else if (command == "Set active path") 		set_Active_Path();
	else if (command == "Set target image") 	set_Target_Image();
	else run(command); 
}

//--------------------------------------------------------------------------------------------------------------------------------------
//		PREVIEW OPENER
//--------------------------------------------------------------------------------------------------------------------------------------
macro "Preview Opener Action Tool - icon:viz_toolset_2.png"{
	if (!isOpen("Preview Opener.tif")) make_Preview_Opener();
}

//--------------------------------------------------------------------------------------------------------------------------------------
//		ACTION BARS
//--------------------------------------------------------------------------------------------------------------------------------------
var Action_Bars_Menu = newMenu("Action Bars Menu Tool", 
	newArray("Main Macro Shortcuts",
	"-", "Splitview Macros", "Numerical Keyboard Macros", "More Macros",
	"-", "Online Help"));
macro "Action Bars Menu Tool - icon:viz_toolset_3.png" {
	command = getArgument();
	if 		(command == "Main Macro Shortcuts")			show_All_Macros_Action_Bar();
	else if (command == "SplitView Macros")				show_SplitView_Bar();
	else if (command == "Numerical Keyboard Macros")	show_Numerical_Keyboard_Bar();
	else if (command == "More Macros")					show_Other_Macros();
	else if (command == "Online Help")					run("URL...", "url=[https://kwolby.notion.site/Macros-Shortcuts-f6a0cb526bcf4cb78ac72ff8cd29f30b]");
}

//--------------------------------------------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------------------------------------------

//NUMPAD KEYS
macro "[n0]"{
	if	(no_Alt_no_Space()) paste_Favorite_LUT();
	if (isKeyDown("space")) set_Favorite_LUT();	
}
macro "[n1]"{
	if	(no_Alt_no_Space()) run("Grays");
	if (isKeyDown("space")) toggle_Channel(1); 	
	if (isKeyDown("alt")) 	toggle_Channel_All(1); 	
}
macro "[n2]"{
	if (no_Alt_no_Space()) 	run("k_Green");	
	if (isKeyDown("space")) toggle_Channel(2); 	
	if (isKeyDown("alt")) 	toggle_Channel_All(2); 	
}
macro "[n3]"{
	if (no_Alt_no_Space()) 	run("Red");
	if (isKeyDown("space")) toggle_Channel(3); 	
	if (isKeyDown("alt")) 	toggle_Channel_All(3); 	
}
macro "[n4]"{
	if (no_Alt_no_Space()) 	run("k_Blue");	
	if (isKeyDown("space")) toggle_Channel(4); 	
	if (isKeyDown("alt")) 	toggle_Channel_All(4); 	
}
macro "[n5]"{
	if (no_Alt_no_Space()) 	run("k_Magenta");	
	if (isKeyDown("space")) toggle_Channel(5); 	
	if (isKeyDown("alt")) 	toggle_Channel_All(5); 	
}
macro "[n6]"{
	if (no_Alt_no_Space()) 	run("k_Orange");	
	if (isKeyDown("space")) toggle_Channel(6); 	
	if (isKeyDown("alt")) 	toggle_Channel_All(6); 	
}
macro "[n7]"{
	if (no_Alt_no_Space()) 	run("Cyan");	
	if (isKeyDown("space")) toggle_Channel(7);	
	if (isKeyDown("alt")) 	toggle_Channel_All(7); 	
}
macro "[n8]"{
	if (no_Alt_no_Space()) 	run("Magenta");	
	if (isKeyDown("space")) run("8-bit"); 		
	if (isKeyDown("alt")) 	run("16-bit");		 	
}
macro "[n9]"{
	if (no_Alt_no_Space()) 	run("Yellow");
	if (isKeyDown("space")) run("glasbey_on_dark"); 
}

//TOP NUMBER KEYS
macro "[1]"	{
	if		(no_Alt_no_Space())		apply_LUTs();
	else if (isKeyDown("space"))	apply_All_LUTs(); 	
	else if (isKeyDown("alt"))		get_My_LUTs();
}
macro "[2]"	{
	if		(no_Alt_no_Space())		maximize_Image();
	else if (isKeyDown("space"))	restore_Image_Position();
	else if (isKeyDown("alt"))		full_Screen_Image();
}	
macro "[4]"	{
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		{run("Make Montage...", "scale=1"); setOption("Changes", 0); }
	else if (isKeyDown("space"))	run("Montage to Stack...");
}
macro "[7]" {
	if		(no_Alt_no_Space())		set_Target_Image();
}
macro "[8]"	{
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		run("Rename...");
	else if (isKeyDown("space"))	rename(get_Time_Stamp("short") + "_" + getTitle());
	else if (isKeyDown("alt"))		rename(get_Time_Stamp("full") + "_" + getTitle());
}
macro "[9]"	{
	if		(no_Alt_no_Space())		{if(File.exists(getDirectory("temp")+"test.tif")) open(getDirectory("temp")+"test.tif"); }
	else if (isKeyDown("space"))	{if (nImages()==0) exit(); saveAs("tif", getDirectory("temp")+"test.tif");}
}


//LETTER KEYS
macro "[a]"	{
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		run("Select All");
	else if (isKeyDown("space"))	run("Restore Selection");
	else if (isKeyDown("alt"))		run("Select None");
}
macro "[A]"	{
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		{ if (bitDepth() == 24) run("Enhance True Color Contrast", "saturated=0.1"); else run("Enhance Contrast", "saturated=0.1");}	
	else if (isKeyDown("space"))	enhance_All_Channels();
	else if (isKeyDown("alt"))		enhance_All_Images_Contrasts();
}
macro "[b]"	{
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		split_View("Vertical", "Colored", "No labels");
	else if (isKeyDown("space"))	split_View("Vertical", "Grayscale", "No labels");
	else if (isKeyDown("alt"))		quick_Figure_Splitview("vertical");
}
macro "[B]"	{	
	if		(no_Alt_no_Space())		run("Blobs (25K)");
	else if (isKeyDown("space"))	quick_Scale_Bar();
}
macro "[C]" {	run("Brightness/Contrast...");}

macro "[d]"	{
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		{getDimensions(width, height, channels, slices, frames); if (channels>1 || bitDepth()==24) run("Split Channels"); else run("Stack to Images");}
	else if (isKeyDown("space"))	{run("Duplicate...", " "); string_To_Recorder("run(\"Duplicate...\", \" \");");}//slice
	else if (isKeyDown("alt"))		duplicate_Channel();
}
macro "[D]"	{
	if		(no_Alt_no_Space())		{if (nImages()==0) exit(); run("Duplicate...", "duplicate"); string_To_Recorder("run(\"Duplicate...\", \"duplicate\");");}
	else if (isKeyDown("space"))	open_Memory_And_Recorder();
}
macro "[E]"	{	my_Tile();}

macro "[F]"	{	
	if (no_Alt_no_Space())			my_Tool_Roll();
}
macro "[f]"	{
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		run("Gamma...");
	else if (isKeyDown("space"))	set_Gamma_LUT_All_Channels(0.8);
}
macro "[G]"	{
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		run("Z Project...", "projection=[Max Intensity] all");
	else if (isKeyDown("space"))	z_Project_All();
	else if (isKeyDown("alt"))		run("Z Project...", "projection=[Sum Slices] all");
}
macro "[g]"	{
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		run("Z Project...");
	else if (isKeyDown("space"))	color_Code_Progressive_Max();
	else if (isKeyDown("alt"))		color_Code_No_Projection();	
}
macro "[H]"	{	run("Show All");}

macro "[i]"	{
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		run("Invert LUTs");
	else if (isKeyDown("space"))	inverted_Overlay_HSB();
	else if (isKeyDown("alt"))		run("Invert LUT");
}
macro "[J]"	{
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		{run("Input/Output...", "jpeg=100"); saveAs("Jpeg");}
	else if (isKeyDown("space"))	save_As_LZW_compressed_tif();
}
macro "[j]"  {
	if		(no_Alt_no_Space())		run("Macro");
	else if (isKeyDown("space")) 	{ if (nImages()==0) exit(); run("Subtract Background...");}
}
macro "[k]"  {
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		multi_Plot();
	else if (isKeyDown("space"))	multi_Plot(); //normalized multiplot
	else if (isKeyDown("alt"))		multi_Plot_Z_Axis(); 
}
macro "[l]"	{
	if		(no_Alt_no_Space())		run("Find Commands...");
}
macro "[M]"	{
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		fast_Merge();
	else if (isKeyDown("space"))	run("Merge Channels...");
}	
macro "[n]"	{
	if		(no_Alt_no_Space())		Hela();
}
macro "[N]"	{
	if		(no_Alt_no_Space())		show_Numerical_Keyboard_Bar();
}
macro "[o]"	{
	if (nImages()==0) {run("Open..."); exit();}
	if (matches(getTitle(), ".*Preview Opener.*")) open_From_Preview_Opener();
	else 	run("Open...");
}
macro "[p]"	{
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		split_View("Linear", "Grayscale", "No labels");
	else if (isKeyDown("space"))	split_View("Square", "Grayscale", "No labels");
	else if (isKeyDown("alt"))		quick_Figure_Splitview("linear");
}
macro "[Q]" 	{	composite_Switch();	}

macro "[R]"	{
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		auto_Contrast_All_Channels();
	else if (isKeyDown("space"))	auto_Contrast_All_Images(); 
	else if (isKeyDown("alt"))		propagate_Contrasts_All_Images();
}
macro "[r]"	{
	if		(no_Alt_no_Space())		adjust_Contrast();
	else if (isKeyDown("space"))	{run("Install...","install=["+getDirectory("macros")+"/StartupMacros.fiji.ijm]"); setTool(15);}
}
macro "[S]"	{
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		split_View("Square", "Colored", "No labels");
	else if (isKeyDown("space"))	split_View("Linear", "Colored", "No labels");
	else if (isKeyDown("alt"))		split_View_Dialog();
}
macro "[s]"	{
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		saveAs("Tiff");
	else if (isKeyDown("alt"))		save_All_Images_Dialog();
}
macro "[v]"	{
	if		(no_Alt_no_Space())		run("Paste");
	else if (isKeyDown("space"))	run("System Clipboard");
	else if (isKeyDown("alt"))		open(getDirectory("temp")+"/copiedLut.lut");
}
macro "[w]"  {
	if		(no_Alt_no_Space())		{
		if (nImages()==0) exit();
		//avoid "are you sure?" and stores path in case of misclick
		path = getDirectory("image") + getTitle();
		if (File.exists(path)) call("ij.Prefs.set","last.closed", path); 
		close();
	}
	else if (isKeyDown("space"))	open(call("ij.Prefs.get","last.closed",""));	
	else if (isKeyDown("alt"))		close("\\Others");
}
macro "[x]"  {
	if (nImages()==0) exit();
	if		(no_Alt_no_Space())		copy_LUT();
	else if (isKeyDown("alt"))		{run("Copy to System");	showStatus("copy to system");}
}
macro "[y]"	{
	if		(no_Alt_no_Space())		run("Synchronize Windows");
	else if (isKeyDown("space"))	{if (nImages()==0) exit(); getCursorLoc(x, y, z, modifiers); doWand(x, y, estimate_Tolerance(), "8-connected");}	
}
macro "[Z]" {	
	if		(no_Alt_no_Space())		run("Channels Tool...");
	else if (isKeyDown("space"))	run("LUT Channels Tool");
}

function my_Tool_Roll() {
	if (toolID() != 15) {
		LAST_TOOL = toolID();
		setTool(15);
	}
	else 
		setTool(LAST_TOOL);
}

function save_Main_Tool(main_Tool) {
	call("ij.Prefs.set","Multi_Tool.Main_Tool", main_Tool);
	setTool(15);
	return main_Tool;
}

function get_Main_Tool(default_Main_Tool) {
	return call("ij.Prefs.get","Multi_Tool.Main_Tool", default_Main_Tool);
}

function save_Pref_LUT(index, lut_Name) {
	call("ij.Prefs.set","Fav_LUT." + index, lut_Name);
}

function get_Pref_LUT(index, default_LUT) {
	return call("ij.Prefs.get","Fav_LUT." + index, default_LUT);
}

function get_Pref_LUTs_List(default_LUTs){
	chosen_luts = newArray();
	for ( i = 0; i < 8; i++) chosen_luts[i] = get_Pref_LUT(i, default_LUTs[i]);
	return chosen_luts;
}

function string_To_Recorder(string) {
	if (isOpen('Recorder')) call("ij.plugin.frame.Recorder.recordString",string + "\n");
}

function quick_Figure_Splitview(linear_or_Vertical){
	if (nImages()==0) exit();
	getDimensions(width, height, channels, slices, frames);
	BORDER_SIZE = minOf(height, width) * 0.02;
	if (linear_or_Vertical == "linear") split_View("Linear", "Grayscale", "Add labels");
	else split_View("Vertical", "Grayscale", "Add labels");
	run("Copy to System");
}

function unique_Rename(name) {
	final_Name = name;
	i = 1;
	while (isOpen(final_Name)) {
		final_Name = name + "_" + i;
		i++;
	}
	rename(final_Name);
}

function arrange_Channels() { 
	// whithout losing metadata
	if (nImages()==0) exit();
	infos = getMetadata("Info");
	run("Arrange Channels...");
	setMetadata("Info", infos);
	string_To_Recorder("run(\"Arrange Channels...\");");
}

// adapted from here https://forum.image.sc/t/automatic-scale-bar-in-fiji-imagej/60774
function quick_Scale_Bar(){
	if (nImages()==0) exit();
	color = "White";
	// approximate size of the scale bar relative to image width :
	scalebar_Size = 0.23;
	getPixelSize(unit, pixel_Width, pixel_Height);
	if (unit == "pixels") exit("Image not spatially calibrated");
	// image width in measurement units
	shortest_Image_Edge = pixel_Width * minOf(Image.width, Image.height);  
	// initial scale bar length in measurement units :
	scalebar_Length = 1;
	// 1-2-5 series is calculated by repeated multiplication with 2.3, rounded to one significant digit
	while (scalebar_Length < shortest_Image_Edge * scalebar_Size) 
		scalebar_Length = round((scalebar_Length*2.3)/(Math.pow(10,(floor(Math.log10(abs(scalebar_Length*2.3)))))))*(Math.pow(10,(floor(Math.log10(abs(scalebar_Length*2.3))))));
	if (REMOVE_SCALEBAR_TEXT) {
		scalebar_Settings_String = " height=" + minOf(Image.width, Image.height)/30 + " font=" + maxOf(Image.width, Image.height)/30 + " color="+color+" hide overlay";
		print("Scale Bar length = " + scalebar_Length);
	}
	else scalebar_Settings_String = " height=" + minOf(Image.width, Image.height)/30 + " font=" + minOf(Image.width, Image.height)/15 + " color="+color+" bold overlay";
	run("Scale Bar...", "width=&scalebar_Length " + scalebar_Settings_String);
	string_To_Recorder("run(\"Scale Bar...\", \"width=" + scalebar_Length  + scalebar_Settings_String + "\"");
}

function save_As_LZW_compressed_tif(){
	path = getDir("save As LZW compressed tif");
	title = File.nameWithoutExtension();
	print( path + File.separator + title);
	run("Bio-Formats Exporter", "save=["+ path + File.separator + title + "_.tif] compression=LZW");
}

// true if
function no_Alt_no_Space(){
	if(!isKeyDown("space") && !isKeyDown("alt")) 
		return true;
	else return false;
}

function duplicate_Channel() {
	if (nImages()==0) exit();
	getDimensions(width, height, channels, slices, frames);
	title = getTitle() + "_dup";
	Stack.getPosition(channel, slice, frame); 
	if (channels > 1 && frames==1) {
		run("Duplicate...", "duplicate title=title channels=&channel");
		string_To_Recorder("run(\"Duplicate...\", \"duplicate title=" + title + " channels=" + channel + "\");");
	}
	else {
		run("Duplicate...", "duplicate title=title channels=&channel frames=frame");
		string_To_Recorder("run(\"Duplicate...\", \"duplicate title=" + title + " channels=" + channel + " frames=" + frame + "\");");
	}
}

function set_Target_Image(){
	if (nImages()==0) exit();
	// modify the global variable TARGET_IMAGE_TITLE with the current image title 
	showStatus("Target Image title");	
	run("Alert ", "object=Image color=Orange duration=1000"); 
	TARGET_IMAGE_TITLE = getTitle();
}

function open_Memory_And_Recorder() {
	run("Record...");
	wait(20);
	Table.setLocationAndSize(screenWidth()-430, 0, 430, 125,"Recorder");
	run("Monitor Memory...");
	wait(20);
	Table.setLocationAndSize(screenWidth()-676, 0, 255, 120,"Memory");
}

function composite_Switch(){
	if (nImages()==0) exit();
	if (!is("composite")) exit();
	Stack.getDisplayMode(mode);
	if (mode == "color" || mode == "greyscale") Stack.setDisplayMode("composite");
	else Stack.setDisplayMode("color");
}

/*
 * About Flags (or Modifiers) from getCursorLoc()
 * shift = +1
 * ctrl = +2
 * command = +4 (Mac)
 * alt = +8
 * middle also +8
 * leftClick = +16
 * cursor over selection = +32
 * So e.g. if (leftclick + alt) Flags = 24
 */
//inspired by Robert Haase Windows Position tool from clij
function multi_Tool(){
	if (nImages == 0) exit();
	//Main Tool stored on Pref file 
	MAIN_TOOL = get_Main_Tool("Move Windows"); //"Move Windows" if not set yet

	// Double click ?
	if (is_double_click()) {
		maximize_Image();
		exit();
	}
	setupUndo();
	//limit this to stay reactive on big images
	if (Image.width() < 1400 && Image.height() < 1400) call("ij.plugin.frame.ContrastAdjuster.update");

	getCursorLoc(x, y, z, flags);
	//middle click on selection
	if (flags == 40) { 
		roiManager("Add"); 
		exit();
	}

	//middle click
	if (flags == 8) { 
		if (matches(getTitle(), ".*Preview Opener.*")) open_From_Preview_Opener();  
		if (matches(getTitle(), ".*Lookup Tables.*")) set_LUT_From_Montage(); 
		if (Image.height == 32 || Image.width == 256) copy_LUT();
		if (MAIN_TOOL == "Curtain Tool") set_Target_Image();
		else composite_Switch();
	}

	//left Click on selection
	if (flags > 32 && MAIN_TOOL != "Magic Wand") move_selection_Tool(); 
	if (flags > 32) flags -= 32;

	//left Click
	if (flags == 16) { 
		if 		(MAIN_TOOL == "Move Windows")				move_Windows();
		else if (MAIN_TOOL == "Contrast Adjuster")			live_Contrast();
		else if (MAIN_TOOL == "LUT Gamma Tool")				live_Gamma();
		else if (MAIN_TOOL == "Slice / Frame Tool")			live_Scroll();
		else if (MAIN_TOOL == "Magic Wand")					magic_Wand();
		else if (MAIN_TOOL == "Curtain Tool")				curtain_Tool();
		else if (MAIN_TOOL == "Scale Bar Tool")				scale_Bar_Tool();
		else if (MAIN_TOOL == "Multi-channel Plot Tool")	live_MultiPlot();
	}
	if (flags == 9) 				if (bitDepth()!=24) paste_LUT();											// shift + middle click
	if (flags == 10 || flags == 14)	if (bitDepth()!=24) paste_Favorite_LUT();									// ctrl + middle click
	if (flags == 17)				live_Contrast();															// shift + drag
	if (flags == 18 || flags == 20)	k_Rectangle_Tool();															// ctrl + drag
	if (flags == 24)				if (MAIN_TOOL=="Slice / Frame Tool") move_Windows(); else live_Scroll();	// alt + drag
	if (flags == 25)				box_Auto_Contrast();														// shift + alt + drag
	if (flags == 26 || flags == 28)	curtain_Tool();
}

function is_double_click() {
	double_click = false;
	click_time = getTime(); // in ms
	if (click_time - LAST_CLICK_TIME < 200) double_click = true;
	LAST_CLICK_TIME = click_time;
	return double_click;
}

function k_Rectangle_Tool() {
	getCursorLoc(x_origin, y_origin, z, flags);
	getCursorLoc(last_x, last_y, z, flags);
	remove_ROI = true;
	if (flags > 32) exit();
	while (flags >= 16) {
		rect_x = x_origin;
		rect_y = y_origin;
		getCursorLoc(x, y, z, flags);
		if (x != last_x || y != last_y) {
			if (x <= x_origin) rect_x = x;
			if (y <= y_origin) rect_y = y;
			rect_width = abs(x_origin - x);
			rect_heigth = abs(y_origin - y);
			makeRectangle(rect_x, rect_y, rect_width, rect_heigth);
			getCursorLoc(last_x, last_y, z, flags);
			if (flags >= 32) flags -= 32;
			remove_ROI = false;
		}
		wait(10);
	}
	if (remove_ROI) run("Select None");
}

function move_selection_Tool() {
	getCursorLoc(x_origin, y_origin, z, flags);
	getCursorLoc(last_x, last_y, z, flags);
	getSelectionBounds(roi_x, roi_y, width, height);
	if (flags >= 32) flags -= 32;
	while (flags == 16) {
		getCursorLoc(x, y, z, flags);
		if (x != last_x || y != last_y) {
			setSelectionLocation(roi_x - (x_origin-x), roi_y - (y_origin-y));
			getCursorLoc(last_x, last_y, z, flags);
		}
		wait(10);
		if (flags >= 32) flags -= 32;
	}
}

function scale_Bar_Tool(){
	//adapted from Aleš Kladnik here https://forum.image.sc/t/automatic-scale-bar-in-fiji-imagej/60774
	getPixelSize(unit,w,h);
	if (unit == "pixels") exit("Image not spatially calibrated");
	bar_Length = 1;	// initial scale bar length in measurement units
	bar_Relative_Size = 0;
	bar_Height = 0;
	if (REMOVE_SCALEBAR_TEXT == true) text_Parameter = "hide";
	else text_Parameter = "bold";
	font_Size = minOf(Image.width, Image.height) / 15; // estimation of "good" font size
	getCursorLoc(x2, y2, z2, flags2);
	getCursorLoc(last_x, last_y, z, flags);
	while (flags >= 16) { //left click			
		getCursorLoc(x, y, z, flags);
		getDisplayedArea(area_x, area_y, width, height);
		//if mouse moved
		if (x != last_x || y != last_y) {
			// approximate size of the scale bar relative to image width
			bar_Relative_Size = round(((width-(x - area_x))/width) * 10);

			// recursively calculate a 1-2-5-10-20... series
			// 1-2-5 series is calculated by repeated multiplication with 2.3, rounded to one significant digit
			for (i = 0; i < bar_Relative_Size; i++) {
				magical_Formula = Math.pow( 10, (floor( Math.log10( abs(bar_Length * 2.3)))));
				bar_Length = round( (bar_Length*2.3) / magical_Formula) * magical_Formula;
			}

			bar_Height = round(((height - (y - area_y)) / height) * Image.height/20);

			//if size or height values changed from last loop, update scale bar
			if (bar_Relative_Size != last_Size || bar_Height != last_Height) 
				run("Scale Bar...", "width=&bar_Length height=&bar_Height font=&font_Size color=White background=None location=[Lower Right] "+ text_Parameter +" overlay");
			showStatus("height = "+bar_Height+ "px   length = "+ bar_Length + unit);
			bar_Length = 1;
		}
		//save changes
		last_Size = bar_Relative_Size;
		last_Height = bar_Height;
		getCursorLoc(last_x, last_y, z, flags);
		wait(10);
	}
}

function curtain_Tool() {
	getCursorLoc(last_x, y, z, flags);
	getDimensions(width, height, channels, slices, frames);
	setBatchMode(true);
	id = getImageID();
	while (flags&16>0) {
		selectImage(id);
		getCursorLoc(x, y, z, flags);
		if (x != last_x) {
			if (x < 0) x = 0;
			if (isOpen(TARGET_IMAGE_TITLE)) selectWindow(TARGET_IMAGE_TITLE);
			else exit();
			setKeyDown("none");
			makeRectangle(x, 0, width-x, height);
			run("Duplicate...","title=part");
			selectImage(id);
			run("Add Image...", "image=part x="+ x +" y=0 opacity=100"); //zero
			while (Overlay.size>1) Overlay.removeSelection(0);
			close("part");
			last_x = x;
			wait(10);
		}
	}
	selectWindow(TARGET_IMAGE_TITLE);
	run("Select None");
	selectImage(id);
	Overlay.remove;
}

function move_Windows() {
	getCursorLoc(x, y, z, flags);
	origin_x = get_Cursor_Screen_Loc_X();
	origin_y = get_Cursor_Screen_Loc_Y();
	getLocationAndSize(origin_window_x, origin_window_y, width, height);
	while (flags == 16) {
		x = get_Cursor_Screen_Loc_X();
		y = get_Cursor_Screen_Loc_Y();
		Table.setLocationAndSize(x - (origin_x - origin_window_x), y - (origin_y - origin_window_y), width, height, getTitle());
		getCursorLoc(x, y, z, flags);
		wait(10);
	}
}

function get_Cursor_Screen_Loc_X(){ 
	x = parseInt(eval("bsh", "import java.awt.MouseInfo; MouseInfo.getPointerInfo().getLocation().x;"));
	return x;
}

function get_Cursor_Screen_Loc_Y(){
	y = parseInt(eval("bsh", "import java.awt.MouseInfo; MouseInfo.getPointerInfo().getLocation().y;"));
	return y;
}

function live_Contrast() {	
	if (bitDepth() == 24) exit();
	resetMinAndMax();
	getMinAndMax(min, max);
	getCursorLoc(x, y, z, flags);
	flags = flags%32; //remove "cursor in selection" flag
	while (flags >= 16) {			
		getCursorLoc(x, y, z, flags);
		getDisplayedArea(area_x, area_y, width, height);
		flags = flags%32; //remove "cursor in selection" flag
		new_Max = ((x - area_x) / width) * max;
		new_Min = ((height - (y - area_y)) / height) * max / 2;
		if (new_Max < 0) new_Max = 0;
		if (new_Min < 0) new_Min = 0;
		if (new_Min > new_Max) new_Min = new_Max;
		setMinAndMax(new_Min, new_Max);
		call("ij.plugin.frame.ContrastAdjuster.update");
		wait(10);
	}
}

function live_Gamma(){
	setBatchMode(1);
	getLut(reds, greens, blues);
	// copy_LUT();
	setColor("white");
	setFont("SansSerif", Image.height/20, "bold antialiased");
	getCursorLoc(x, y, z, flags);
	flags = flags%32; //remove "cursor in selection" flag
	while (flags >= 16) {
		getCursorLoc(x, y, z, flags);
		getDisplayedArea(area_x, area_y, width, height);
		flags = flags%32; //remove "cursor in selection" flag
		gamma = d2s(((x - area_x) / width) * 2, 2); if (gamma < 0) gamma=0;
		gamma_LUT(gamma, reds, greens, blues);
		showStatus("Gamma on LUT : " + gamma);
		wait(10);
	}
	setBatchMode(0);
	run("Select None");
}

function live_Scroll() {
	getDimensions(width, height, channels, slices, frames);
	if(slices==1 && frames==1) exit();
	getCursorLoc(x, y, z, flags);
	flags = flags%32; //remove "cursor in selection" flag
	while(flags >= 16) {
		getCursorLoc(x, y, z, flags);
		getDisplayedArea(area_x, area_y, width, height);
		flags = flags%32; //remove "cursor in selection" flag
		if (frames > 1) Stack.setFrame(((x - area_x) / width) * frames);
		else 			Stack.setSlice(((x - area_x) / width) * slices);
		wait(10);
	}
}

function box_Auto_Contrast() {
	if (bitDepth==24) exit();
	size = 75;
	getCursorLoc(x, y, z, flags);
	makeRectangle(x - size/2, y - size/2, size, size);
	auto_Contrast_All_Channels();
	run("Select None");
}

function magic_Wand(){
	getCursorLoc(x, y, z, flags);
	if (flags>=32) flags -= 32; //remove "cursor in selection" flag
	if (ADD_TO_MANAGER){
		run("ROI Manager...");
		roiManager("show all without labels");
	}
	if (flags == 16) { //left click
		adjust_Tolerance();
	}
	if (FIT_MODE != "None"){
		run(FIT_MODE);
		getSelectionCoordinates(xpoints, ypoints);
		makeSelection(4, xpoints, ypoints);
	}
	if (ADD_TO_MANAGER)	roiManager("Add");
	wait(30);
}

function adjust_Tolerance() {
	getCursorLoc(x2, y2, z, flags); //origin
	getCursorLoc(x, y, z, flags);
	if (flags>=32) flags -= 32; //remove "cursor in selection" flag
	zoom = getZoom();
	tolerance = estimate_Tolerance();
	while (flags >= 16) {
		getCursorLoc(x, y, z, flags);
		if (flags>=32) flags -= 32; //remove "cursor in selection" flag
		distance = (x*zoom - x2*zoom);
		if (distance < 0) new_Tolerance = tolerance - pow(abs(distance), EXPONENT);
		else new_Tolerance = tolerance + pow(abs(distance), EXPONENT);
		if (new_Tolerance < 0) new_Tolerance = 0;
		showStatus(new_Tolerance);
		doWand(x2, y2, new_Tolerance, "Legacy");
		wait(30);
	}
}

function estimate_Tolerance(){
	run("Select None");
	setBatchMode(1);
	getCursorLoc(x, y, z, flags);
	makeRectangle(x - (WAND_BOX_SIZE / 2), y - (WAND_BOX_SIZE / 2), WAND_BOX_SIZE, WAND_BOX_SIZE);
	getStatistics(bla, bla, bla, max, bla, bla);;
	tolerance = (TOLERANCE_THRESHOLD / 100) * max;
	return tolerance;
}

function copy_LUT() {
	if (nImages()==0) exit();
	if (bitDepth() == 24) exit();
	getCursorLoc(x, y, z, flags);
	saveAs("lut", getDirectory("temp")+"/copiedLut.lut");
	showStatus("Copy LUT");
}

function paste_LUT(){
	if (bitDepth() == 24) exit();
	open(getDirectory("temp")+"/copiedLut.lut");
	showStatus("Paste LUT");
}

function set_Favorite_LUT(){
	if (nImages()==0) exit();
	if (bitDepth() == 24) exit();
	saveAs("lut", getDirectory("temp") + "/favoriteLUT.lut");
	showStatus("new favorite LUT");
}

function paste_Favorite_LUT(){
	if (bitDepth() == 24) exit();
	open(getDirectory("temp") + "/favoriteLUT.lut");
	showStatus("Paste LUT");
}

function get_Time_Stamp(full_or_short) {
	getDateAndTime(year, month, day_Of_Week, day_Of_Month, hour, minute, second, msec);
	if (full_or_short == "short") 
		time_Stamp = "" + toString(year-2000) + toString(IJ.pad(month+1, 2)) + toString(IJ.pad(day_Of_Month, 2)) + "_";
	else time_Stamp = "" + toString(year-2000) + toString(IJ.pad(month+1, 2)) + toString(IJ.pad(day_Of_Month, 2)) + "_" + toString(hour) + toString(minute) + toString(second);
	return time_Stamp;
}

//toggle channel number (i)
function toggle_Channel(i) { //modified from J.Mutterer
	if (nImages()==0) exit();
	if (is("composite")) {
		Stack.getActiveChannels(string);
		channel_Index = string.substring(i-1,i);
		Stack.setActiveChannels(string.substring(0, i-1) + !channel_Index + string.substring(i)); //at the end it looks like Stack.setActiveChannels(1101);
		showStatus("channel " + i + " toggled"); 
	}
}

function toggle_Channel_All(i) {
	setBatchMode(1);
	for (k=0; k<nImages; k++) {
		selectImage(k+1);
		toggle_Channel(i);	
	}
	showStatus("channel "+i+" toggled");
	setBatchMode(0);
}

function open_From_Preview_Opener() {
	infos = getMetadata("Info");
	path_List = split(infos, ",,");
	rows = getInfo("xMontage");
	lines = getInfo("yMontage");
	bloc_Size = 400;
	index = 0;
	getCursorLoc(x, y, z, flags);
	line_Position = floor(y / bloc_Size);
	row_Position = floor(x / bloc_Size);
	index = (line_Position * rows) + row_Position;
	path = getDirectory("image") + path_List[index];
	if (File.exists(path)) {
		if (endsWith(path, '.tif')||endsWith(path, '.png')||endsWith(path, '.jpg')||endsWith(path, 'jpeg')) open(path);
		else run('Bio-Formats Importer', 'open=[' + path + ']');
		showStatus("opening " + path_List[index]);
	}
	else showStatus("can't find " + path_List[index]);
}

//create a montage with snapshots of all opened images (virtual or not)
//in their curent state.  Will close all but the montage.
function make_Preview_Opener() {
	if (nImages == 0) exit();
	Dialog.createNonBlocking("Make Preview Opener");
	Dialog.addMessage("Creates a montage with snapshots of all opened images (virtual or not).\n" +
		"This will close all but the montage. Are you sure?");
	Dialog.addHelp("https://kwolby.notion.site/Preview-Opener-581219eab9f748bc8269d0d8ffe9172d");
	Dialog.show();
	setBatchMode(1);
	all_IDs = newArray(nImages);
	paths_List = "";
	concat_Options = "open ";
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		if (i==0) {
			source_Folder = getDirectory("image"); 
			File.setDefaultDir(source_Folder);
		}
		all_IDs[i] = getImageID();
		paths_List += getTitle() +",,";
	}
	for (i=0; i<all_IDs.length; i++) {
		selectImage(all_IDs[i]); 
		if (!is("Virtual Stack") && bitDepth()!=24) {
			getDimensions(width, height, channels, slices, frames);
			getLut(reds,greens,blues);
			if (slices * frames != 1) run("Z Project...", "projection=[Max Intensity] all");
			setLut(reds, greens, blues);
		}
		rgb_Snapshot();
		run("Scale...", "x=- y=- width=400 height=400 interpolation=Bilinear average create");
		rename("image"+i);
		concat_Options +=  "image"+i+1+"=[image"+i+"] ";
	}
	run("Concatenate...", concat_Options);
	run("Make Montage...", "scale=1");
	rename("Preview Opener");
	infos = getMetadata("Info");
	setMetadata("Info", paths_List + "\n" + infos);
	close("\\Others");
	setBatchMode(0);
	saveAs("tiff", source_Folder + "_Preview Opener");
}

//Supposed to create an RGB snapshot of any kind of opened image
function rgb_Snapshot(){
	if (nImages()==0) exit();
	title = getTitle();
	Stack.getPosition(channel, slice, frame);
	getDimensions(width, height, channels, slices, frames);
	if (channels > 1) Stack.getDisplayMode(mode);
	if 		(bitDepth()==24) 		run("Duplicate..."," ");
	else if (channels==1) 			run("Duplicate...", "title=toClose channels=&channels slices=&slice frames=&frame");
	else if (mode!="composite") 	run("Duplicate...", "title=toClose channels=channel slices=&slice frames=&frame");
	else 							run("Duplicate...", "duplicate title=toClose slices=&slice frames=&frame");
	run("RGB Color", "keep");
	unique_Rename("rgb_" + title);
	close("toClose");
	setOption("Changes", 0);
}

function Hela(){
	setBatchMode(1);
	run("HeLa Cells (48-bit RGB)");
	makeRectangle(23, 0, 580, 478);
	run("Crop");
	run("Remove Overlay");
	run("Remove Slice Labels");
	apply_LUTs();
	makeRectangle(173, 255, 314, 178);
	enhance_All_Channels();
	run("Select None");
	setOption("Changes",0);
	setBatchMode(0);
}

function live_MultiPlot() {
	// adapted from jérome Mutterer: https://gist.github.com/mutterer/4a8e226fbe55e8e682a1
	if (nImages()==0) exit();
	if (bitDepth() == 24) exit();
	close("LUT Profile");
	cursor_Position = "not on a line anchor point";
	if (bitDepth() == 24){ run("Plot Profile"); exit();}
	getCursorLoc(origin_x, origin_y, z, flags);
	// if selection is a Line
	if (selectionType()==5) {
		getLine(line_x1, line_y1, line_x2, line_y2, line_Width);
		if		(get_Distance(line_x1, line_y1, origin_x, origin_y) < 10)									cursor_Position = "start point";
		else if	(get_Distance(line_x2, line_y2, origin_x, origin_y) < 10)									cursor_Position = "end point";
		else if	(get_Distance((line_x1 + line_x2) / 2, (line_y1 + line_y2)/2, origin_x, origin_y) < 10)		cursor_Position = "middle point";
	}
	id = getImageID;
	getStatistics(bla, bla, min, max);
	getPixelSize(unit, pixel_Width, pixel_Height);
	getLine(line_x1, line_y1, line_x2, line_y2, line_Width);
	if (!isOpen("MultiPlot")) {
		run("Plots...", "width=400 height=200");
	}
	Plot.create("MultiPlot", "Distance ("+unit+")", "Value");
	selectImage(id);
	id = getImageID;
	while (flags & 16 != 0) {
		selectImage(id);
		getCursorLoc(new_x, new_y, z, flags);
		if (cursor_Position == "not on a line anchor point")	makeLine(origin_x, origin_y, new_x, new_y);
		else if (cursor_Position == "start point")				makeLine(new_x, new_y, line_x2, line_y2);
		else if (cursor_Position == "end point")				makeLine(line_x1, line_y1, new_x, new_y);
		else if (cursor_Position == "middle point") {
			dx = new_x - origin_x;  
			dy = new_y - origin_y;  
			makeLine(line_x1 + dx, line_y1 + dy, line_x2 + dx, line_y2 + dy);
		}
		Stack.getDimensions(w, h, channels, z, t);
		pre_Profile = getProfile();
		size = pre_Profile.length; 
		for (i=0; i<size; i++) pre_Profile[i] = i*pixel_Width;
		Plot.create("MultiPlot", "Distance ("+unit+")", "Value");
		Plot.setBackgroundColor("#2f2f2f");
		Plot.setAxisLabelSize(14.0, "bold");
		Plot.setFormatFlags("11001100101111");
		Plot.setLimits(0, pre_Profile[size-1], min, max);
		for (i=1; i<=channels; i++) {
			if (is_Active_Channel(i-1)) {
				if (channels > 1) Stack.setChannel(i);
				if (selectionType()==-1) makeRectangle(new_x, new_y, 1, 1);
				profile = getProfile();
				Plot.setColor(lut_To_Hex2());
				Plot.setLineWidth(2);
				Plot.add("line", pre_Profile, profile);
			}
		}
		Plot.update();
		wait(10);
	}
	selectWindow("MultiPlot"); 
	Plot.setLimitsToFit();
	selectImage(id);
}

function get_Distance(x1, y1, x2, y2) {
	return sqrt((x1-x2) * (x1-x2) + (y1-y2) * (y1-y2));
}

function multi_Plot(){
	if (nImages()==0) exit();
	close("LUT Profile");
	select_None = 0; normalize = 0;
	if (isKeyDown("space")) normalize = 1;
	getDimensions(width,  height, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	if (selectionType() == -1) run("Select All");
	if (bitDepth() == 24){ run("Plot Profile"); exit();}
	id = getImageID();
	if (!isOpen("MultiPlot")) call("ij.gui.ImageWindow.setNextLocation", SAVED_LOC_X, SAVED_LOC_Y);
	run("Plots...", "width=400 height=200");
	Plot.create("MultiPlot", "Pixels", "Grey value");
	for (i=1; i<=channels; i++) {
		if (channels > 1) Stack.setChannel(i);
		if (is_Active_Channel(i-1)) {
			profile = getProfile();
			Array.getStatistics(profile, min, max, mean, stdDev);
			if (normalize) for (k=0; k<profile.length; k++) profile[k] = Math.map(profile[k], min, max, 0, 1);
			Plot.setColor(lut_To_Hex2());
			Plot.setLineWidth(2);
			Plot.add("line", profile);
		}
	}
	Stack.setPosition(channel, slice, frame);
	updateDisplay();
	Plot.setBackgroundColor("#2f2f2f");
	Plot.setAxisLabelSize(14.0, "bold");
	Plot.setFormatFlags("11001100101111");
	if (normalize) Plot.setXYLabels("Pixels", "Normalized Intensity");
	Plot.update();
	selectWindow("MultiPlot");
	if (normalize) Plot.setLimits(0, profile.length, 0, 1.01 );
	else  Plot.setLimitsToFit();
	Plot.freeze(1);
	selectImage(id);
	getSelectionBounds(x, y, selection_Width, height);
	if (selection_Width == Image.width) run("Select None");
}

function lut_To_Hex2(){
	getLut(reds, greens, blues);
	if (is("Inverting LUT")) { red = reds[0];   green = greens[0];   blue = blues[0];   }
	else 					 { red = reds[255]; green = greens[255]; blue = blues[255]; }
    hex_red = IJ.pad(toHex(red), 2);
    hex_green = IJ.pad(toHex(green), 2);
    hex_blue = IJ.pad(toHex(blue), 2);
	return "#" + hex_red + hex_green + hex_blue;
}

function multi_Plot_Z_Axis(){
	if (nImages()==0) exit();
	close("LUT Profile");
	select_None = 0; active_Channels = "1"; normalize = 1;
	// if (isKeyDown("space")) normalize = 1;
	getDimensions(width,  height, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	if (selectionType() == -1) {run("Select All");}
	if (bitDepth() == 24){ run("Plot Profile"); exit();}
	if (channels > 1) Stack.getActiveChannels(active_Channels);
	id = getImageID();
	if (!isOpen("Multiplot")) call("ij.gui.ImageWindow.setNextLocation", SAVED_LOC_X, SAVED_LOC_Y);
	run("Plots...", "width=400 height=200");
	Plot.create("MultiPlot", "Frame", "Grey value");
	for (i=1; i<=channels; i++) {
		if (channels > 1) Stack.setChannel(i);
		if (is_Active_Channel(i - 1)) {
			LUTcolor = lut_To_Hex2();
			setBatchMode(1);
			run("Plot Z-axis Profile");
			Plot.getValues(xpoints, profile);
			Array.getStatistics(profile, min, max, mean, stdDev);
			if (normalize) for (k=0; k<profile.length; k++) profile[k] = Math.map(profile[k], min, max, 0, 1);
			Plot.setColor(LUTcolor);
			Plot.setLineWidth(2);
			Plot.add("line", profile);
			close();
			setBatchMode(0);
		}
	}
	Stack.setPosition(channel, slice, frame);
	updateDisplay();
	Plot.setBackgroundColor("#2f2f2f");
	Plot.setAxisLabelSize(14.0, "bold");
	Plot.setFormatFlags("11001100101111");
	if (normalize) Plot.setXYLabels("Frame", "Normalized Intensity");
	Plot.update();
	selectWindow("MultiPlot");
	if (normalize) Plot.setLimits(0, profile.length, 0, 1.01 );
	else  Plot.setLimitsToFit();
	Plot.freeze(1);
	selectImage(id);
	if (channels>1) Stack.setActiveChannels(active_Channels);
	getSelectionBounds(x, y, selection_Width, height);
	if (selection_Width == Image.width) run("Select None");
}

function fast_Merge(){
	if (nImages()==0) exit();
	if (nImages>4) {run("Merge Channels..."); exit();}
	for (i=0; i<nImages; i++) {
		selectImage(i+1);
		if(bitDepth()==24 || is("composite")) exit("cannot merge all opened images");
	}
	list = getList("image.titles");
	txt = "";
	for (i=0; i<list.length; i++) {
		txt = txt + "c" + i+1 + "=[" + list[i] + "] ";
	}
	run("Merge Channels...", txt + "create");
}

function set_Active_Path() { File.setDefaultDir(getDirectory("image")); }

function maximize_Image() {
	if (nImages()==0) exit();
	// if already maximized, restore previous loc and size
	if (Property.get("is_Maximized") == "True") {
		Property.set("is_Maximized", "False");
		restore_Image_Position();
		exit();
	}
	// else :
	//if same title as previous backup, keep previous.
	getLocationAndSize(x, null, null, null);
	if (getTitle()!= POSITION_BACKUP_TITLE || x != X_POSITION_BACKUP)	getLocationAndSize(X_POSITION_BACKUP, Y_POSITION_BACKUP, WIDTH_POSITION_BACKUP, HEIGHT_POSITION_BACKUP);
	// maxmize
	getDimensions(width, height, null, null, null);
	if (width/height <= 2.5) {
		newHeight = (screenHeight()/11) * 10;
		newWidth = width * (newHeight / height);
		x = (screenWidth() - newWidth) / 2;
		y = (screenHeight() - newHeight)/1.2;
		setLocation(x, y, newWidth, newHeight);
		run("Set... ", "zoom="+(getZoom()*100)-2);
	}
	else {
		run("Maximize");
		setLocation(0, 200);
	}
	Property.set("is_Maximized", "True");
	POSITION_BACKUP_TITLE = getTitle();
}

function full_Screen_Image() {
	if (nImages()==0) exit();
	getLocationAndSize(X_POSITION_BACKUP, Y_POSITION_BACKUP, WIDTH_POSITION_BACKUP, HEIGHT_POSITION_BACKUP);
	setLocation(0, screenHeight()/11, screenWidth(), screenHeight()*0.88);
	run("Set... ", "zoom="+round((screenWidth()/getWidth())*100)-1);
	setLocation(0, screenHeight()/11, screenWidth(), screenHeight()*0.88);
}

function restore_Image_Position(){
	if (nImages()==0) exit();
	setLocation(X_POSITION_BACKUP, Y_POSITION_BACKUP, WIDTH_POSITION_BACKUP, HEIGHT_POSITION_BACKUP);
	zoom = floor(getZoom()*100);
	run("Set... ", "zoom=&zoom");
}

/*--------
Set LUTs
--------*/
function get_My_LUTs(){
	if (nImages()==0) exit();
	LUT_list = newArray("Cyan","Magenta","Yellow","Red","Green","Blue","Grays","k_Blue","k_Magenta","k_Orange","k_Green");
	getDimensions(width, height, channels, slices, frames);
	// Dialog
	Dialog.create("Set all LUTs");
	for(i=0; i<channels; i++) { Dialog.setInsets(0, 0, 0); Dialog.addRadioButtonGroup("LUT " + (i+1), LUT_list, 2, 6, CHOSEN_LUTS[i]);}
	Dialog.show();
	for(i=0; i<channels; i++) {
		CHOSEN_LUTS[i] = Dialog.getRadioButton();
		save_Pref_LUT(i, CHOSEN_LUTS[i]);
	}
	apply_LUTs();
}

function get_LUTs_Dialog(){
	LUT_list = newArray("Cyan","Magenta","Yellow","Red","Green","Blue","Grays","k_Blue","k_Magenta","k_Orange","k_Green");
	getDimensions(width, height, channels, slices, frames);
	// Dialog
	Dialog.create("Set all LUTs");
	for(i=0; i<channels; i++) Dialog.addChoice("LUT " + (i+1),LUT_list, CHOSEN_LUTS[i]);
	Dialog.show();
	for(i=0; i<channels; i++) {
		CHOSEN_LUTS[i] = Dialog.getChoice();
		save_Pref_LUT(i, CHOSEN_LUTS[i]);
	}
}

function apply_LUTs(){
	if (nImages()==0) exit();
	Stack.getPosition(channel, slice, frame);
	getDimensions(width, height, channels, slices, frames);
	lut_list = Array.copy(CHOSEN_LUTS);
	if (channels>1){
		for(i=1; i<=channels; i++){
			Stack.setChannel(i);
			run(lut_list[i-1]);
		}
		Stack.setChannel(channel);
		updateDisplay();
	}
	else run(lut_list[0]);
}

function apply_All_LUTs(){
	if (nImages()==0) exit();
	setBatchMode(1);
	all_IDs = newArray(nImages);
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		all_IDs[i] = getImageID(); 
	} 
	for (i=0; i<nImages; i++) {
		selectImage(all_IDs[i]);
		if (bitDepth() != 24) apply_LUTs();	
	}
	setBatchMode(0);
}

function gamma_LUT(gamma, reds, greens, blues) {
	gammaReds = newArray(256); 
	gammaGreens = newArray(256); 
	gammaBlues = newArray(256); 
	gamma_factor = newArray(256);
	for (i=0; i<256; i++) gamma_factor[i] = pow(i, gamma);
	scale = 255 / gamma_factor[255];
	for (i=0; i<256; i++) gamma_factor[i] = round(gamma_factor[i] * scale);
	for (i=0; i<256; i++) {
		j = gamma_factor[i];
		gammaReds[i] = reds[j];
		gammaGreens[i] = greens[j];
		gammaBlues[i] = blues[j];
	}
	setLut(gammaReds, gammaGreens, gammaBlues);
}

function set_Gamma_LUT_All_Channels(gamma){
	if (nImages == 0) exit();
	if (bitDepth() == 24) exit();
	getDimensions(w,h,channels,s,f);
	if (channels > 1) {
		for (i=1; i<=channels; i++){
			Stack.setChannel(i);
			getLut(reds, greens, blues);
			gamma_LUT(gamma,reds, greens, blues);	
		}
	}
	else {
		getLut(reds, greens, blues);
		gamma_LUT(gamma,reds, greens, blues);
	}
}

/*----------------------------------------------------------------
Adjust the contrast window between min and max on active channel
----------------------------------------------------------------*/
function adjust_Contrast() { 
	if (nImages()==0) exit();
	if (is("Virtual Stack")) {run("Enhance Contrast", "saturated=0"); run("Select None"); exit();}
	setBatchMode(1);
	id = getImageID();
	getDimensions(width, height, channels, slices, frames);
	if (slices * frames * channels == 1) 
		getStatistics(area, mean, min, max, std, histogram);
	else if (slices*frames == 1 && channels>1)	{
		Stack.getPosition(channel, slice, frame);
		run("Duplicate...", "title=temp duplicate channels=&channel");//duplicate only the active channel.
		getStatistics(area, mean, min, max, std, histogram);
	}
	else {
		Stack.getPosition(channel, slice, frame);
		run("Duplicate...", "title=temp duplicate channels=&channel");
		Stack.getStatistics(voxelCount, mean, min, max, stdDev);
	}
	selectImage(id);
	setMinAndMax(min, max);
	showStatus("min = "+min+" max = "+max);
	close("temp");
	setBatchMode("exit and display");
	updateDisplay();
	call("ij.plugin.frame.ContrastAdjuster.update");
}

function auto_Contrast_All_Channels() {
	if (nImages()==0) exit();
	getDimensions(width, height, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	for (i = 0; i < channels; i++) {
		if (is_Active_Channel(i)) {
			Stack.setPosition(i+1, slice, frame);
			adjust_Contrast();
		}
	}
	Stack.setPosition(channel, slice, frame);
	updateDisplay();
}

function is_Active_Channel(channel_Index){
	getDimensions(width, height, channels, slices, frames);
	if (channels==1) return true;
	Stack.getDisplayMode(mode)
	if (mode == "color") {
		Stack.getPosition(channel, slice, frame);
		if (channel_Index+1 == channel) return true;
		else return false;
	} 
	Stack.getActiveChannels(string);
	if (string.substring(channel_Index, channel_Index+1) == "1") return true;
	else return false;
}

function enhance_All_Channels() {
	if (nImages()==0) exit();
	getDimensions(width, height, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	for (i = 1; i <= channels; i++) {
		Stack.setPosition(i, slice, frame);
		run("Enhance Contrast", "saturated=0.1");	
	}
	Stack.setPosition(channel, slice, frame);
	updateDisplay();
	call("ij.plugin.frame.ContrastAdjuster.update");
}

/*------------------
All opened images
------------------*/
function auto_Contrast_All_Images(){
	if (nImages()==0) exit();
	showStatus("Reset all contrasts");
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
	    auto_Contrast_All_Channels();
		showProgress(i/nImages);	
	}
}

function enhance_All_Images_Contrasts() {
	if (nImages()==0) exit();
	showStatus("Enhance all contrasts");
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		enhance_All_Channels();
		showProgress(i/nImages);
	}
}

function propagate_Contrasts_All_Images(){
	if (nImages()==0) exit();
	Stack.getPosition(ch,s,f);
	getDimensions(width, height, channels, slices, frames);
	min = newArray(10);
	max = newArray(10);
	if (channels>1){
		for(i=0; i<channels; i++){
			Stack.setChannel(i+1);
			getMinAndMax(min[i], max[i]);
		}
		Stack.setChannel(ch);
		updateDisplay();
	}
	else getMinAndMax(min[0], max[0]);
	
	for (i = 0; i < nImages; i++) {
		if (bitDepth() != 24) {
			selectImage(i+1);
			getDimensions(width, height, channels, slices, frames);
			if (channels>1){
				for(k=0; k<channels; k++){
					Stack.setChannel(k+1);
					setMinAndMax(min[k], max[k]);
				}
				updateDisplay();
			}
			else setMinAndMax(min[0], max[0]);
		}
	}
}

function z_Project_All() {
	if (nImages()==0) exit();
	modes = newArray("[Average Intensity]","[Max Intensity]","[Sum Slices]","[Standard Deviation]","Median");
	all_IDs = newArray(nImages);
	Dialog.createNonBlocking("Z-Projection on all opened images");
	Dialog.addChoice("Method", modes, "[Max Intensity]");
	Dialog.show();
	Method_choice = Dialog.getChoice();
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		all_IDs[i] = getImageID(); 
	} 
	setBatchMode(1);
	for (i=0; i<all_IDs.length; i++) {
		selectImage(all_IDs[i]);
		getDimensions(w, h, channels, slices, frames);
		getLut(reds,greens,blues);
		if (channels*slices*frames!=1) run("Z Project...", "projection=" + Method_choice + " all");
		setLut(reds,greens,blues);
	}
	for (i=0; i<all_IDs.length ; i++) {	//Close not projected images
		selectImage(all_IDs[i]);
		getDimensions(w, h, channels, slices, frames);
		if (channels*slices*frames!=1) close();
	}
	setBatchMode("exit and display");
	run("Tile");
}

function save_All_Images_Dialog() {
	if (nImages()==0) exit();
	Dialog.createNonBlocking("Save all images as");
	Dialog.addChoice("format", newArray("tiff", "jpeg", "gif", "raw", "avi", "bmp", "png", "pgm", "lut", "selection", "results", "text"), "tiff");
	Dialog.show();
	format = Dialog.getChoice();
	folder = getDirectory("Choose a Directory");
	for (i=0; i<nImages; i++) {
        selectImage(i+1);
        title = getTitle;
        saveAs("tiff", folder + title);
        print(title + " saved");
	}
	print("done");
}

function my_Tile() {
	if (nImages() == 0) exit();
	for (i=0; i<nImages ; i++) {			
		selectImage(i+1);
		Stack.getPosition(channel, slice, frame);
		getDimensions(width, height, channels, slices, frames);
		Stack.setPosition(channel, round(slices/2), round(frames/2));
	}
	run("Tile");
}

function split_View_Dialog(){
	if (nImages == 0) exit();
	getSelectionBounds(x, y, width, height);
	auto_border_size = round(minOf(height, width) * 0.02);
	Dialog.createNonBlocking("split_View");
	Dialog.addRadioButtonGroup("color Mode", newArray("Colored","Grayscale"), 1, 3, COLOR_MODE);
	Dialog.addRadioButtonGroup("Montage Style", newArray("Linear","Square","Vertical"), 1, 3, MONTAGE_STYLE);
	Dialog.addSlider("border size", 0, 50, auto_border_size);
	Dialog.addRadioButtonGroup("Add Labels?", newArray("Add labels","No labels"), 1, 3, LABELS);
	Dialog.show();
	COLOR_MODE = Dialog.getRadioButton();
	MONTAGE_STYLE = Dialog.getRadioButton();
	BORDER_SIZE = Dialog.getNumber();
	LABELS = Dialog.getRadioButton();
	split_View(MONTAGE_STYLE, COLOR_MODE, LABELS);
	BORDER_SIZE = "Auto";
}

function split_View(MONTAGE_STYLE, COLOR_MODE, LABELS) {
	// COLOR_MODE : "Grayscale" or "Colored" 
	// MONTAGE_STYLE : "Linear","Square" or "Vertical"
	// LABELS : "Add labels" or "No labels"
	if (nImages()==0) exit();
	setBatchMode(1);
	title = getTitle();
	// prepares TILES before montage :
	saveSettings();
	getDimensions(width, height, channels, slices, frames); 
	Setup_SplitView(COLOR_MODE, LABELS);
	restoreSettings();
	// Tiles assembly
	if (MONTAGE_STYLE == "Linear")		linear_SplitView();
	if (MONTAGE_STYLE == "Square")		square_SplitView();
	if (MONTAGE_STYLE == "Vertical")	vertical_SplitView();
	//output
	unique_Rename(title + "_SplitView");
	setOption("Changes", 0);
	setBatchMode("exit and display");

	function Setup_SplitView(COLOR_MODE, LABELS){
		// prepares TILES before montage : 
		// duplicate twice for overlay and splitted channels
		// convert to RGB with right colors, labels and borders
		getDimensions(width, height, channels, slices, frames);
		if (channels == 1) exit("only one channel");
		if (channels > 5)  exit("5 channels max");
		setBackgroundColor(255, 255, 255); //for white borders
		run("Duplicate...", "title=image duplicate");
		if ((slices > 1) && (frames == 1)) {
			frames = slices;
			slices = 1;
			Stack.setDimensions(channels, slices, frames); 
		} 
		TILES = newArray(channels + 1);
		if (BORDER_SIZE == "Auto") BORDER_SIZE = round(minOf(height, width) * 0.02);
		FONT_SIZE = height / 9;
		run("Duplicate...", "title=split duplicate");
		run("Split Channels");
		selectWindow("image");
		Stack.setDisplayMode("composite")
		if (LABELS == "Add labels") {
			get_Labels_Dialog();
			setColor("white");
			setFont("SansSerif", FONT_SIZE, "bold antialiased");
			Overlay.drawString("Merge", height/20, FONT_SIZE);
			Overlay.show;
			run("Flatten","stack");
			rename("overlay");
			TILES[0] = getTitle();
			if (BORDER_SIZE > 0) add_Borders();
			close("image");
			for (i = 1; i <= channels; i++) {
				selectWindow("C" + i + "-split");
				id = getImageID();
				getLut(reds, greens, blues); 
				setColor(reds[255], greens[255], blues[255]);
				if (COLOR_MODE == "Grayscale") {
					getMinAndMax(min, max); 
					run("Grays"); 
					setMinAndMax(min, max);
				}
				Overlay.drawString(CHANNEL_LABELS[i-1], height/20, FONT_SIZE);
				Overlay.show;
				if (slices * frames > 1) run("Flatten","stack");
				else {
					run("Flatten");
					selectImage(id);
					close();
				}
				if (BORDER_SIZE > 0) add_Borders();
				TILES[i]=getTitle();
			}
		}
		else { // without LABELS
			run("RGB Color", "frames"); 
			rename("overlay"); 
			TILES[0] = getTitle(); 
			if (BORDER_SIZE > 0) add_Borders();
			close("image");
			for (i = 1; i <= channels; i++) {
				selectWindow("C"+i+"-split");
				if (COLOR_MODE == "Grayscale") {
					getMinAndMax(min, max); 
					run("Grays"); 
					setMinAndMax(min, max);
				}
				run("RGB Color", "slices"); 
				if (BORDER_SIZE > 0) add_Borders();
				TILES[i] = getTitle();	
			}
		}
		BORDER_SIZE = "Auto";
	}

	function add_Borders(){
		run("Canvas Size...", "width=" + Image.width + BORDER_SIZE + " height=" + Image.height + BORDER_SIZE + " position=Center");
	}
	
	function get_Labels_Dialog(){
		Dialog.createNonBlocking("Provide channel names");
		for (i = 0; i < 5; i++) Dialog.addString("channel " + i+1, CHANNEL_LABELS[i], 12); 
		Dialog.addNumber("Font size", FONT_SIZE);
		Dialog.show();
		for (i = 0; i < 5; i++) CHANNEL_LABELS[i] = Dialog.getString();
		FONT_SIZE = Dialog.getNumber();
	}
	
	function square_SplitView(){
		channel_1_2 = combine_Horizontally(TILES[1], TILES[2]);
		if (channels == 2||channels == 4) channel_1_2_Overlay = combine_Horizontally(channel_1_2, TILES[0]);
		if (channels == 3){
			channel_3_Overlay = combine_Horizontally(TILES[3], TILES[0]);
			combine_Vertically(channel_1_2, channel_3_Overlay);
		}
		if (channels >= 4)	channel_3_4 = combine_Horizontally(TILES[3], TILES[4]);
		if (channels == 4)	combine_Vertically(channel_1_2_Overlay, channel_3_4);
		if (channels == 5){
			channel_1_2_3_4 = combine_Vertically(channel_1_2, channel_3_4); 	
			channel_5_Overlay =	combine_Vertically(TILES[5], TILES[0]); 
			combine_Horizontally(channel_1_2_3_4, channel_5_Overlay);
		}
	}
	
	function linear_SplitView(){
		channel_1_2 = combine_Horizontally(TILES[1], TILES[2]);
		if (channels==2) combine_Horizontally(channel_1_2, TILES[0]);
		if (channels==3){
			channel_3_Overlay = combine_Horizontally(TILES[3], TILES[0]);
			combine_Horizontally(channel_1_2, channel_3_Overlay);
		}
		if (channels>=4){
			channel_3_4 = combine_Horizontally(TILES[3], TILES[4]);
			channel_1_2_3_4 = combine_Horizontally(channel_1_2, channel_3_4);
		}
		if (channels==4) combine_Horizontally(channel_1_2_3_4, TILES[0]); 
		if (channels==5){
			channel_5_Overlay = combine_Horizontally(TILES[5], TILES[0]);
			combine_Horizontally(channel_1_2_3_4, channel_5_Overlay);
		}
	}
	
	function vertical_SplitView(){
		channel_1_2 = combine_Vertically(TILES[1], TILES[2]);
		if (channels==2) combine_Vertically(channel_1_2, TILES[0]);
		if (channels==3){
			channel_3_Overlay = combine_Vertically(TILES[3], TILES[0]);
			combine_Vertically(channel_1_2, channel_3_Overlay);
		}
		if (channels>=4){
			channel_3_4 = combine_Vertically(TILES[3], TILES[4]);
			channel_1_2_3_4	= combine_Vertically(channel_1_2, channel_3_4);
		}
		if (channels==4) combine_Vertically(channel_1_2_3_4, TILES[0]);
		if (channels==5){
			channel_5_Overlay = combine_Vertically(TILES[5], TILES[0]);
			combine_Vertically(channel_1_2_3_4, channel_5_Overlay);
		}
	}
	
	function combine_Horizontally(stack1, stack2){
		run("Combine...", "stack1=&stack1 stack2=&stack2");
		rename(stack1+"_"+stack2);
		return getTitle();
	}
	
	function combine_Vertically(stack1, stack2){
		run("Combine...", "stack1=&stack1 stack2=&stack2 combine"); //vertically
		rename(stack1+"_"+stack2);
		return getTitle();
	}
}

function inverted_Overlay_HSB(){
	if (nImages()==0) exit();
	setBatchMode(1);
	title = getTitle();
	rgb_Snapshot();
	run("Invert");
	run("HSB Stack");
	run("Macro...", "code=v=(v+128)%256 slice");
	run("RGB Color");
	unique_Rename(title+"_inv");
	setOption("Changes", 0);
	setBatchMode(0);
}

//modified from https://github.com/ndefrancesco/macro-frenzy/blob/master/assorted/Colorize%20stack.ijm
//K.Terretaz 2022
//Max projection with color coding based on the current LUT
//to save RAM, it uses the Max copy paste mode to avoid creation of big RGB stack before projection
// works with virtual stacks
function color_Code_Progressive_Max(){
	if (nImages()==0) exit();
	saveSettings();
	setPasteMode("Max");
	title = getTitle();
	getDimensions(width, height, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	getDimensions(width, height, channels, slices, frames);
	if (selectionType() != -1) getSelectionBounds(x, y, width, height);
	setBatchMode(1);
	if (slices > 1 && frames >1) steps = frames;
	else steps = 1;
	newImage("Color Coded Projection", "RGB black", width, height, steps);
	selectWindow(title);
	// copy for backup :
	getLut(reds, greens, blues);
	//paste copied LUT
	open(getDirectory("temp")+"/copiedLut.lut");
	//get current LUT for color coding
	getLut(code_Reds, code_Greens, code_Blues);
	for (k = 0; k < frames; k++) {
		for (i = 0; i < slices; i++) {
			selectWindow(title);
			Stack.setPosition(channel, i+1, k+1);
			//create LUT with the scaled color :
			if (slices == 1) index =  (k/(frames-1)) * 255;
			else index = (i/(slices-1)) * 255;
			temp_Reds = newArray(0, code_Reds[index]);	
			temp_greens = newArray(0, code_Greens[index]);	
			temp_Blues = newArray(0, code_Blues[index]);
			temp_Reds = Array.resample(temp_Reds, 256);
			temp_greens = Array.resample(temp_greens, 256);
			temp_Blues = Array.resample(temp_Blues, 256);
			setLut(temp_Reds, temp_greens, temp_Blues);
			run("Copy");
			selectWindow("Color Coded Projection");
			Stack.setPosition(channel, k+1, k+1);

			//"MAX" paste :
			run("Paste");
		}
	}
	//restore LUT
	selectWindow(title);
	setLut(reds, greens, blues);
	selectWindow("Color Coded Projection");
	run("Select None");
	unique_Rename(title + "_Max_colored");
	setBatchMode("exit and display");
	restoreSettings();
	setOption("Changes", 0);
}

//No projection, heavy on RAM
function color_Code_No_Projection(){
	if (nImages()==0) exit();
	setKeyDown("none"); //bug fixing? alt
	title = getTitle();
	getVoxelSize(voxel_width, voxel_height, voxel_depth, unit);
	getDimensions(width, height, channels, slices, frames);
	Stack.getPosition(channel, slice, frame);
	getDimensions(width, height, channels, slices, frames);
	if (selectionType() != -1) getSelectionBounds(x, y, width, height);
	setBatchMode(1);
	newImage("Color Coded Projection", "RGB black", width, height, 1, slices, frames);
	selectWindow(title);
	// copy for backup :
	getLut(reds, greens, blues);
	//paste copied LUT
	open(getDirectory("temp")+"/copiedLut.lut");
	//get current LUT for color coding
	getLut(code_Reds, code_Greens, code_Blues);
	for (k = 0; k < frames; k++) {
		for (i = 0; i < slices; i++) {
			selectWindow(title);
			Stack.setPosition(channel, i+1, k+1);
			//create LUT with the scaled color :
			if (slices == 1) index =  (k/(frames-1)) * 255;
			else index = (i/(slices-1)) * 255;
			temp_Reds = newArray(0, code_Reds[index]);	
			temp_greens = newArray(0, code_Greens[index]);	
			temp_Blues = newArray(0, code_Blues[index]);
			temp_Reds = Array.resample(temp_Reds, 256);
			temp_greens = Array.resample(temp_greens, 256);
			temp_Blues = Array.resample(temp_Blues, 256);
			setLut(temp_Reds, temp_greens, temp_Blues);
			run("Copy");
			selectWindow("Color Coded Projection");
			Stack.setPosition(1, i+1, k+1);
			run("Paste");
		}
	}
	//restore LUT
	selectWindow(title);
	Stack.setPosition(channel, slice, frame);
	setLut(reds, greens, blues);
	selectWindow("Color Coded Projection");
	Stack.setPosition(1, 1, 1);
	run("Select None");
	unique_Rename(title + "_colored");
	setVoxelSize(voxel_width, voxel_height, voxel_depth, unit);
	setBatchMode(0);
	setOption("Changes", 0);
}

//--------------------------------------------------------------------------------------------------------------------------------------

function show_All_Macros_Action_Bar(){
	setup_Action_Bar_Header("Main Keyboard Macros");
	add_new_Line();
	add_macro_button_with_hotKey("E", "Arrange windows as Tiles", "none", "Fit all windows in screen");
	add_macro_button_with_hotKey("H", "Show All", "none", "Bring all imageJ windows to front");
	add_Contrast_Action_Bar();
	add_Basic_Action_Bar();
	add_Exports_Action_Bar();
	add_Bioformats_DnD();
	run("Action Bar", ACTION_BAR_STRING);
}

function show_Basic_Macros_Action_Bar(){
	setup_Action_Bar_Header("Utilities Macros");
	add_new_Line();
	add_macro_button_with_hotKey("E", "Arrange windows as Tiles", "none", "Fit all windows in screen");
	add_macro_button_with_hotKey("H", "Show All", "none", "Bring all imageJ windows to front");
	add_Basic_Action_Bar();
	add_Bioformats_DnD();
	run("Action Bar", ACTION_BAR_STRING);
}

function show_SplitView_Bar(){
	setup_Action_Bar_Header("Splitview Macros");
	add_SplitView_Action_Bar();
	add_Bioformats_DnD();
	run("Action Bar", ACTION_BAR_STRING);
}

function show_Numerical_Keyboard_Bar(){
	setup_Action_Bar_Header("Numerical Keyboard Macros");
	add_Numerical_Keyboard();
	add_Bioformats_DnD();
	run("Action Bar", ACTION_BAR_STRING);
}

function show_main_Tools_Popup_Bar(){
	setup_Popup_Action_Bar_Header("Main Tools");
	add_new_Line();
	add_gray_button("X (close)", "<close>", "Close this popup");
	add_new_Line();
	add_gray_button("Move Windows", "save_Main_Tool('Move Windows');", "Drag anywhere on image to move image window");
	add_gray_button("LUT Gamma", "save_Main_Tool('LUT Gamma Tool');", "Adjust the gamma of the current LUT <br> pixel values remain unchanged");
	add_new_Line();
	add_gray_button("Magic Wand", "save_Main_Tool('Magic Wand');", "Detects local signal in a 5 pixel box to estimate the right Wand tolerance. <br> Drag mouse laterally to adjust tolerance if needed. <br> Double click on Multi Tool to adjust parameters");
	add_gray_button("Scale Bar", "save_Main_Tool('Scale Bar Tool');", "Adjust the length and height by dragging the mouse on the image. <br> You can remove the text on the Multitool options");
	add_new_Line();
	add_gray_button("Multi-channel Plot ", "save_Main_Tool('Multi-channel Plot Tool');", "Line intensity profile Plot of all active channels");
	add_gray_button("Curtain Tool", "save_Main_Tool('Curtain Tool');", "Compare two images : first set the 'target image' <br> (the image you want to overlay) by a right click and 'set target image'");
	add_new_Line();
	add_gray_button("Slice / Frame Tool ", "save_Main_Tool('Slice / Frame Tool');", "Navigate the Z dimension (slice or frame) <br> from anywhere in the image");
	run("Action Bar", ACTION_BAR_STRING);
}

//--------------------------------------------------------------------------------------------------------------------------------------

function add_Basic_Action_Bar(){
	add_Text_Line("__________________ Channels & LUTs");
	add_new_Line();
	add_macro_button_with_hotKey("Q", "Composite/channel switch", "none", "Switch between Color and Composite<br>display mode on multichannel images");
	add_macro_button_with_hotKey("Z", "Channels Tool", "none", "Built-in Tools to manage Display mode, <br> Active channels and basic LUTs");
	add_new_Line();
	add_macro_button_with_hotKey("1", "Apply default LUTs", "none", "Apply saved LUTs to current image");
	add_new_Line();
	add_macro_button_with_hotKey("1", "Set default LUTs", "alt", "Select LUTs to save as default. <br> Note: the number of LUTs to be set matches the active image <br> An alternative way is to right click on image and 'Set LUTs'");
	add_macro_button_with_hotKey("1", "Apply LUTs to all", "space", "Apply saved LUTs to all opened images");
	add_new_Line();
	add_macro_button_with_hotKey("d", "Split Channels", "none", "Built-in Split Channels");
	add_new_Line();
	add_macro_button_with_hotKey("M", "Auto Merge channels", "none", "Up to 4 opened images and no RGB Image");
	add_macro_button_with_hotKey("M", "Manual Merge", "space", "Built-in Merge channels tool");
	add_Text_Line("__________________ Close");
	add_new_Line();
	add_macro_button_with_hotKey("w", "Close image", "none", "Close active image without 'sure?' warning <br> And stores path of image to reopen later");
	add_macro_button_with_hotKey("w", "Close others", "alt", "Close All Images except the active one");
	add_new_Line();
	add_macro_button_with_hotKey("w", "Open last closed", "space", "Open last closed image if the 'w' key was used");
	add_Text_Line("__________________ Stack Projections");
	add_new_Line();
	add_macro_button_with_hotKey("G", "MAX full stack", "none", "Quick MAX Z projection with all slices or frames");
	add_macro_button_with_hotKey("g", "Z Project Dialog", "none", "Built-in Projection Dialog");
	add_new_Line();
	add_macro_button_with_hotKey("G", "SUM full stack", "alt", "Quick SUM Z projection with all slices or frames");
	add_macro_button_with_hotKey("G", "MAX ALL IMAGES", "space", "Quick MAX Z projection on all opened images <br> Warning : will close non projected images");
}

function add_Contrast_Action_Bar(){
	add_Text_Line("__________________ Contrast Macros");
	add_new_Line();
	add_macro_button_with_hotKey("C", "Brightness & Contrast", "none", "Built-in Contrast Tool");
	add_new_Line();
	add_macro_button_with_hotKey("A", "Enhance active channel", "none", "Enhance active channel : only based on current slice,<br> Adjust the contrast with 0.1% of saturated pixels.<br> If image type is RGB, uses Biovoxxel's 'True color contrast'");
	add_macro_button_with_hotKey("r", "Reset active channel", "none", "Resets contrast to min and max based on the entire stack <br> So you can navigate through slices without signal saturation.");
	add_new_Line();
	add_macro_button_with_hotKey("A", "Enhance all channels", "space", "Enhance all channels : only based on current slice,<br>Adjust the contrast with 0.1% of saturated pixels.");
	add_macro_button_with_hotKey("R", "Reset all channels", "none", "Resets contrast on all channels");
	add_new_Line();
	add_macro_button_with_hotKey("A", "Enhance all images", "alt", "Enhance all channels of all opened images");
	add_macro_button_with_hotKey("R", "Reset all images", "space", "Resets contrast of all channels <br> On all opened images");
	add_new_Line();
	add_macro_button_with_hotKey("R", "Same contrast to all images", "alt", "Apply current contrast to all other opened images");
}

function add_Exports_Action_Bar(){
	add_Text_Line("__________________ Export Images");
	add_new_Line();
	add_macro_button_with_hotKey("x", "Copy to System Clipboard", "alt", "Copies a snapshot of active image <br> that can be pasted elsewhere <br> i.e. powerpoint or inkscape");
	add_new_Line();
	add_macro_button_with_hotKey("s", "Save as tiff", "none", "Save active image as tiff <br> Note: in this format, all metadata and pixel scales are kept inside");
	add_macro_button_with_hotKey("s", "Save all opened images", "alt", "Save all opened images on specified format and directory <br> Note : beware of deletions, similar titles are overwritten !");
	add_new_Line();
	add_macro_button_with_hotKey("J", "Save as JPEG...", "none", "Save as 100% quality JPEG, <br> reminder : this format is destructive for image data");
	add_macro_button_with_hotKey("J", "save As LZW tiff", "space", "Lossless compression for RGB tiffs <br> i.e. final paper figure");
}

function add_SplitView_Action_Bar(){
	add_Text_Line("__________________ SplitView / Figures Macros");
	add_new_Line();
	add_macro_button_with_hotKey("p", "Preset linear figure", "alt", "Quickly make a linear grayscale SplitView <br> with colored labels and white borders<br> and copy the result so you can paste directly in a presentation slide");
	add_macro_button_with_hotKey("b", "Preset vertical figure", "alt", "Quickly make a vertical grayscale SplitView <br> with colored labels and white borders<br> and copy the result so you can paste directly in a presentation slide");
	add_new_Line();
	add_macro_button_with_hotKey("S", "All options dialog", "alt", "SplitView dialog to choose all parameters <br> Including border size and channel labels");
	add_new_Line();
	add_macro_button_with_hotKey("S", "Colored square", "none", "Colored square SplitView : For multichannel visualization,<br> Creates a RGB montage of composite and individual channels<br>You can still navigate through slices or frames");
	add_macro_button_with_hotKey("p", "Grayscale square", "space", "Grayscale square SplitView: For multichannel visualization,<br> Creates a RGB montage of composite and individual channels<br>You can still navigate through slices or frames");
	add_new_Line();
	add_macro_button_with_hotKey("S", "Colored linear", "space", "Colored linear SplitView: For multichannel visualization,<br> Creates a RGB montage of composite and individual channels<br>You can still navigate through slices or frames");
	add_macro_button_with_hotKey("p", "Grayscale linear", "none", "Grayscale linear SplitV For multichannel visualization,<br> Creates a RGB montage of composite and individual channels<br>You can still navigate through slices or frames");
	add_new_Line();
	add_macro_button_with_hotKey("b", "Colored vertical", "none", "Colored vertical SplitView: For multichannel visualization,<br> Creates a RGB montage of composite and individual channels<br>You can still navigate through slices or frames");
	add_macro_button_with_hotKey("b", "Grayscale vertical", "space", "Grayscale vertical SplitView: For multichannel visualization,<br> Creates a RGB montage of composite and individual channels<br>You can still navigate through slices or frames");
	add_new_Line();
	add_macro_button_with_hotKey("B", "Auto scale bar", "space", "Estimate a 'good' scale bar, <br>You can remove the text on the Multitool options");
}

function add_Numerical_Keyboard() {
	add_Text_Line("__________________ Numerical Keyboard Macros");
	add_new_Line();
	add_macro_button_without_hotKey("n7", "7 (cyan)", "none", "With space : toggle channel <br> With alt : toggle channel for all images");
	add_macro_button_without_hotKey("n8", "8 (magenta)", "none", "With space, convert current image to 8-bit <br> With alt, 16-bit");
	add_macro_button_without_hotKey("n9", "9 (yellow)", "none", " With space, apply Glasbey on dark LUT");
	add_new_Line();
	add_macro_button_without_hotKey("n4", "4 (k blue)", "none", "With space : toggle channel <br> With alt : toggle channel for all images");
	add_macro_button_without_hotKey("n5", "5 (k magenta)", "none", "With space : toggle channel <br> With alt : toggle channel for all images");
	add_macro_button_without_hotKey("n6", "6 (k orange)", "none", "With space : toggle channel <br> With alt : toggle channel for all images");
	add_new_Line();
	add_macro_button_without_hotKey("n1", "1 (grey)", "none", "With space : toggle channel <br> With alt : toggle channel for all images");
	add_macro_button_without_hotKey("n2", "2 (k green)", "none", "With space : toggle channel <br> With alt : toggle channel for all images");
	add_macro_button_without_hotKey("n3", "3 (red)", "none", "With space : toggle channel <br> With alt : toggle channel for all images");
	add_new_Line();
	add_macro_button_without_hotKey("n0", "0 (favorite)", "none", "With space, associate current LUT to numerical key 0");
}

function show_Other_Macros(){
	setup_Action_Bar_Header("Other Macros");
	add_new_Line();
	add_macro_button_with_hotKey("F", "MultiTool switch", "none", "Switch between current Tool (default is rectangle) and MultiTool icon");
	add_macro_button_with_hotKey("7", "Set target image", "none", "Stores the title of current image as 'target' image <br> for the Curtain Tool");
	add_new_Line();
	add_macro_button_with_hotKey("n", "Open Hela Cells", "none", "Open a croped version of Hela Cells sample image <br> and applies saved LUTs");
	add_macro_button_with_hotKey("N", "Num Keyboard Bar", "none", "Open the Numerical Keyboard shortcuts Action Bar");
	add_Text_Line("__________________ Selections / Duplicates");
	add_new_Line();
	add_macro_button_with_hotKey("a", "Restore Selection", "space", "Create same selection as previously active image,<br> or recreate last deleted one");
	add_macro_button_with_hotKey("D", "Duplicate full image", "none", "Duplicate full image");
	add_new_Line();
	add_macro_button_with_hotKey("a", "Select None", "alt", "Remove all ROIs of active image");
	add_macro_button_with_hotKey("d", "Duplicate Slice", "space", "Duplicates current slice only");
	add_new_Line();
	add_macro_button_with_hotKey("a", "Select All", "none", "Creates a selection on full image");
	add_macro_button_with_hotKey("d", "Duplicate full channel", "alt", "Duplicate full stack of current channel");
	add_Text_Line("__________________ LUTs");
	add_new_Line();
	add_macro_button_with_hotKey("f", "Gamma 0.8 on all LUTs", "space", "Adjust the gamma to 0.8 of all channels LUTs,<br> pixel values remain unchanged");
	add_macro_button_with_hotKey("i", "Invert all LUTs", "none", "Invert luminosity of all LUTs and <br> switch the display mode from Composite to Composite Invert");
	add_new_Line();
	add_macro_button_with_hotKey("x", "Copy LUT", "none", "Copy current LUT");
	add_macro_button_with_hotKey("v", "Paste LUT", "alt", "Paste LUT");
	add_new_Line();
	add_macro_button_with_hotKey("n0", "Set favorite LUT", "space", "Associate current LUT to numerical key 0 <br> default LUT is Inferno");
	add_macro_button_with_hotKey("Z", "LUT Channels Tool", "space", "Open the LUT Channels Tool from BioVoxxel Toolbox update site");
	add_Text_Line("__________________ Images");
	add_new_Line();
	add_macro_button_with_hotKey("v", "Paste system", "space", "Open the Image or text <br>from the current system Clipboard");
	add_macro_button_with_hotKey("i", "invert keep color", "space", "Create a RGB snapshot of current image and <br> invert brightness while keeping the same color hues");
	add_new_Line();
	add_macro_button_with_hotKey("9", "Save as test", "space", "Save current image as a temp file <br> to use it as a test image");
	add_macro_button_with_hotKey("9", "Open test image", "none", "Open test image");
	add_new_Line();
	add_macro_button_with_hotKey("4", "Make montage", "none", "Quickly make montage with scale set to 1");
	add_macro_button_with_hotKey("4", "Montage to stack", "space", "Convert montage to stack");
	add_Text_Line("__________________ Color Coding with copied LUT(x)");
	add_new_Line();
	add_macro_button_with_hotKey("g", "Max ColorCoding", "space", "Creates a color coded projection with the current copied LUT (x key) <br> This version is usefull for limited RAM devices <br> only the final projection is stored in memory");
	add_macro_button_with_hotKey("g", "ColorCoding no max", "alt", "Creates a RGB color coded stack of active channel with the current copied LUT <br> Note: A RGB stack is eavy, beware of available memory");
	add_Text_Line("__________________ Scripts");
	add_new_Line();
	add_macro_button_with_hotKey("j", "Open Script Editor", "none", "Open Script Editor");
	add_Bioformats_DnD();
	run("Action Bar", ACTION_BAR_STRING);
}


//--------------------------------------------------------------------------------------------------------------------------------------

function setup_Action_Bar_Header(main_Title){
	ACTION_BAR_STRING = "";
	if (isOpen(main_Title)) run("Close AB", main_Title);
	add_fromString();
	add_main_title(main_Title);
}

function setup_Popup_Action_Bar_Header(main_Title){
	ACTION_BAR_STRING = "";
	if (isOpen(main_Title)) run("Close AB", main_Title);
	add_Popup_fromString();
	add_main_title(main_Title);
	add_Code_Library();
}

function add_fromString(){	ACTION_BAR_STRING += "<fromString>\n<disableAltClose>\n";}

function add_Popup_fromString(){	ACTION_BAR_STRING += "<fromString>\n<popup>\n<onTop>\n";}

function add_Code_Library() {
	// substring to remove the autorun macro
	code_Library = File.openAsString(getDir("macros") + "/toolsets/Visualization_toolset.ijm");
	code_Library = substring(code_Library, code_Library, lengthOf(code_Library) - 489);
	ACTION_BAR_STRING += "<codeLibrary>\n" + code_Library + "</codeLibrary>\n";
}

function add_main_title(title){	ACTION_BAR_STRING += "<title>" + title + "\n";}

function add_new_Line(){	ACTION_BAR_STRING += "</line>\n<line>\n";}

function add_noGrid(){	ACTION_BAR_STRING += "<noGrid>\n";}

function add_Text_Line(text){	
	add_new_Line();
	ACTION_BAR_STRING += "<text>" + text + "\n";
}

function add_Text(text){	
	ACTION_BAR_STRING += "<text>" + text + "\n";
}
function add_button(color, label, command, tooltip){
	ACTION_BAR_STRING += "<button>\n"+
	"label=<html><font color='black'><b> " + label + "\n"+
	"tooltip=<html>" + tooltip + "\n"+
	"bgcolor=" + color + "\n"+
	"arg=" + command + "\n";
}

function add_gray_button(label, command, tooltip){
	ACTION_BAR_STRING += "<button>\n"+
	"label=<html><font color='black'><b> " + label + "\n"+
	"tooltip=<html>" + tooltip+ "\n"+
	"bgcolor=lightgray\n"+
	"arg=" + command + "\n";
}

function add_macro_button_with_hotKey(key, label, alt_space, tooltip){
	// auto adds hot keys <3
	if (alt_space == "none") {
		label += " (" + key + ")"; 
		add_gray_button( label, "run('[" + key + "]');" , tooltip);
	}
	else label += " (" + alt_space + "+" + key + ")"; 
	if (alt_space == "space") add_gray_button( label,	"setKeyDown('space');	run('[" + key + "]'); setKeyDown('none');", tooltip);
	if (alt_space == "alt")   add_gray_button( label,	"setKeyDown('alt');		run('[" + key + "]'); setKeyDown('none');", tooltip);
}

function add_macro_button_without_hotKey(key, label, alt_space, tooltip){
	add_gray_button( label, "run('[" + key + "]');" , tooltip);
	if (alt_space == "space") add_gray_button( label,	"setKeyDown('space');	run('[" + key + "]'); setKeyDown('none');", tooltip);
	if (alt_space == "alt")   add_gray_button( label,	"setKeyDown('alt');		run('[" + key + "]'); setKeyDown('none');", tooltip);
}

function add_Bioformats_DnD(){
	// drag and drop beahavior
	ACTION_BAR_STRING +=	"<DnDAction>"+"\n"+
	"path = getArgument();"+"\n"+
	"if (endsWith(path, '.mp4')) run('Movie (FFMPEG)...', 'choose='+ path +' first_frame=0 last_frame=-1');\n"+
	"else if (endsWith(path, '.pdf')) run('PDF ...', 'choose=' + path + ' scale=600 page=0');\n"+
	"else run('Bio-Formats Importer', 'open=[' + path + ']');\n"+
	"rename(File.nameWithoutExtension);\n"+
	"</DnDAction>\n";
}

//--------------------------------------------------------------------------------------------------------------------------------------

macro "AutoRun" {
	requires("1.53t");

	//set inferno as default favorite lut (numerical 0 key)
	if (!File.exists(getDirectory("temp") + "/favoriteLUT.lut"))
		File.copy(getDirectory("luts") + "mpl-inferno.lut", getDirectory("temp") + "/favoriteLUT.lut");

	//set viridis as default copied lut (alt + v)
	if (!File.exists(getDirectory("temp") + "/copiedLut.lut"))
		File.copy(getDirectory("luts") + "mpl-viridis.lut", getDirectory("temp") + "/copiedLut.lut");

	wait(10);
	setTool(15);
}
