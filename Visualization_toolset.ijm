//Tools for multichannel images visualization and multiple opened images handling
//kevin.terretaz@gmail.com

//1.0 070221
//1.1 080221 forgotten adjustments + up to 7 Set LUTs
//1.2 150221 bugs correction (Splitviews, Max all)
//1.3 280221 add settings for composite switch and auto-contrast icon
		  // add toggle channels shortcuts tools.
//1.4 110421 gammaLUTs, better Splitview and all images channel toggle key

requires("1.53c");  // minimal version for extended hex icon feature 


/*----------------------------------------------------------------------------------------------------------------------
Reset the contrast of the active channel between the min and max of all slices, not just the active one.
----------------------------------------------------------------------------------------------------------------------*/
macro "Auto contrast (right click for options) Action Tool-N44CeeeD00CeeeD01CeeeD02CeeeD03CeeeD04CeeeD05CeeeD06CeeeD07CeeeD08CeeeD09CeeeD0aCeeeD0bCeeeD0cCeeeD0dCeeeD0eCeeeD0fCeeeD0gCeeeD0hCeeeD0iCeeeD0jCeeeD0kCeeeD0lCeeeD0mCeeeD0nCeeeD10CeeeD11CeeeD12CeeeD13CeeeD14CeeeD15CeeeD16Ce15D17Cf9bD18CeeeD19CeeeD1aCeeeD1bCeeeD1cCeeeD1dCeeeD1eCf9bD1fCe15D1gCeeeD1hCeeeD1iCeeeD1jCeeeD1kCeeeD1lCeeeD1mCeeeD1nCeeeD20CeeeD21CeeeD22CeeeD23CeeeD24CeeeD25CeeeD26Ce15D27Ce15D28CeeeD29CeeeD2aCeeeD2bCeeeD2cCeeeD2dCeeeD2eCe15D2fCe15D2gCeeeD2hCeeeD2iCeeeD2jCeeeD2kCeeeD2lCeeeD2mCeeeD2nCeeeD30CeeeD31CeeeD32CeeeD33CeeeD34CeeeD35CeeeD36Cf9bD37Ce15D38CeeeD39CeeeD3aCeeeD3bCeeeD3cCeeeD3dCeeeD3eCe15D3fCf9bD3gCeeeD3hCeeeD3iCeeeD3jCeeeD3kCeeeD3lCeeeD3mCeeeD3nCeeeD40CeeeD41CeeeD42CeeeD43CeeeD44CeeeD45CeeeD46CeeeD47CeeeD48CfefD49CbabD4aC999D4bC999D4cCbbbD4dCfffD4eCeeeD4fCeeeD4gCeeeD4hCeeeD4iCeeeD4jCeeeD4kCeeeD4lCeeeD4mCeeeD4nCeeeD50CeeeD51CeeeD52CeeeD53CeeeD54CeeeD55CeeeD56CeeeD57C767D58C112D59C101D5aC101D5bC101D5cC101D5dC112D5eC767D5fCeeeD5gCeeeD5hCeeeD5iCeeeD5jCeeeD5kCeeeD5lCeeeD5mCeeeD5nCeeeD60CeeeD61CeeeD62CeeeD63CeeeD64CeeeD65CdddD66C323D67C101D68C213D69C224D6aC224D6bC224D6cC224D6dC113D6eC101D6fC323D6gCdddD6hCeeeD6iCeeeD6jCeeeD6kCeeeD6lCeeeD6mCeeeD6nCeeeD70Ce15D71Ce15D72Cf9bD73CeeeD74CeeeD75C323D76C112D77C224D78C234D79C234D7aCeeeD7bC234D7cC234D7dC234D7eC224D7fC112D7gC323D7hCeeeD7iCeeeD7jCf9bD7kCe15D7lCe15D7mCeeeD7nCeeeD80Cf9bD81Ce15D82Ce15D83CeeeD84C767D85C101D86C224D87C234D88C234D89C234D8aCeeeD8bC234D8cC234D8dC234D8eC234D8fC224D8gC101D8hC767D8iCeeeD8jCe15D8kCe15D8lCf9bD8mCeeeD8nCeeeD90CeeeD91CeeeD92CeeeD93CfefD94C112D95C213D96C234D97C234D98C234D99C234D9aCeeeD9bC234D9cC234D9dC234D9eC234D9fC234D9gC113D9hC112D9iCfffD9jCeeeD9kCeeeD9lCeeeD9mCeeeD9nCeeeDa0CeeeDa1CeeeDa2CeeeDa3CbabDa4C101Da5C224Da6C234Da7C234Da8C234Da9C234DaaCeeeDabC234DacC234DadC234DaeC234DafC234DagC224DahC101DaiCbbbDajCeeeDakCeeeDalCeeeDamCeeeDanCeeeDb0CeeeDb1CeeeDb2CeeeDb3C999Db4C101Db5C224Db6C234Db7C234Db8C234Db9C234DbaC234DbbC234DbcC234DbdC234DbeC234DbfC234DbgC224DbhC101DbiC999DbjCeeeDbkCeeeDblCeeeDbmCeeeDbnCeeeDc0CeeeDc1Cf9aDc2Cf47Dc3Cf47Dc4Ce25Dc5Ce26Dc6Cf69Dc7Cf69Dc8Cf69Dc9Cf69DcaCf69DcbCf69DccCf69DcdCf69DceCf69DcfCf69DcgCe26DchCe26DciCf47DcjCf47DckCf9aDclCeeeDcmCeeeDcnCeeeDd0CeeeDd1CfffDd2Cf68Dd3Cf47Dd4Ce26Dd5Ce15Dd6Cf69Dd7Cf69Dd8Cf69Dd9Cf69DdaC101DdbCf69DdcCf69DddCf69DdeCf69DdfCf69DdgCe15DdhCe26DdiCf47DdjCf68DdkCfffDdlCeeeDdmCeeeDdnCeeeDe0CeeeDe1CeeeDe2CfeeDe3Cf57De4Cf36De5Ce15De6Cf48De7Cf69De8Cf69De9Cf69DeaC101DebCf69DecCf69DedCf69DeeCf69DefCf47DegCe15DehCf36DeiCf57DejCfeeDekCeeeDelCeeeDemCeeeDenCeeeDf0Cf9bDf1Ce15Df2Ce15Df3Cf9bDf4Cf47Df5Ce15Df6Ce15Df7Cf58Df8C101Df9C101DfaC101DfbC101DfcC101DfdCf69DfeCf58DffCe15DfgCe25DfhCf47DfiCf9bDfjCe15DfkCe15DflCf9bDfmCeeeDfnCeeeDg0Ce15Dg1Ce15Dg2Cf9bDg3CfbcDg4Cf47Dg5Cf47Dg6Ce15Dg7Ce15Dg8Cf47Dg9Cf69DgaC101DgbCf69DgcCf69DgdCf47DgeCe15DgfCe15DggCf47DghCf47DgiCfbcDgjCf9bDgkCe15DglCe15DgmCeeeDgnCeeeDh0CeeeDh1CeeeDh2CeeeDh3CfbcDh4Cf47Dh5Cf47Dh6Cf47Dh7Ce25Dh8Ce15Dh9Ce15DhaC101DhbCe26DhcCe15DhdCe15DheCe25DhfCf47DhgCf47DhhCf47DhiCfbcDhjCeeeDhkCeeeDhlCeeeDhmCeeeDhnCeeeDi0CeeeDi1CeeeDi2CeeeDi3CfeeDi4CfccDi5Cf47Di6Cf47Di7Cf47Di8Cf36Di9Ce26DiaCe26DibCe25DicCe26DidCf36DieCf47DifCf47DigCf47DihCfccDiiCfeeDijCeeeDikCeeeDilCeeeDimCeeeDinCeeeDj0CeeeDj1CeeeDj2CeeeDj3CeeeDj4CfeeDj5CfccDj6CfbcDj7Cf9bDj8Cf57Dj9Cf47DjaCf47DjbCf47DjcCf47DjdCf57DjeCf9bDjfCfbcDjgCfccDjhCfeeDjiCeeeDjjCeeeDjkCeeeDjlCeeeDjmCeeeDjnCeeeDk0CeeeDk1CeeeDk2CeeeDk3CeeeDk4CeeeDk5CeeeDk6Cf9bDk7Ce15Dk8CfeeDk9Cf68DkaCf47DkbCf47DkcCf68DkdCfeeDkeCe15DkfCf47DkgCeeeDkhCeeeDkiCeeeDkjCeeeDkkCeeeDklCeeeDkmCeeeDknCeeeDl0CeeeDl1CeeeDl2CeeeDl3CeeeDl4CeeeDl5CeeeDl6Ce15Dl7Ce15Dl8CeeeDl9CfffDlaCf9aDlbCf9aDlcCfffDldCeeeDleCe15DlfCe15DlgCeeeDlhCeeeDliCeeeDljCeeeDlkCeeeDllCeeeDlmCeeeDlnCeeeDm0CeeeDm1CeeeDm2CeeeDm3CeeeDm4CeeeDm5CeeeDm6Ce15Dm7Cf9bDm8CeeeDm9CeeeDmaCeeeDmbCeeeDmcCeeeDmdCeeeDmeCf47DmfCe15DmgCeeeDmhCeeeDmiCeeeDmjCeeeDmkCeeeDmlCeeeDmmCeeeDmnCeeeDn0CeeeDn1CeeeDn2CeeeDn3CeeeDn4CeeeDn5CeeeDn6CeeeDn7CeeeDn8CeeeDn9CeeeDnaCeeeDnbCeeeDncCeeeDndCeeeDneCeeeDnfCeeeDngCeeeDnhCeeeDniCeeeDnjCeeeDnkCeeeDnlCeeeDnmCeeeDnn" {
	//	get pref
	constrast_pref = call("ij.Prefs.get","Contrast.icon","Active channel");
	//	Action depending on prefs, default is Active channel.
	if (constrast_pref == "Active channel")	{
	Reset_contrast();
	}
	if (constrast_pref == "All channels")	{
	run("Auto-contrast on all channels");
	}
}

