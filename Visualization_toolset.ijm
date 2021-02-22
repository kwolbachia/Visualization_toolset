
//Tools for multichannel images visualization and multiple opened images handling
//kevin.terretaz@gmail.com

//1.0 070221
//1.1 080221 forgotten adjustments + up to 7 Set LUTs
//1.2 150221 bugs correction (Splitviews, Max all)


requires("1.53c");  // minimal version for extended hex icon feature 

/*----------------------------------------------------------------------------------------------------------------------
About menu
----------------------------------------------------------------------------------------------------------------------*/
var AboutCmds = newMenu("About Menu Tool",
	newArray("About this toolset", "Keyboard shortcuts cheat sheet"));
macro"About Menu Tool - B31C000T2e20?"{
	cmd = getArgument();
	if (cmd!="-") run(cmd);
}

/*----------------------------------------------------------------------------------------------------------------------
Reset the contrast of the active channel between the min and max of all slices, not just the active one.
----------------------------------------------------------------------------------------------------------------------*/
var first_click = 1  //to show help once per session
macro "Reset contrast Action Tool-N44CeeeD00CeeeD01CeeeD02CeeeD03CeeeD04CeeeD05CeeeD06CeeeD07CeeeD08CeeeD09CeeeD0aCeeeD0bCeeeD0cCeeeD0dCeeeD0eCeeeD0fCeeeD0gCeeeD0hCeeeD0iCeeeD0jCeeeD0kCeeeD0lCeeeD0mCeeeD0nCeeeD10CeeeD11CeeeD12CeeeD13CeeeD14CeeeD15CeeeD16Ce15D17Cf9bD18CeeeD19CeeeD1aCeeeD1bCeeeD1cCeeeD1dCeeeD1eCf9bD1fCe15D1gCeeeD1hCeeeD1iCeeeD1jCeeeD1kCeeeD1lCeeeD1mCeeeD1nCeeeD20CeeeD21CeeeD22CeeeD23CeeeD24CeeeD25CeeeD26Ce15D27Ce15D28CeeeD29CeeeD2aCeeeD2bCeeeD2cCeeeD2dCeeeD2eCe15D2fCe15D2gCeeeD2hCeeeD2iCeeeD2jCeeeD2kCeeeD2lCeeeD2mCeeeD2nCeeeD30CeeeD31CeeeD32CeeeD33CeeeD34CeeeD35CeeeD36Cf9bD37Ce15D38CeeeD39CeeeD3aCeeeD3bCeeeD3cCeeeD3dCeeeD3eCe15D3fCf9bD3gCeeeD3hCeeeD3iCeeeD3jCeeeD3kCeeeD3lCeeeD3mCeeeD3nCeeeD40CeeeD41CeeeD42CeeeD43CeeeD44CeeeD45CeeeD46CeeeD47CeeeD48CfefD49CbabD4aC999D4bC999D4cCbbbD4dCfffD4eCeeeD4fCeeeD4gCeeeD4hCeeeD4iCeeeD4jCeeeD4kCeeeD4lCeeeD4mCeeeD4nCeeeD50CeeeD51CeeeD52CeeeD53CeeeD54CeeeD55CeeeD56CeeeD57C767D58C112D59C101D5aC101D5bC101D5cC101D5dC112D5eC767D5fCeeeD5gCeeeD5hCeeeD5iCeeeD5jCeeeD5kCeeeD5lCeeeD5mCeeeD5nCeeeD60CeeeD61CeeeD62CeeeD63CeeeD64CeeeD65CdddD66C323D67C101D68C213D69C224D6aC224D6bC224D6cC224D6dC113D6eC101D6fC323D6gCdddD6hCeeeD6iCeeeD6jCeeeD6kCeeeD6lCeeeD6mCeeeD6nCeeeD70Ce15D71Ce15D72Cf9bD73CeeeD74CeeeD75C323D76C112D77C224D78C234D79C234D7aCeeeD7bC234D7cC234D7dC234D7eC224D7fC112D7gC323D7hCeeeD7iCeeeD7jCf9bD7kCe15D7lCe15D7mCeeeD7nCeeeD80Cf9bD81Ce15D82Ce15D83CeeeD84C767D85C101D86C224D87C234D88C234D89C234D8aCeeeD8bC234D8cC234D8dC234D8eC234D8fC224D8gC101D8hC767D8iCeeeD8jCe15D8kCe15D8lCf9bD8mCeeeD8nCeeeD90CeeeD91CeeeD92CeeeD93CfefD94C112D95C213D96C234D97C234D98C234D99C234D9aCeeeD9bC234D9cC234D9dC234D9eC234D9fC234D9gC113D9hC112D9iCfffD9jCeeeD9kCeeeD9lCeeeD9mCeeeD9nCeeeDa0CeeeDa1CeeeDa2CeeeDa3CbabDa4C101Da5C224Da6C234Da7C234Da8C234Da9C234DaaCeeeDabC234DacC234DadC234DaeC234DafC234DagC224DahC101DaiCbbbDajCeeeDakCeeeDalCeeeDamCeeeDanCeeeDb0CeeeDb1CeeeDb2CeeeDb3C999Db4C101Db5C224Db6C234Db7C234Db8C234Db9C234DbaC234DbbC234DbcC234DbdC234DbeC234DbfC234DbgC224DbhC101DbiC999DbjCeeeDbkCeeeDblCeeeDbmCeeeDbnCeeeDc0CeeeDc1Cf9aDc2Cf47Dc3Cf47Dc4Ce25Dc5Ce26Dc6Cf69Dc7Cf69Dc8Cf69Dc9Cf69DcaCf69DcbCf69DccCf69DcdCf69DceCf69DcfCf69DcgCe26DchCe26DciCf47DcjCf47DckCf9aDclCeeeDcmCeeeDcnCeeeDd0CeeeDd1CfffDd2Cf68Dd3Cf47Dd4Ce26Dd5Ce15Dd6Cf69Dd7Cf69Dd8Cf69Dd9Cf69DdaC101DdbCf69DdcCf69DddCf69DdeCf69DdfCf69DdgCe15DdhCe26DdiCf47DdjCf68DdkCfffDdlCeeeDdmCeeeDdnCeeeDe0CeeeDe1CeeeDe2CfeeDe3Cf57De4Cf36De5Ce15De6Cf48De7Cf69De8Cf69De9Cf69DeaC101DebCf69DecCf69DedCf69DeeCf69DefCf47DegCe15DehCf36DeiCf57DejCfeeDekCeeeDelCeeeDemCeeeDenCeeeDf0Cf9bDf1Ce15Df2Ce15Df3Cf9bDf4Cf47Df5Ce15Df6Ce15Df7Cf58Df8C101Df9C101DfaC101DfbC101DfcC101DfdCf69DfeCf58DffCe15DfgCe25DfhCf47DfiCf9bDfjCe15DfkCe15DflCf9bDfmCeeeDfnCeeeDg0Ce15Dg1Ce15Dg2Cf9bDg3CfbcDg4Cf47Dg5Cf47Dg6Ce15Dg7Ce15Dg8Cf47Dg9Cf69DgaC101DgbCf69DgcCf69DgdCf47DgeCe15DgfCe15DggCf47DghCf47DgiCfbcDgjCf9bDgkCe15DglCe15DgmCeeeDgnCeeeDh0CeeeDh1CeeeDh2CeeeDh3CfbcDh4Cf47Dh5Cf47Dh6Cf47Dh7Ce25Dh8Ce15Dh9Ce15DhaC101DhbCe26DhcCe15DhdCe15DheCe25DhfCf47DhgCf47DhhCf47DhiCfbcDhjCeeeDhkCeeeDhlCeeeDhmCeeeDhnCeeeDi0CeeeDi1CeeeDi2CeeeDi3CfeeDi4CfccDi5Cf47Di6Cf47Di7Cf47Di8Cf36Di9Ce26DiaCe26DibCe25DicCe26DidCf36DieCf47DifCf47DigCf47DihCfccDiiCfeeDijCeeeDikCeeeDilCeeeDimCeeeDinCeeeDj0CeeeDj1CeeeDj2CeeeDj3CeeeDj4CfeeDj5CfccDj6CfbcDj7Cf9bDj8Cf57Dj9Cf47DjaCf47DjbCf47DjcCf47DjdCf57DjeCf9bDjfCfbcDjgCfccDjhCfeeDjiCeeeDjjCeeeDjkCeeeDjlCeeeDjmCeeeDjnCeeeDk0CeeeDk1CeeeDk2CeeeDk3CeeeDk4CeeeDk5CeeeDk6Cf9bDk7Ce15Dk8CfeeDk9Cf68DkaCf47DkbCf47DkcCf68DkdCfeeDkeCe15DkfCf47DkgCeeeDkhCeeeDkiCeeeDkjCeeeDkkCeeeDklCeeeDkmCeeeDknCeeeDl0CeeeDl1CeeeDl2CeeeDl3CeeeDl4CeeeDl5CeeeDl6Ce15Dl7Ce15Dl8CeeeDl9CfffDlaCf9aDlbCf9aDlcCfffDldCeeeDleCe15DlfCe15DlgCeeeDlhCeeeDliCeeeDljCeeeDlkCeeeDllCeeeDlmCeeeDlnCeeeDm0CeeeDm1CeeeDm2CeeeDm3CeeeDm4CeeeDm5CeeeDm6Ce15Dm7Cf9bDm8CeeeDm9CeeeDmaCeeeDmbCeeeDmcCeeeDmdCeeeDmeCf47DmfCe15DmgCeeeDmhCeeeDmiCeeeDmjCeeeDmkCeeeDmlCeeeDmmCeeeDmnCeeeDn0CeeeDn1CeeeDn2CeeeDn3CeeeDn4CeeeDn5CeeeDn6CeeeDn7CeeeDn8CeeeDn9CeeeDnaCeeeDnbCeeeDncCeeeDndCeeeDneCeeeDnfCeeeDngCeeeDnhCeeeDniCeeeDnjCeeeDnkCeeeDnlCeeeDnmCeeeDnn" {
	if (first_click == 1){
	Dialog.createNonBlocking("First click info");
	Dialog.addMessage("Especially usefull for stacks (but not restricted to),\n"+
		"this macro resets the min and max based on the entire stack \n"+
		"so you can navigate through slices without signal saturation.\n"+
		"Tip : if you have bright spots on your stack,\n"+
		"use the tool with an ROI on your signal of interest.",12);
	Dialog.show();
	first_click = 0;
	Reset_contrast();
	}
	else Reset_contrast();
}

/*----------------------------------------------------------------------------------------------------------------------
Right click on any image window to open this menu.
Same popup menu than the original, plus the "Set LUTs" and "Add note in info" macros. Cutomizable.
----------------------------------------------------------------------------------------------------------------------*/
var pmCmds = newMenu("Popup Menu",
	newArray("Set LUTs", "Auto-contrast on all channels", "Rename...", "Duplicate...", "Original Scale", "Scale to Fit",
		"Add note in info","-","Record...", "Capture Screen ", "Monitor Memory...",
		"Find Commands...", "Control Panel...", "Startup Macros...", "Search..."));
macro "Popup Menu" {
	cmd = getArgument();
	if (cmd!="-") run(cmd);
}

/*----------------------------------------------------------------------------------------------------------------------
Menu for Splitview tools and help
----------------------------------------------------------------------------------------------------------------------*/
var zCmds = newMenu("SplitView tools Menu Tool",
	newArray("Splitview ([S] key)","Grayscale Splitview (with color composite)","About Splitview"));
macro"SplitView tools Menu Tool - N55C000D00D01D02D03D04D05D06D07D08D09D0aD0bD0dD0eD10D11D12D13D14D15D16D19D1dD1eD20D21D22D23D24D25D26D27D2dD2eD30D31D33D35D3dD3eD40D43D4dD4eD50D52D53D5dD5eD60D61D6dD6eD9bD9eDa0Da1Da2Da3Da5Da6DadDaeDb0Db1Db2Db3Db6Db7Db8Db9DbaDbbDbdDbeDc0Dc1Dc2Dc3Dc4Dc5Dc6Dc7Dc8Dc9DcaDcbDcdDceDe0De1De2De3De4De5De6De7De8De9DeaDebDedDeeC000D17D1bD32D34D41D51D90D91D9dDa9DaaDabDb4Db5C82aD28D29D36D37D3aD45D54D63D72D81D82D83D8aD8eD94D99C010D5bC0eeC101D18D1aD2bD3bD42D44D62D70D7dD92Da4Da8Cf0fC523D8bCfffD0cD1cD2cD3cD46D47D4cD55D56D57D58D5cD65D66D67D68D6cD75D76D77D7cD8cD9cDacDbcDccDd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7Dd8Dd9DdaDdbDdcDddDdeDecC000Ce0eD38D4aD5aD6aD73D7aD95D96D97D98C023D6bD7bCfcfD64D74C404D2aD4bD71D7eD80D8dD93D9aDa7Cf4fD39D48D49D59D69D78D79D84D85D86D87D88D89Cee0Bf0C000D00D01D02D03D04D05D06D07D08D09D0aD0bD0dD0eD10D11D12D13D14D15D16D1bD1dD1eD20D21D22D23D24D2bD2dD2eD30D31D32D33D3bD3dD3eD40D41D42D43D4bD4dD4eD50D51D5bD5dD5eD60D68D6dD6eD70D71D72D73D77D78D79D7aD7dD7eD80D81D82D83D84D86D87D88D89D8aD8bD8dD8eD90D91D92D93D94D95D96D97D98D99D9aD9bD9dD9eDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDadDaeC000C82aC010D18D19D2aD3aD4aD5aD76C0eeD35D36D37D38D44D45D46D47D48D54D55D56D57D64D65D66C101Cf0fC523CfffD0cD1cD2cD3cD4cD5cD6cD7cD8cD9cDacC000D17D1aD52D61D62D69D6aD6bD7bD85Ce0eC023D25D26D27D28D29D34D39D49D53D58D59D63D67D74D75CfcfC404Cf4fCee0B0fC000D00D01D02D03D04D05D06D07D08D09D0aD10D11D14D18D19D1aD20D21D22D28D29D2aD30D31D39D3aD40D41D48D49D4aD50D57D58D59D5aD60D66D67D68D69D70D71D74D75D76D77D78D79D80D81D82D83D84D85D86D87D88D89D8aD90D91D92D93D94D95D96D97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaC000D12D13D15D38D6aD72D7aC82aC010D16D17D27D51D61D73C0eeC101Cf0fC523D23D26D32D37D47D56D62D65CfffC000Ce0eC023CfcfC404Cf4fCee0D24D25D33D34D35D36D42D43D44D45D46D52D53D54D55D63D64Nf0C000D00D01D02D03D05D06D07D08D09D0aD10D11D12D13D14D15D17D1aD20D21D22D23D24D25D31D32D33D3aD41D4aD50D51D5aD6aD7aD89D8aD99Da0Da1Da2Da3Da9DaaDb0Db1Db3Db4Db5Db6Db7Db8Db9DbaDc0Dc1Dc2Dc3Dc4Dc5Dc6Dc7Dc8Dc9DcaDe0De1De2De3De4De5De6De7De8De9DeaC000D16D19D29D2aD30D40D42D60D9aDa7Da8Db2C82aD27D35D38D43D48D52D68D70D80D81D88D92D96D97C010C0eeC101D04D18D39D59D69D90Da4Da5Da6Cf0fD37D44D45D46D47D53D54D55D56D57D62D63D64D65D66D67D72D73D74D75D76D77D82D83D84D85C523CfffDd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7Dd8Dd9DdaC000Ce0eD36D58D71D78D86D87D93D94D95C023CfcfC404D26D28D34D49D61D79D91D98Cf4fCee0"{
	cmd = getArgument();
	if (cmd=="Splitview ([S] key)") run("Splitview");
	else run(cmd);
}