macro "Auto contrast (right click for options) Action Tool Options"{
	Dialog.createNonBlocking("Auto-contrast icon settings");
	Dialog.addChoice("For auto-contrast icon tool, adjust on :", newArray("Active channel","All channels"), "Active channel");
	Dialog.addMessage("shortcuts reminder : \n[r] key for active channel auto-contrast\n[R] for all channels.")
	Dialog.show();
	call("ij.Prefs.set","Contrast.icon",Dialog.getChoice());
}

/*----------------------------------------------------------------------------------------------------------------------
Right click on any image window to open this menu.
Same popup menu than the original, plus the "Set LUTs" and "Add note in info" macros. Cutomizable.
----------------------------------------------------------------------------------------------------------------------*/
var pmCmds = newMenu("Popup Menu",
	newArray("Set LUTs", "Rename...", "Duplicate...", "Original Scale", "Scale to Fit",
		"Add note in info","-","Record...", "Capture Screen ", "Monitor Memory...",
		"Find Commands...", "Control Panel...", "Startup Macros...", "Search..."));
macro "Popup Menu" {
	cmd = getArgument();
	if (cmd!="-") run(cmd);
}

/*----------------------------------------------------------------------------------------------------------------------
Menu for Splitview tools and help
----------------------------------------------------------------------------------------------------------------------*/
var zCmds = newMenu("Splitview tools Menu Tool",
	newArray("Colored squared Splitview [S]","Grayscaled linear Splitview[p]","Special Splitview","About Splitview"));