/*----------------------------------------------------------------------------------------------------------------------
This menu is for macro tools that acts on all opened images
----------------------------------------------------------------------------------------------------------------------*/
var yCmds = newMenu("All opened images tools Menu Tool",
	newArray("Reset all contrasts","Set all LUTs","Maximum Z project all","Save all"));
macro"All opened images tools Menu Tool - N55C000D0dD0eD1dD1eD2dD3dD3eD4dD4eD59D5aD5bD5dD5eD6bD6dD6eD73D77D78D79D7bD7dD83D84D85D88D8bD8dD8eD94D99D9dD9eDa3Da6Da8Da9DadDaeDb3Db8Db9Dc3Dc6Dc8Dc9DcdDd4Dd9DdbDdcDddDe3De4De5De8DebDecDedC4cfCe16D74D75D76D86D87D89D93D95D96D97D98Da4Da5Da7Db4Db5Db6Db7Dc4Dc5Dc7Dd3Dd5Dd6Dd7Dd8De6De7De9CfffD0cD1cD2cD3cD48D49D4aD4bD4cD58D5cD62D63D64D65D66D67D68D69D6aD6cD72D7aD7cD82D8aD8cD92D9aD9cDa2DaaDacDb2DbaDbcDbdDbeDc2DcaDceDd2DdaDdeDe1De2DeaDeeCeeeD00D01D02D03D04D05D06D07D08D09D0aD0bD10D11D12D13D14D15D16D17D18D19D1aD1bD20D21D22D23D24D25D26D27D28D29D2aD2bD30D31D32D33D34D35D36D37D38D39D3aD3bD40D41D42D43D44D45D46D47D50D51D52D53D54D55D56D57D60D61D70D71D80D81D90D91Da0Da1Db0Db1Dc0Dc1Dd0Dd1De0Cfe3D9bDabDbbDcbDccCc15C4deC8c4D2eD7eBf0C000D03D07D08D09D13D14D15D16D17D18D19D1dD1eD2eD32D34D35D36D3dD42D45D46D4dD52D55D56D5dD62D63D64D65D66D6eD72D73D74D75D76D7dD7eD8dD8eC4cfD33D43D44D53D54Ce16D04D05D06CfffD01D02D0aD0bD0cD0dD0eD11D12D1aD1cD21D22D23D24D25D26D27D28D29D2aD2cD31D37D3cD41D47D4cD51D57D5cD61D67D6cD71D77D7cD81D82D83D84D85D86D87D8cD9cD9dD9eCeeeD00D10D1bD20D2bD30D38D39D3aD3bD40D48D49D4aD4bD50D58D59D5aD5bD60D68D69D6aD6bD70D78D79D7aD7bD80D88D89D8aD8bD90D91D92D93D94D95D96D97D98D99D9aD9bDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDacDadDaeCfe3Cc15C4deD2dD3eD4eD5eD6dC8c4B0fC000D00D01D02D03D04D05D10D11D12D15D23D24D25D35D43D44D45D55D63D64D65D70D71D72D75D80D81D82D83D84D85C4cfCe16CfffD06D16D26D36D46D56D66D76D86D90D91D92D93D94D95D96CeeeD07D08D09D0aD17D18D19D1aD27D28D29D2aD37D38D39D3aD47D48D49D4aD57D58D59D5aD67D68D69D6aD77D78D79D7aD87D88D89D8aD97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaCfe3Cc15D31D51C4deD13D14D20D21D22D30D32D33D34D40D41D42D50D52D53D54D60D61D62D73D74C8c4Nf0C000D00D01D02D05D06D07D10D11D14D15D16D17D20D25D27D32D36D37D40D45D46D47D50D55D56D57D62D66D67D70D75D77D80D81D84D85D86D87D90D91D92D95D96D97Da0Da1Da2Da3Da4Da5Da6Da7C4cfCe16CfffD08D18D28D38D48D58D68D78D88D98Da8Db0Db1Db2Db3Db4Db5Db6Db7Db8De0De1De2De3De4De5De6CeeeD09D0aD19D1aD29D2aD39D3aD49D4aD59D5aD69D6aD79D7aD89D8aD99D9aDa9DaaDb9DbaDc0Dc1Dc2Dc3Dc4Dc5Dc6Dc7Dc8Dc9DcaDd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7Dd8Dd9DdaDe7De8De9DeaCfe3Cc15C4deC8c4D03D04D12D13D21D22D23D24D26D30D31D33D34D35D41D42D43D44D51D52D53D54D60D61D63D64D65D71D72D73D74D76D82D83D93D94"{
	cmd = getArgument();
	if (cmd!="-") run(cmd);
}

/*
//Built-in Stack and LUT menus
 macro "Stacks Menu Built-in Tool" {}
 macro "LUT Menu Built-in Tool" {}
*/

/*----------------------------------------------------------------------------------------------------------------------
For multichannel visualization, 5 channel max
This macro will generate a montage of composite and splited channels in one RGB Image
You can still navigate through slices or frames. 
Note : the Splitview image size can be heavy on big hyperstacks due to RGB conversion
Advice : draw a selection before running Spliview, the produced montage will be croped
----------------------------------------------------------------------------------------------------------------------*/
macro "Splitview" {
	setBatchMode(true);
	getDimensions(w, h, channels, slices, frames);
	title = getTitle();
	if (channels == 1) exit("only one channel");
	if (channels > 5) exit("5 channels max");
	run("Duplicate...", "title=image duplicate");
	if ((slices > 1) && (frames == 1)) {	//necessary trick for easy RGB conversion of Zstacks and timelapses
		frames = slices;
		slices = 1;
		Stack.setDimensions(channels, slices, frames); 
	} 
	run("Duplicate...", "title=split duplicate");
	run("Split Channels");
	selectWindow("image");
	Stack.setDisplayMode("composite");
	run("RGB Color", "frames");
	rename("overlay");
	close("image");
	for (i = 1; i <= channels; i++) {
		selectWindow("C"+i+"-split");
		run("RGB Color", "slices"); 
	}
	if (channels == 2) {
		run("Combine...", "stack1=overlay stack2=C1-split");
		run("Combine...", "stack1=[Combined Stacks] stack2=C2-split"); //combine horizontaly
	} 
	if (channels == 3) {
		run("Combine...", "stack1=overlay stack2=C1-split");
		run("Combine...", "stack1=C2-split stack2=C3-split");
		rename("Combined2");
		run("Combine...", "stack1=[Combined Stacks] stack2=Combined2 combine");	//last 'combine' = verticaly
	} 
	if (channels >= 4) { 
		run("Combine...", "stack1=C1-split stack2=C2-split");
		run("Combine...", "stack1=C3-split stack2=C4-split");
		rename("Combined2");
		run("Combine...", "stack1=[Combined Stacks] stack2=Combined2 combine"); 
	}
	if (channels == 4) run("Combine...", "stack1=overlay stack2=[Combined Stacks]");
	if (channels == 5) {
		rename("Combined3");
		run("Combine...", "stack1=overlay stack2=C5-split combine");
		run("Combine...", "stack1=[Combined Stacks] stack2=Combined3"); 
	}
	rename(title + " Splitview");
	setBatchMode("exit and display");
}