macro"Splitview tools Menu Tool - N55C000D00D01D02D03D04D05D06D07D08D09D0aD0bD0dD0eD10D11D12D13D14D15D16D19D1dD1eD20D21D22D23D24D25D26D27D2dD2eD30D31D33D35D3dD3eD40D43D4dD4eD50D52D53D5dD5eD60D61D6dD6eD9bD9eDa0Da1Da2Da3Da5Da6DadDaeDb0Db1Db2Db3Db6Db7Db8Db9DbaDbbDbdDbeDc0Dc1Dc2Dc3Dc4Dc5Dc6Dc7Dc8Dc9DcaDcbDcdDceDe0De1De2De3De4De5De6De7De8De9DeaDebDedDeeC000D17D1bD32D34D41D51D90D91D9dDa9DaaDabDb4Db5C82aD28D29D36D37D3aD45D54D63D72D81D82D83D8aD8eD94D99C010D5bC0eeC101D18D1aD2bD3bD42D44D62D70D7dD92Da4Da8Cf0fC523D8bCfffD0cD1cD2cD3cD46D47D4cD55D56D57D58D5cD65D66D67D68D6cD75D76D77D7cD8cD9cDacDbcDccDd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7Dd8Dd9DdaDdbDdcDddDdeDecC000Ce0eD38D4aD5aD6aD73D7aD95D96D97D98C023D6bD7bCfcfD64D74C404D2aD4bD71D7eD80D8dD93D9aDa7Cf4fD39D48D49D59D69D78D79D84D85D86D87D88D89Cee0Bf0C000D00D01D02D03D04D05D06D07D08D09D0aD0bD0dD0eD10D11D12D13D14D15D16D1bD1dD1eD20D21D22D23D24D2bD2dD2eD30D31D32D33D3bD3dD3eD40D41D42D43D4bD4dD4eD50D51D5bD5dD5eD60D68D6dD6eD70D71D72D73D77D78D79D7aD7dD7eD80D81D82D83D84D86D87D88D89D8aD8bD8dD8eD90D91D92D93D94D95D96D97D98D99D9aD9bD9dD9eDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDadDaeC000C82aC010D18D19D2aD3aD4aD5aD76C0eeD35D36D37D38D44D45D46D47D48D54D55D56D57D64D65D66C101Cf0fC523CfffD0cD1cD2cD3cD4cD5cD6cD7cD8cD9cDacC000D17D1aD52D61D62D69D6aD6bD7bD85Ce0eC023D25D26D27D28D29D34D39D49D53D58D59D63D67D74D75CfcfC404Cf4fCee0B0fC000D00D01D02D03D04D05D06D07D08D09D0aD10D11D14D18D19D1aD20D21D22D28D29D2aD30D31D39D3aD40D41D48D49D4aD50D57D58D59D5aD60D66D67D68D69D70D71D74D75D76D77D78D79D80D81D82D83D84D85D86D87D88D89D8aD90D91D92D93D94D95D96D97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaC000D12D13D15D38D6aD72D7aC82aC010D16D17D27D51D61D73C0eeC101Cf0fC523D23D26D32D37D47D56D62D65CfffC000Ce0eC023CfcfC404Cf4fCee0D24D25D33D34D35D36D42D43D44D45D46D52D53D54D55D63D64Nf0C000D00D01D02D03D05D06D07D08D09D0aD10D11D12D13D14D15D17D1aD20D21D22D23D24D25D31D32D33D3aD41D4aD50D51D5aD6aD7aD89D8aD99Da0Da1Da2Da3Da9DaaDb0Db1Db3Db4Db5Db6Db7Db8Db9DbaDc0Dc1Dc2Dc3Dc4Dc5Dc6Dc7Dc8Dc9DcaDe0De1De2De3De4De5De6De7De8De9DeaC000D16D19D29D2aD30D40D42D60D9aDa7Da8Db2C82aD27D35D38D43D48D52D68D70D80D81D88D92D96D97C010C0eeC101D04D18D39D59D69D90Da4Da5Da6Cf0fD37D44D45D46D47D53D54D55D56D57D62D63D64D65D66D67D72D73D74D75D76D77D82D83D84D85C523CfffDd0Dd1Dd2Dd3Dd4Dd5Dd6Dd7Dd8Dd9DdaC000Ce0eD36D58D71D78D86D87D93D94D95C023CfcfC404D26D28D34D49D61D79D91D98Cf4fCee0"{
	cmd = getArgument();
	if (cmd=="Colored squared Splitview [S]")	Splitview(1,1,0);
	if (cmd=="Grayscaled linear Splitview[p]")	Splitview(0,0,0);
	if (cmd=="Special Splitview")				getSplitviewPref();
	if (cmd=="About Splitview") run("About Splitview");
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

/*----------------------------------------------------------------------------------------------------------------------
This menu is for macro tools to make a "false gamma" applied on LUTs
----------------------------------------------------------------------------------------------------------------------*/
var gammaLUTmenu = newMenu("Gamma LUT Menu Tool",
	newArray("Set gammaLUT on active channel","Try gammaLUT on active channel","Set same GammaLUT on all channels", "Set gammaLUT on all images"));
macro "Gamma LUT Menu Tool - N55C000D39D3aD3bD3cD3dD3eD47D48D49D4aD4bD4cD4dD4eD56D57D58D59D5aD5bD5cD5dD5eD65D66D67D68D69D6aD6bD6cD6dD6eD74D75D76D77D78D79D7aD7bD7cD7dD7eD84D85D86D87D88D89D8aD8bD8cD8dD8eD93D94D95D96D99D9aD9bD9cD9dD9eDa3Da4Da5Da9DaaDabDacDadDaeDb3Db4Db5Db6DbbDbcDbdDbeDc3Dc4Dc5Dc6Dc7Dd3Dd4Dd5Dd6Dd7Dd8Dd9De3De4De5De6De7De8De9DeaC888C000D98Da6DdaCfffD00D01D02D03D04D05D06D07D08D09D0aD0bD0cD0dD0eD10D11D12D13D14D15D16D17D18D19D1aD1bD1cD1dD1eD20D21D22D23D24D25D26D27D28D30D31D32D33D34D35D36D40D41D42D43D44D50D51D52D53D60D61D62D63D70D71D72D80D81D82D90D91Da0Da1Db0Db1Db8Dc0Dc1Dd0Dd1De0De1CcccD92C444D46DbaCbbbD29C333D2bD2eCfffD45D54Da7DcaDdeC666CaaaDecC222D83CeeeC666D2aDdcCcccDb7DddC444Dc2Dd2C777Da8DcdDedC999D37C111D2cD2dD38CdddC555Db2Dc8DceDe2CbbbDb9Dc9C333D55DdbDebC777CaaaD73D97DccCeeeDcbC888Da2C999C111DeeC555D64CdddBf0C000D03D04D05D06D0dD0eD13D14D15D16D1bD1cD1dD1eD24D25D26D27D28D29D2aD2bD2cD2dD2eD34D35D36D37D38D39D3aD3bD3cD3dD3eD45D46D47D48D49D4aD4bD4cD4dD4eD56D57D58D59D5aD5bD5cD5dD5eD67D68D69D6aD6bD6cD6dD6eD79D7aD7bD7cD7dD7eC888C000CfffD00D01D10D11D20D21D22D30D31D32D40D41D42D43D50D51D52D53D54D60D61D62D63D64D65D70D71D72D73D74D75D76D80D81D82D83D84D85D86D87D88D90D91D92D93D94D95D96D97D98D99D9aD9bD9cD9dD9eDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaDabDacDadDaeCcccD77C444D78CbbbD09C333CfffC666D19D8bCaaaD08C222CeeeD89C666D55D8eCcccD33C444D23C777D44C999D17D18D8aC111D0cCdddD0aC555CbbbC333C777CaaaCeeeC888D66C999D02D07D0bC111D1aC555D8cD8dCdddD12B0fC000D00D01D02D03D04D05D06D07D10D11D12D13D14D15D16D17D20D21D22D23D24D25D26D30D31D32D33D34D35D36D40D41D42D43D44D45D50D51D52D53D54D60D61D62D63D70D71C888C000CfffD09D0aD19D1aD28D29D2aD38D39D3aD47D48D49D4aD56D57D58D59D5aD65D66D67D68D69D6aD74D75D76D77D78D79D7aD82D83D84D85D86D87D88D89D8aD90D91D92D93D94D95D96D97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaCcccC444CbbbD37C333CfffC666D64CaaaC222D27CeeeC666D46CcccD18C444C777C999C111CdddC555CbbbD73C333D72C777D08CaaaCeeeC888C999D80C111C555D55CdddD81Nf0C000D30D31D40D41D42D43D50D51D52D53D54D60D61D62D63D64D65D70D71D72D73D74D75D76D80D81D82D83D84D85D86D90D91D92D93D94D95D96D97Da0Da1Da2Da5Da6Da7Db0Db6Db7Dc6Dc7Dd6Dd7De5De6De7C888D33Dd5C000De0CfffD00D01D02D03D04D05D06D07D08D09D0aD10D11D12D13D14D15D16D17D18D19D1aD23D24D25D26D27D28D29D2aD34D35D36D37D38D39D3aD46D47D48D49D4aD57D58D59D5aD67D68D69D6aD78D79D7aD88D89D8aD99D9aDa9DaaDb4Db9DbaDc9DcaDd9DdaDe9DeaCcccDb2C444De4CbbbD98Dc0C333De1De2CfffD22Db3Dc1Dc4Dd1Dd3Dd4C666Da8Dc3CaaaC222D55Dc8Dd8CeeeC666D20CcccC444De8C777C999Db5C111D87Da3CdddC555Db1CbbbC333D44D66Db8C777CaaaD21Dc2CeeeD45D56Dc5Dd0C888C999D77C111D32Da4C555De3CdddDd2"{
	cmd = getArgument();
	if (cmd=="set gammaLUT on active channel") askGammaLUT();
	if (cmd=="try gammaLUT on active channel") run("tryGammaLUT");
	if (cmd=="set same GammaLUT on all channels") run("gammaLUT on all channels");
	if (cmd=="set gammaLUT on all images") run("gammaLUT on all images");
}

/*----------------------------------------------------------------------------------------------------------------------
Settings to customize actions of some tools
----------------------------------------------------------------------------------------------------------------------*/
macro "Settings Action Tool - N55C000D2cD2dD3cD3dD47D48D4bD4cD4dD4eD57D58D59D5aD5bD5cD5dD5eD68D69D6aD6bD6cD6dD6eD78D79D7aD87D88D89D95D96D97D98D99Da6Da7Da8Da9Db7Db8Db9Dc8Dc9DcaDd8Dd9DdaDdbDdcDddDdeDe7De8De9DeaDebDecDedDeeCeeeD0cD0dD27D28D29D2aD36D45D55D66D75D8cD8dD93D9bD9eDa3Dc5De5CeeeD00D01D02D03D04D05D06D07D08D09D0aD0bD0eD10D11D12D13D14D15D16D17D18D19D1aD20D21D22D23D24D25D26D30D31D32D33D34D35D40D41D42D43D44D50D51D52D53D54D60D61D62D63D64D65D70D71D72D73D74D76D80D81D82D83D8bD8eD90D91D92D9cD9dDa0Da1Da2DacDadDb0Db1Db2Db3Db4Dc0Dc1Dc2Dc3Dc4Dd0Dd1Dd2Dd3Dd4Dd5Dd6De0De1De2De3De4CfffDabDaeDbcDbdDc6C111D49D4aDbaDcbDceCfffC000Da5C999D2bD2eD37D85C555D38D67Db6Dc7DccDcdCcccD39Da4Db5DbbDbeC333D3bD77D7bD7eD8aCbbbD46D56D94C777D1cD1dD9aDaaCdddD1bD1eD3aD84C222D3eD86Dd7CaaaD7cD7dDe6Bf0C000D08D0bD0cD0dD0eD1cD1dD2cD2dD37D38D39D46D4aD4bD56D5aD66D6aD6bD77D78D79D87CeeeD05D54D5cD6dD7dD8cDa7Da9DaaCeeeD00D01D02D03D04D10D11D12D13D14D15D16D20D21D22D23D24D30D31D32D33D3eD40D41D42D43D4eD50D51D52D53D5dD5eD60D61D62D63D6eD70D71D72D73D7eD80D81D82D83D84D8dD8eD90D91D92D93D94D95D98D9bD9cD9dD9eDa0Da1Da2Da3Da4Da5Da6Da8DabDacDadDaeCfffD25D4dD85D8bC111D07D45D47D7aD89CfffD58C000D27D29C999D26D3cD48D97C555D0aD1bD1eD28D36D49D69D75D7bCcccD06D19D44D59C333D09D5bD76D88D8aCbbbD18D2bD3dD68D7cD86D99D9aC777D2aD3bD55D57CdddD1aD34D64D74D96C222D3aD65D67CaaaD17D2eD35D4cD6cB0fC000D02CeeeD05D14D20D22D23CeeeD06D07D08D09D0aD11D15D16D17D18D19D1aD21D24D25D26D27D28D29D2aD30D31D32D33D34D35D36D37D38D39D3aD40D41D42D43D44D45D46D47D48D49D4aD50D51D52D53D54D55D56D57D58D59D5aD60D61D62D63D64D65D66D67D68D69D6aD70D71D72D73D74D75D76D77D78D79D7aD80D81D82D83D84D85D86D87D88D89D8aD90D91D92D93D94D95D96D97D98D99D9aDa0Da1Da2Da3Da4Da5Da6Da7Da8Da9DaaCfffD10C111D03CfffC000C999C555D00CcccD04C333CbbbD13C777CdddC222D01CaaaD12Nf0C000D42D43D50D51D52D53D60D61D62D70D71D72D81D82D83D91D92D93D94D95Da1Da2Da3Da4Da5Db1Db2Db3Dc0Dc1Dc2Dd0Dd1Dd2De0De1De2De3CeeeD20D22D23D34D45D55D64D75D97Da7Dc5De5CeeeD00D01D02D03D04D05D06D07D08D09D0aD10D11D12D13D14D15D16D17D18D19D1aD21D24D25D26D27D28D29D2aD35D36D37D38D39D3aD46D47D48D49D4aD56D57D58D59D5aD65D66D67D68D69D6aD74D76D77D78D79D7aD86D87D88D89D8aD98D99D9aDa8Da9DaaDb6Db7Db8Db9DbaDc6Dc7Dc8Dc9DcaDd4Dd5Dd6Dd7Dd8Dd9DdaDe6De7De8De9DeaCfffDc4C111D40D41Db0CfffC000C999D33D85C555Db4Dc3CcccC333D63D73D80Dd3CbbbD54D96Da6Db5De4C777D32D90Da0CdddD30D31C222D84CaaaD44" {
	Dialog.createNonBlocking("Visualization tools parameters");
	Dialog.addChoice("For auto-contrast icon tool, adjust on :", newArray("Active channel","All channels"), "Active channel");
	Dialog.addChoice("[Q] key shortcut tool,switch between composite and :", newArray("Color","Grayscale","All modes"), "Color");
	Dialog.show();
	call("ij.Prefs.set","Contrast.icon",Dialog.getChoice());
	call("ij.Prefs.set","Composite.switch",Dialog.getChoice());
}

/*----------------------------------------------------------------------------------------------------------------------
About menu
----------------------------------------------------------------------------------------------------------------------*/
var AboutCmds = newMenu("About Menu Tool",
	newArray("About these tools", "Keyboard shortcuts cheat sheet","LUTs and channels shortcuts cheat sheet"));
macro"About Menu Tool - B31C000T2e20?"{
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
The new version can ask tu user channel labels and add it in the Splitview with color corresponding to each LUTs.
----------------------------------------------------------------------------------------------------------------------*/
var Provided_Channels = newArray(5);
var Fontsize = 30;
var Ch = newArray(1);
var chan = 1;

/*----------------------------------------------------------------------------------------------------------------------
main Splitview function : aguments works as follow :
color : 0 = grayscale , 1 = color 
style : 0 = linear montage , 1 = squared montage , 2 = vertical montage
labels : 0 = no , 1 = yes.
----------------------------------------------------------------------------------------------------------------------*/
function Splitview(color,style,labels) {
	if(nImages==0)exit("No opened image");
	setBatchMode(true);
	title = getTitle();
	Setup_Splitview(color,labels);//up until split
	if(style==1)	squareView();
	if(style==0)	linearView();
	if(style==2)	verticalView();
	rename(title + " Splitview");
	setBatchMode("exit and display");
}
//error Check, duplicate, split, convert, label
function Setup_Splitview(color,labels){ 
	getDimensions(w, h, channels, slices, frames);
	if (channels == 1) exit("only one channel");
	if (channels > 5) exit("5 channels max");
	run("Duplicate...", "title=image duplicate");
	if ((slices>1)&&(frames==1)) { 
		frames = slices; slices = 1;
		Stack.setDimensions(channels, slices, frames); } 
	Ch = newArray(channels);
	chan = channels;
	getDimensions(w, h, channels, slices, frames);
	Fontsize=h/9;
	run("Duplicate...", "title=split duplicate");
	run("Split Channels");
	selectWindow("image");
	Stack.setDisplayMode("composite");
	if(labels){
		getLabels();
		setColor("white");
		setFont("SansSerif", Fontsize, "bold antialiased");
		Overlay.drawString("Merge",h/20,Fontsize);
		Overlay.show;
		run("Flatten","stack");
		rename("overlay"); Ch[0] = getTitle();
		close("image");
		for (i = 1; i <= chan; i++) {
			selectWindow("C"+i+"-split");
			id = getImageID();
			getLut(r, g, b);
			setColor(r[255], g[255], b[255]);
			if(!color)run("Grays");
			Overlay.drawString(Provided_Channels[i-1],h/20,Fontsize);
			Overlay.show;
			if(slices*frames>1)run("Flatten","stack");
			else {
				run("Flatten");
				rename("C"+i+"-split");
				selectImage(id);
				close();	}
			Ch[i]=getTitle();
		}
	}
	else{
		run("RGB Color", "frames");
		rename("overlay"); Ch[0] = getTitle(); 
		close("image");
		for (i = 1; i <= chan; i++) {
			selectWindow("C"+i+"-split");
			if(!color)run("Grays");
			run("RGB Color", "slices"); 
			Ch[i]=getTitle();	}
	}
}

function getSplitviewPref(){
	Dialog.createNonBlocking("Labeled Prefs");
	Dialog.addMessage("choose your Splitview");
	Dialog.addRadioButtonGroup("Color style", newArray("Colored","Grayscale"), 1, 3, "Colored");
	Dialog.addRadioButtonGroup("Montage style", newArray("Linear","Square","Vertical"), 1, 3, "Linear");
	Dialog.addCheckbox("label channels?", 0);
	Dialog.show();
	color = Dialog.getRadioButton();
	style = Dialog.getRadioButton();
	labels = Dialog.getCheckbox();
	if	   (color=="Colored"  &&style=="Linear")  { if(labels) Splitview(1,0,1); else Splitview(1,0,0); }
	else if(color=="Grayscale"&&style=="Linear")  { if(labels) Splitview(0,0,1); else Splitview(0,0,0); }
	else if(color=="Colored"  &&style=="Square")  { if(labels) Splitview(1,1,1); else Splitview(1,1,0); }
	else if(color=="Grayscale"&&style=="Square")  { if(labels) Splitview(0,1,1); else Splitview(0,1,0); }
	else if(color=="Colored"  &&style=="Vertical"){ if(labels) Splitview(1,2,1); else Splitview(1,2,0); }
	else if(color=="Grayscale"&&style=="Vertical"){ if(labels) Splitview(0,2,1); else Splitview(0,2,0); }
}

function getLabels(){
	Dialog.createNonBlocking("Provide channel names");
	Dialog.addString("Channel1", "GFP",		12);
	Dialog.addString("Channel2", "RFP",		12);
	Dialog.addString("Channel3", "dRFP",	12);
	Dialog.addString("Channel4", "DAPI",	12);
	Dialog.addString("Channel5", "DIC",		12);
	Dialog.addNumber("Font size", Fontsize);
	Dialog.show();
	for (k = 0; k < 5; k++) {
		Provided_Channels[k] = Dialog.getString(); 
		}
	Fontsize = Dialog.getNumber();
}

function squareView(){
							C1_C2 = Combine_Horizontally(Ch[1],Ch[2]);
	if (chan==2||chan==4)C1_C2_Ov =	Combine_Horizontally(C1_C2,Ch[0]);
	if (chan==3){			C3_Ov = Combine_Horizontally(Ch[3],Ch[0]); 			Combine_Vertically(C1_C2,C3_Ov);}
	if (chan>=4)			C3_C4 =	Combine_Horizontally(Ch[3],Ch[4]);
	if (chan==4)					Combine_Vertically(C1_C2_Ov,C3_C4);
	if (chan==5){			C1234 = Combine_Vertically(C1_C2,C3_C4); C5_Ov  = 	Combine_Vertically(Ch[5],Ch[0]); Combine_Horizontally(C1234,C5_Ov);}
}

function linearView(){
	C1_C2 = 				Combine_Horizontally(Ch[1],Ch[2]);
	if (chan==2)			Combine_Horizontally(C1_C2,Ch[0]);
	if (chan==3){	C3_Ov = Combine_Horizontally(Ch[3],Ch[0]);			Combine_Horizontally(C1_C2,C3_Ov);}
	if (chan>=4){	C3_C4 =	Combine_Horizontally(Ch[3],Ch[4]);	C1234 =	Combine_Horizontally(C1_C2,C3_C4);}
	if (chan==4)			Combine_Horizontally(C1234,Ch[0]);
	if (chan==5){	C5_Ov = Combine_Horizontally(Ch[5],Ch[0]);			Combine_Horizontally(C1234,C5_Ov);}
}

function verticalView(){
					C1_C2 = Combine_Vertically(Ch[1],Ch[2]);
	if (chan==2)			Combine_Vertically(C1_C2,Ch[0]);
	if (chan==3){	C3_Ov = Combine_Vertically(Ch[3],Ch[0]);		Combine_Vertically(C1_C2,C3_Ov);}
	if (chan>=4){	C3_C4 =	Combine_Vertically(Ch[3],Ch[4]); C1234= Combine_Vertically(C1_C2,C3_C4);}
	if (chan==4)			Combine_Vertically(C1234,Ch[0]);
	if (chan==5){	C5_Ov = Combine_Vertically(Ch[5],Ch[0]);		Combine_Vertically(C1234,C5_Ov);}
}

function Combine_Horizontally(stack1,stack2){ //returns result image title *.*
	run("Combine...", "stack1=&stack1 stack2=&stack2");
	rename(stack1+"_"+stack2);
	return getTitle();
}

function Combine_Vertically(stack1,stack2){
	run("Combine...", "stack1=&stack1 stack2=&stack2 combine"); //vertically
	rename(stack1+"_"+stack2);
	return getTitle();
}

macro "About Splitview" {
	showMessage("About Splitview", "Splitview is a visualisation tool for multichannel images with up to 5 channels:\n"
		+"This macro will generate a montage of composite and separated channels in one RGB Image.\n"
		+"You can still navigate through slices or frames.\n \n"
		+"Note: the Splitview image size can be heavy on big hyperstacks due to RGB conversion.\n"
		+"Advice: draw a smaller selection before running Spliview, the produced montage will be croped.\n"
		+"With 'Special Splitview', you can choose between color and greyscale for separate channels \n"
		+"and different montage styles. Also when label is checked, a dialog will ask for channel labels \n"
		+"and add it in the Splitview with color corresponding to each LUTs.");
}

//----------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------
//gamma correction applied on active LUT, no modification of pixels data .
function gammaLUT(gamma,Reds, Greens, Blues) { //adapted from John Lim https://imagej.nih.gov/ij/macros/Gamma_LUT.txt
	if ( bitDepth() == 24) exit("this is an RGB image"); 
	Input=newArray(256); Output=newArray(256);
	for (i=0;i<256;i++){ Input[i]=i; }
	for(i=0;i<256;i++){ Output[i]=pow(Input[i],gamma); }
	scale = 255/Output[255];
	for(i=0;i<256;i++){
		Output[i]=	  round(Output[i]*scale);//Limit the ouput to 8bit range
		if(Output[i]<0) 	Output[i]=0;
		if(Output[i]>255) 	Output[i]=255;	}
	New_Reds=newArray(256); New_Greens=newArray(256); New_Blues=newArray(256);
	for(i=0;i<256;i++){
		j=Output[i];
		New_Reds[i]=Reds[j];
		New_Greens[i]=Greens[j];
		New_Blues[i]=Blues[j];	}
	setLut(New_Reds, New_Greens, New_Blues);
}

//set gammaLUT on active channel
function setGammaLUT(gamma){
	if(nImages==0)exit("No opened image"); if ( bitDepth() == 24) exit("this is an RGB image");
	getLut(Reds, Greens, Blues);
	gammaLUT(gamma,Reds, Greens, Blues);
}

//get gammaLUT from user and set on active channel
function askGammaLUT(){
	if(nImages==0)exit("No opened image"); if ( bitDepth() == 24) exit("this is an RGB image"); 
	Dialog.create("gammaLUT");
	Dialog.addSlider("gamma",0,5,0.5);
	Dialog.show();
	getLut(Reds, Greens, Blues);
	gammaLUT(Dialog.getNumber(),Reds, Greens, Blues);
}

//set gammaLUT on all channels
function setAllchannelsgammaLUTs(gamma) {
	if(nImages==0)exit("No opened image"); if ( bitDepth() == 24) exit("this is an RGB image"); 
	getDimensions(width, height, channels, slices, frames);
	if(channels>1)	{
		for (A = 1; A <= channels; A++) {
		Stack.setChannel(A);
		setGammaLUT(gamma);	}	}
	else {setGammaLUT(gamma);	}
}

//set gammaLUT on active channel and ask if good until user is happy
macro "tryGammaLUT"{
	if(nImages==0)exit("No opened image"); if(bitDepth()==24) exit("this is an RGB image"); 
	getLut(Reds, Greens, Blues);
	preview = 1;
	while ( preview ){
		Dialog.create("Gamma LUT");
		Dialog.addSlider("gamma", 0, 5, 0.5);
		Dialog.addCheckbox("preview", 1);
		Dialog.show();
		gamma = Dialog.getNumber();
		preview = Dialog.getCheckbox();
		gammaLUT(gamma,Reds, Greens, Blues);
		if (!preview) exit;
		Dialog.create("Continue?");
		Dialog.addMessage("Is this a good look?");
		Dialog.addRadioButtonGroup("Good?", newArray("No","Yes"), 1, 2, "No");
		Dialog.show();
		good = Dialog.getRadioButton();
		if (good=="Yes") preview = 0;
		if (good=="No")  setLut(Reds, Greens, Blues);
	}
}

macro"gammaLUT on all channels"{
	if(nImages==0)exit("No opened image"); if ( bitDepth() == 24) exit("this is an RGB image"); 
	Dialog.create("gammaLUT");
	Dialog.addSlider("gamma",0,5,0.5);
	Dialog.show();
	setAllchannelsgammaLUTs(Dialog.getNumber());
}

macro"gammaLUT on all images"{
	Dialog.create("gammaLUT");
	Dialog.addSlider("gamma",0,5,0.5);
	Dialog.show();
	setEveryGammaLUTs(Dialog.getNumber());
}
//set gammaLUT on all channels of all images
function setEveryGammaLUTs(gamma){
	if(nImages==0)exit("No opened image");
	Get_all_IDs();
	for (b=0; b<all_IDs.length; b++) {
		selectImage(all_IDs[b]);
		if (bitDepth()!=24) setAllchannelsgammaLUTs(gamma);
	}
}

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
	if(nImages==0)exit("No opened image");
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
	if (nImages<1) exit("No image");
	if (bitDepth()==24) exit;
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
 1 slice / 1 color ; 1slice / multiple colors ; multiple slices / multiple colors
----------------------------------------------------------------------------------------------------------------------*/

/*----------------------------------------------------------------------------------------------------------------------
Reset the contrast window between min and max on all individual channels
----------------------------------------------------------------------------------------------------------------------*/
macro "Auto-contrast on all channels" {
	if (nImages<1) exit('No image');
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

/*----------------------------------------------------------------------------------------------------------------------
Saves all opened images as Tiff in selected directory, but be carefull:
Any image in the directory with same name will be replaced without warning!
----------------------------------------------------------------------------------------------------------------------*/
macro "Save all" {
	if (nImages<1) exit('no image');
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
	if (nImages<1) exit('no image');
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
numerical key shortcuts for most common LUTs, [n7] to [n9] are free.
by maintaining space key, you can toggle channels from 1 to 7.
alt key will do the same on all opened images.
----------------------------------------------------------------------------------------------------------------------*/
macro "Gray 	[n1]"{ if (isKeyDown("space")) toggleChannel(1); else if (isKeyDown("alt")) toggleAllchannels(1); else run("Grays");	}
macro "Green 	[n2]"{ if (isKeyDown("space")) toggleChannel(2); else if (isKeyDown("alt")) toggleAllchannels(2); else run("Green");	}
macro "Red 		[n3]"{ if (isKeyDown("space")) toggleChannel(3); else if (isKeyDown("alt")) toggleAllchannels(3); else run("Red");		}
macro "Cyan 	[n4]"{ if (isKeyDown("space")) toggleChannel(4); else if (isKeyDown("alt")) toggleAllchannels(4); else run("Cyan");		}
macro "Magenta 	[n5]"{ if (isKeyDown("space")) toggleChannel(5); else if (isKeyDown("alt")) toggleAllchannels(5); else run("Magenta");	}
macro "Yellow 	[n6]"{ if (isKeyDown("space")) toggleChannel(6); else if (isKeyDown("alt")) toggleAllchannels(6); else run("Yellow");	}
macro "Cyan		[n7]"{ if (isKeyDown("space")) toggleChannel(7); else if (isKeyDown("alt")) toggleAllchannels(7);	}

//toggle channel number (i)
function toggleChannel(i) { //modified from J.Mutterer
	if (nImages<1) exit;
	if (!is("composite")) exit;
	Stack.getActiveChannels(s);
	c=s.substring(i-1,i);
	Stack.setActiveChannels(s.substring(0,i-1)+!c+s.substring(i)); //at the end it looks like Stack.setActiveChannels(1101); 
}

function toggleAllchannels(i) {
	setBatchMode(1);
	for (b=0; b<nImages; b++) {
		selectImage(b+1);
		toggleChannel(i);	}
	showStatus("Channel"+i+" toggled");
	setBatchMode("exit and display");
}

/*----------------------------------------------------------------------------------------------------------------------
key shortcuts for what I think are frequently used commands with opened images. Plus some usefull tricks.
----------------------------------------------------------------------------------------------------------------------*/
macro "auto				[A]"	{if(nImages!=0)run("Enhance Contrast", "saturated=0.3");} //almost same as "Auto" button in Brightness tool.
macro "Tile				[E]"	{if(nImages!=0)run("Tile");}
macro "Contrast all Ch	[R]"	{run("Auto-contrast on all channels");}
macro "Auto contrast	[r]"	{Reset_contrast();} // On active channel only
macro "sync				[y]"	{run("Synchronize Windows");}
macro "Arrange			[q]"	{if(nImages!=0)run("Arrange Channels...");}
macro "Splitview color	[S]"	{Splitview(1,1,0);}
macro "Splitview grey	[p]"	{Splitview(0,0,0);}
macro "Split Channel	[d]"	{if(nImages!=0)run("Split Channels");}
macro "duplicate		[D]"	{if(nImages!=0)run("Duplicate...", "duplicate");}
macro "Merge			[M]"	{if(nImages!=0)run("Merge Channels...");}
macro "Z Project		[g]"	{if(nImages!=0)run("Z Project...");}
macro "Max				[G]"	{if(nImages!=0)run("Z Project...", "projection=[Max Intensity] all");}
macro "Save as tiff		[T]"	{saveAs("Tiff");}

macro "composite switch [Q]" {
	//	if no preferences : ask for it
	is_switch_pref = call("ij.Prefs.get","Composite.switch",0);
	if (is_switch_pref == 0)	set_switch_pref(); 
	//	error check
	if (nImages<1) exit("No image");
	if (!is("composite")) exit("Not a multichannel image");
	//	get pref
	switch_pref = call("ij.Prefs.get","Composite.switch","Color");
	//	Switch!
	if (switch_pref == "Color")	{
		Stack.getDisplayMode(mode);
		if (mode != "composite")	{Stack.setDisplayMode("composite");	} 
		else {Stack.setDisplayMode("color");	}
	}
	if (switch_pref == "Grayscale")	{
		Stack.getDisplayMode(mode);
		if (mode != "composite")	{Stack.setDisplayMode("composite");	}
		else {Stack.setDisplayMode("grayscale");	}
	}
	if (switch_pref == "All modes")	{
		modes=newArray("Composite","Color","Grayscale");
		Stack.getDisplayMode(mode);
		m=0;
		for (i=0;i<modes.length;i++) {
			if (mode==modes[i].toLowerCase()) m=i;	}
			m=(m+1)%3;
			Stack.setDisplayMode(modes[m]);
	}
}

function set_switch_pref() { // for composite switch tool
	Dialog.createNonBlocking("Visualization tools parameters");
	Dialog.addChoice("[Q] key shortcut, you want to switch between composite and :", newArray("Color","Grayscale","All modes"), "Color");
	Dialog.show();
	call("ij.Prefs.set","Composite.switch",Dialog.getChoice());
}
//----------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------------------------

macro "About these tools" {
	Dialog.createNonBlocking("Visualization Toolset description");
	Dialog.addMessage("This toolset intends to help handling and visualization of multichannel images and stacks.\n"+
	"None of these tools will modify the pixels of the images. Only the display.\n"+" \n"+
	"Most will work on single or all opened images.\n"+
	"______________________________________________________________________________\n"+
	"* Splitview : menu icon or press [S] (colored) or [p] (grayscale).\n"+
	"            Creates a RGB montage of composite and splited channels.\n"+
	"            Grayscale Splitview is a linear montage grey channels + overlay.\n"+
	"            You can still navigate through slices or frames.\n"+
	"			 'Special Splitview' for parameters and labeled channels.\n"+
	"______________________________________________________________________________\n"+
	"* Set image LUTs : Right click on the image and select 'Set LUTs':\n"+
	"            Applies all chosen LUTs (false colors) to your multichannel image.\n"+
	"______________________________________________________________________________\n"+
	"* Auto-contrast min-max : Click on Contrast icon or [r] for one channel, [R] for all.\n"+
	"            Especially usefull for stacks (but not restricted to),this macro\n"+
	"            resets the min and max based on the entire stack so you can navigate\n"+
	"            through slices without signal saturation.\n"+
	"            Tip : if you have bright spots on your stack, draw a ROI.\n"+
	"______________________________________________________________________________\n"+
	"* gammaLUT : Menu icon\n"+
	"            This tool gives the same visual result than the Gamma of process/math\n"+
	"            but only modifies the active LUT, without doing anything to pixels data.\n"+
	"            So to reset the original constrasts, you just have to reset the LUT. \n"+
	"______________________________________________________________________________\n"+
	"* Tools for all opended images : in the 'All images menu icon':\n"+
	"           - Maximum Z project all : \n"+
	"                    Run a maximal intensity projection on all opended stacks,\n"+
	"                    then close the stacks and run 'Tile' to see all windows.\n"+
	"                    Can be handy to get a quick overview of stacks content.\n"+
	"           - Save all : \n"+
	"                    Saves all opened images as Tiff in a specified directory.\n"+
	"                    Be carefull : it will erase files with similar names with no warning.\n"+
	"        ______________________________________________________________________________\n"+
	"* a handy macro shortcut :\n"+
	"      - [ Q ]   Quickly switch between Color and Composite mode on multichannel images.\n"+
	"      via the Settings icon, you can choose to switch between grayscale and composite\n"+
	"      or cycle the three modes.\n"+
	"______________________________________________________________________________\n"+
	"* Keyboard shortcuts for frequently used commands in Imagej\n"+
	"      All described in the cheat sheet of the ' ? ' menu.\n"+
	"      Press ctrl (pc) or cmd (mac) key to re-access the built-in shortcuts of Imagej",13);
	Dialog.show();
}

macro "Keyboard shortcuts cheat sheet" {
	Dialog.createNonBlocking("keyboard shortcuts");
	Dialog.addMessage("* Macro shortcuts :\n"+
	"[ Q ]___switch color and composite mode\n"+
	"[ R ]___Auto-contrast all channels\n"+
	"[ r ]___Auto-contrast active channel\n"+
	"[ S ]___Colored Splitview\n"+
	"[ p ]___Grayscale Splitview\n"+
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

macro "LUTs and channels shortcuts cheat sheet" {
	Dialog.createNonBlocking("numerical keyboard shortcuts");
	Dialog.addMessage("* Apply LUTs :\n"+
	"[ 1 ]___Grayscale\n"+
	"[ 2 ]___Green\n"+
	"[ 3 ]___Red\n"+
	"[ 4 ]___Cyan\n"+
	"[ 5 ]___Magenta\n"+
	"[ 6 ]___Yellow\n"+
	"____________________________________\n"+
	"* maintain space + numerical key\n"+
	"[ 1 ]___Toggle channel 1\n"+
	"[ 2 ]___Toggle channel 2\n"+
	"[ 3 ]___Toggle channel 3\n"+
	"[ 4 ]___Toggle channel 4\n"+
	"[ 5 ]___Toggle channel 5\n"+
	"[ 6 ]___Toggle channel 6\n"+
	"[ 7 ]___Toggle channel 7\n"+
	"maintain ALT to act on all images",13);
	Dialog.show();
}