macro "Grayscale Splitview (with color composite)" {
	setBatchMode(true);
	getDimensions(w, h, channels, slices, frames);
	title = getTitle();
	if (channels == 1) exit("only one channel");
	if (channels > 5) exit("5 channels max");
	run("Duplicate...", "title=image duplicate");
	if ((slices > 1) && (frames == 1)) {
		frames = slices;
		slices = 1;
		Stack.setDimensions(channels, slices, frames); 
	}
	run("Duplicate...", "title=split duplicate");
	run("Split Channels");
	selectWindow("image");
	Stack.setDisplayMode("composite");
	run("RGB Color", "frames");
	rename("overlay");
	close("image");
	for (i = 1; i <= channels; i++) {
	selectWindow("C"+i+"-split");
	run("Grays");
	run("RGB Color", "slices"); 
	}
		if (channels == 2) {
			run("Combine...", "stack1=overlay stack2=C1-split");
			run("Combine...", "stack1=[Combined Stacks] stack2=C2-split"); 
		}
		if (channels == 3) {
			run("Combine...", "stack1=overlay stack2=C1-split");
			run("Combine...", "stack1=C2-split stack2=C3-split");
			rename("Combined2");
			run("Combine...", "stack1=[Combined Stacks] stack2=Combined2");	
		}
		if (channels >= 4) {
			run("Combine...", "stack1=C1-split stack2=C2-split");
			run("Combine...", "stack1=C3-split stack2=C4-split");
			rename("Combined2");
			run("Combine...", "stack1=[Combined Stacks] stack2=Combined2"); 
		}
		if (channels == 4) run("Combine...", "stack1=overlay stack2=[Combined Stacks]");
		if (channels == 5) {
			rename("Combined3");
			run("Combine...", "stack1=Combined3 stack2=C5-split");
			run("Combine...", "stack1=overlay stack2=[Combined Stacks]"); 
		}
	rename(title + " Splitview");
	setBatchMode("exit and display");
}

macro "About Splitview" {
	showMessage("About Splitview", "Splitview is a visualisation tool for multichannel images with up to 5 channels:\n"
		+"This macro will generate a montage of composite and separated channels in one RGB Image.\n"
		+"You can still navigate through slices or frames.\n \n"
		+"Note: the Splitview image size can be heavy on big hyperstacks due to RGB conversion.\n"
		+"Advice: draw a selection before running Spliview, the produced montage will be croped.");
}

//----------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------

/*----------------------------------------------------------------------------------------------------------------------
function for all opened images processing : puts images ID in the all_IDs array : easier to avoid loop errors after.(thanks Jerome)
----------------------------------------------------------------------------------------------------------------------*/
var all_IDs = newArray(1);

function Get_all_IDs() {
	all_IDs = newArray(nImages);
	for (a=0; a<nImages ; a++) {		
		selectImage(a+1);
		all_IDs[a] = getImageID(); 
	} 
}

/*----------------------------------------------------------------------------------------------------------------------
functions for Set LUTs macros
----------------------------------------------------------------------------------------------------------------------*/
var chosen_LUTs = newArray(7);

function Get_LUTs(){   
	LUT_list = newArray("Cyan","Magenta","Yellow","Grays","Red","Green","Blue");//Add you favorite or personnal LUTs in the list to see them in dialog.
	Dialog.create("Set all LUTs");
	Dialog.addChoice("LUT 1", LUT_list, "Cyan"); //the last argument is the default selection
	Dialog.addChoice("LUT 2", LUT_list, "Magenta");
	Dialog.addChoice("LUT 3", LUT_list, "Yellow");
	Dialog.addChoice("LUT 4", LUT_list, "Grays");
	Dialog.addChoice("LUT 5", LUT_list, "Green");
	Dialog.addChoice("LUT 6", LUT_list, "Grays");
	Dialog.addChoice("LUT 7", LUT_list, "Grays");
	Dialog.show();
	for (k = 0; k < 7; k++) {
	chosen_LUTs[k] = Dialog.getChoice(); 
	}
}

function Set_LUTs(){
	getDimensions(width, height, channels, slices, frames);
	if(channels > 1){
		Stack.setDisplayMode("composite");
		for (A = 1; A <= channels; A++) {
		Stack.setChannel(A);
		run(chosen_LUTs[A-1]);	
		}
	}
	else {run(chosen_LUTs[0]);}	//need "if / else" because Stack.setChannel doesn't work on single dimension images
} 


/*----------------------------------------------------------------------------------------------------------------------
"Set LUTs" applies the chosen LUTs from left to right. Up to five channels.
"Set all LUTs" does the same with all opened images. Images don't need to have same number of channels.
----------------------------------------------------------------------------------------------------------------------*/
macro "Set LUTs"{
	Get_LUTs();
	Set_LUTs();
}

macro "Set all LUTs"{
	Get_LUTs();
	setBatchMode(1);
	Get_all_IDs();
	for (b=0; b<nImages; b++) {
		selectImage(all_IDs[b]);
		if ( bitDepth() != 24) Set_LUTs();	//only if not RGB
	}
	setBatchMode(0);
}
//----------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------

/*----------------------------------------------------------------------------------------------------------------------
function for Reset contrast macros :
Reset the contrast window between min and max on active channel
----------------------------------------------------------------------------------------------------------------------*/
function Reset_contrast() { 
	setBatchMode(1);
	id = getImageID();
	getDimensions(width, height, channels, slices, frames);
	if (slices*frames*channels == 1) {
		getStatistics(area, mean, min, max, std, histogram);
	}
	else if (slices*frames == 1 && channels>1)	{
		Stack.getPosition(channel, slice, frame);
		run("Duplicate...", "title=A duplicate channels=&channel"); //duplicate only the active channel and name it "A"
		getStatistics(area, mean, min, max, std, histogram);
	}
	else {
		Stack.getPosition(channel, slice, frame);
		run("Duplicate...", "title=A duplicate channels=&channel");
		Stack.getStatistics(voxelCount, mean, min, max, stdDev);
	}
	selectImage(id);
	setMinAndMax(min, max);
	close("A");
	setBatchMode(0);
}
/*----------------------------------------------------------------------------------------------------------------------
the getStatistics function only works on single dimension image
the Stack.getStatistics get the min max of entire stacks, but when multiple channels it returns one min max based on all dimensions.
That's why this macro function had to be adapted to the 3 cases of,
 1 slice / 1 color ; 1slice / multiple colors ; multiple slices / multiple color 
----------------------------------------------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------------------------------------------
Reset the contrast window between min and max on all individual channels
----------------------------------------------------------------------------------------------------------------------*/
macro "Auto-contrast on all channels" {
    getDimensions(width, height, channels, slices, frames);
	if(channels>1)	{
		for (A = 1; A <= channels; A++) {
			Stack.setChannel(A);
			Reset_contrast();
		}
	}
	else {Reset_contrast();}
}

/*----------------------------------------------------------------------------------------------------------------------
Reset the contrast window between min and max on all opened images, for all stacks and individual channels (fairly quickly)
----------------------------------------------------------------------------------------------------------------------*/
macro "Reset all contrasts" {
	Get_all_IDs();
	for (b=0; b<all_IDs.length; b++) {
		showProgress(b/all_IDs.length);
		selectImage(all_IDs[b]);
	    run("Auto-contrast on all channels");	
	}
}

//----------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------

/*----------------------------------------------------------------------------------------------------------------------
Saves all opened images as Tiff in selected directory, but be carefull:
Any image in the directory with same name will be replaced without warning!
----------------------------------------------------------------------------------------------------------------------*/
macro "Save all" { 
	dir = getDirectory("Choose a directory");
	for (i=0;i<nImages;i++) {
        selectImage(i+1);
        title = getTitle;
        saveAs("tiff", dir+title);
        print(title + " saved");
	} 
}

/*----------------------------------------------------------------------------------------------------------------------
This macro will run a maximal intensity projection on all opended images, close the primary stacks and run "Tile".
Can be handy to get a quick overview of multiple hyperstacks.
----------------------------------------------------------------------------------------------------------------------*/
macro "Maximum Z project all" {
	setBatchMode(1);
	Get_all_IDs();
	for (b=0; b<all_IDs.length; b++) {
		selectImage(all_IDs[b]);
		getDimensions(w, h, channels, slices, frames);
		if (channels*slices*frames!=1) run("Z Project...", "projection=[Max Intensity] all"); 
	}
	for (c=0; c<all_IDs.length ; c++) {	//Close not projected images
		selectImage(all_IDs[c]);
		getDimensions(w, h, channels, slices, frames);
		if (channels*slices*frames!=1) close();
	}
	setBatchMode("exit and display");
	run("Tile");
}

/*----------------------------------------------------------------------------------------------------------------------
Add a line of text on top of the image "info" metadata.
The text is saved in image file.
----------------------------------------------------------------------------------------------------------------------*/
macro "Add note in info"{
A=getMetadata("Info");
Dialog.create("Add comment on top of info file([i] key)");
Dialog.addString("note :", "", 100);
Dialog.show();
Comment = Dialog.getString();
setMetadata("Info", Comment+'\n\n'+A);
run("Show Info...");
}


/*----------------------------------------------------------------------------------------------------------------------
numerical key shortcuts for most common LUTs, [n7] to [n9]remains for your favorites.
----------------------------------------------------------------------------------------------------------------------*/
macro "Gray [n1]"		{run("Grays");}
macro "Green [n2]"		{run("Green");}
macro "Red [n3]"		{run("Red");}
macro "Cyan [n4]"		{run("Cyan");}
macro "Magenta [n5]"	{run("Magenta");}
macro "Yellow [n6]"		{run("Yellow");}

//key shortcuts for what I think are frequently used commands with opened images. Plus some usefull tricks.

macro "auto [A]"					{run("Enhance Contrast", "saturated=0.3");} //almost same as "Auto" button in Brightness tool.

macro "Tile [E]"					{run("Tile");}

macro "Auto contrast all Ch [R]"	{run("Auto-contrast on all channels");} //sortcut for macro

macro "Auto contrast [r]"			{Reset_contrast();}

macro "sync [y]"					{run("Synchronize Windows");}

macro "Arrange [q]"					{run("Arrange Channels...");}

macro "Splitview [S]"				{run("Splitview");}

macro "Splitview [p]"				{run("Grayscale Splitview (with color composite)");}

macro "Split Channel[d]"			{run("Split Channels");}

macro "duplicate [D]"				{run("Duplicate...", "duplicate");}

macro "Merge [M]"					{run("Merge Channels...");}

macro "Z Project [g]"				{run("Z Project...");}

macro "Max [G]"						{run("Z Project...", "projection=[Max Intensity] all");}

macro "Save as tiff [T]"			{saveAs("Tiff");}

macro "composite switch [Q]" {//easy switch between Color, Grayscale and Composite mode on multichannel images.
	msg="";
	if (nImages<1) msg='no image';
	if (!is("composite")) msg='not a composite image';
	if (msg!="") exit(msg);
	modes=newArray("Composite","Color","Grayscale");
	Stack.getDisplayMode(mode);
	m=0;
	for (i=0;i<modes.length;i++) 
		if (mode==modes[i].toLowerCase()) m=i;
	m=(m+1)%3;
	Stack.setDisplayMode(modes[m]);
	showStatus("Display mode set to : "+modes[m]);
	
	//Stack.getDisplayMode(mode);
	//if (mode == "color" || mode == "greyscale"){Stack.setDisplayMode("composite");} 
	//else {Stack.setDisplayMode("color");}
}	//thanks to Nick George!

//----------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------

macro "About this toolset" {
	Dialog.createNonBlocking("Visualization Toolset description");
	Dialog.addMessage("This toolset intends to facilitate visualization of multichannel images and stacks.\n"+" \n"+
	"Tools for single images:\n"+
	"______________________________________________________________________________\n"+
	"* Splitview : menu icon or press [S] (colored) or [p] (grayscale).\n"+
	"            Creates a RGB montage of composite and splited channels.\n"+
	"            Grayscale splitview is a linear montage with overlay and grey channels.\n"+
	"            You can still navigate through slices or frames.\n"+
	"______________________________________________________________________________\n"+
	"* Set image LUTs : open popup menu (Right click on the image) and select 'Set LUTs':\n"+
	"            Applies all the chosen LUTs (false colors) to your multichannel image.\n"+
	"______________________________________________________________________________\n"+
	"* Auto-contrast min-max : Click on Contrast icon or [r]:\n"+
	"            Resets the contrast window of the active channel. For stacks, it is based\n"+
	"            on all slices, not just the displayed one.(Also works on a selected region of image).\n"+
	"            To Reset all channels at once, select in popup 'Reset all channels' or press [R]\n"+
	"______________________________________________________________________________\n"+
	"* Tools for all opended images : in the 'All images menu icon':\n"+
	"           - Set all LUTs : \n"+
	"                    applies the chosen LUTs to all images.\n"+
	"           - Reset all contrasts : \n"+
	"                    Reset contrast of all individual channels and all opened images.\n"+
	"           - Maximum Z project all : \n"+
	"                    Run a maximal intensity projection on all opended stacks,\n"+
	"                    then close the stacks and run 'Tile' to see all windows.\n"+
	"                    Can be handy to get a quick overview of stacks content.\n"+
	"           - Save all : \n"+
	"                    Saves all opened images as Tiff in a specified directory.\n"+
	"                    Be carefull : it will erase files with similar names with no warning.\n"+
	"        ______________________________________________________________________________\n"+
	"* a handy macro shortcut :\n"+
	"	- [ Q ]   easy switch between Color and Composite mode on multichannel images.\n"+
	"______________________________________________________________________________\n"+
	"* Keyboard shortcuts for frequently used commands in Imagej\n"+
	"  All described in the cheat sheet of the ' ? ' menu.\n"+
	"  (Maintain ctrl (pc) or cmd (mac) key to access the built-in shortcuts of Imagej)\n"+" \n"+
	"Final note : The Visualization_Toolset.ijm file has been written in the most \n"+
	"readable way possible (well I did my best) in order to be easily customized or adjusted.\n"+
	"i.e. if you don't like keyboard shortcuts, you can delete them or change the [key]",12);
	Dialog.show();
}

macro "Keyboard shortcuts cheat sheet" {
	Dialog.createNonBlocking("keyboard shortcuts");
	Dialog.addMessage("* Macro shortcuts :\n"+
	"[ Q ]___switch color and composite mode\n"+
	"[ R ]___Auto-contrast all channels\n"+
	"[ r ]___Auto-contrast active channel\n"+

	"[ S ]___Colored splitview\n"+
	"[ p ]___Grayscale splitview\n"+
	"____________________________________\n"+
	"* Frequently used commands in Imagej: \n"+
	"[ A ]___Run Enhance Contrast, saturated=0.3\n"+
	"[ E ]___Tile : reorder windows to see all\n"+
	"[ y ]___Open the tool 'synchronize windows'\n"+
	"[ q ]___Arrange channels order\n"+
	"[ d ]___Split Channels\n"+
	"[ M ]___Merge channels\n"+
	"[ D ]___Duplicate (all dimensions)\n"+
	"[ g ]___Z projection dialog \n"+
	"[ G ]___Maximal intensity projection\n"+
	"[ T ]___Save as Tiff",12);
	Dialog.show();
}







