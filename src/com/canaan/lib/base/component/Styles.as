package com.canaan.lib.base.component
{
	import flash.text.TextFormatAlign;

	public class Styles
	{
		//------------- DialogManager default setting --------------
		public static var dialogModalColor:uint = 0x000000;
		public static var dialogModalAlpha:Number = 0.3;
		
		//------------- TooltipManager default setting --------------
		public static var toolTipShowDelay:Number = 300;
		public static var toolTipHideDelay:Number = 10000;
		public static var toolTipScrubDelay:Number = 100;

		//------------- Text default setting --------------
		public static var fontName:String = "宋体,Arial";
		public static var fontSize:int = 12;
		
		//------------- Label default setting -------------
		public static var labelColor:uint = 0x000000;
		public static var labelStroke:Array = [0x170702, 0.8, 2, 2, 10, 1];
		public static var labelHeight:int = 18;
		public static var labelScale9Grid:Array = [2, 2, 2, 2];
		
		//------------- TextInput default setting -------------
		public static var textInputWidth:int = 128;
		public static var textInputHeight:int = 20;
		
		//------------- TextArea default setting -------------
		public static var textAreaWidth:int = 180;
		public static var textAreaHeight:int = 150;
		public static var textAreaTextOffsetX:int = 0;
		
		//------------- Button default setting -------------
		public static var buttonLabelColors:Array = [0x32556B, 0x32556B, 0x32556B, 0xC0C0C0];
		public static var buttonLabelMargin:Array = [0, 0, 0, 0];
		public static var buttonSkinW:int = 1;
		public static var buttonSkinH:int = 3;
		public static var buttonScale9Grid:Array = [4, 4, 4, 4];
		
		//------------- CheckBox default setting -------------
		public static var checkBoxSkinW:int = 2;
		public static var checkBoxSkinH:int = 3;
		
		//------------- LinkButton default setting -------------
		public static var linkButtonLabelColors:Array = [0x0080C0, 0xFF8000, 0x800000, 0xC0C0C0];
		
		//------------- Image default setting -------------
		public static var imageScale9Grid:Array = [4, 4, 4, 4];
		
		//------------- ProgressBar default setting -------------
		public static var progressBarLabelColor:int = 0xFFFFFF;
		public static var progressBarLabelStroke:String = "0x004080";
		
		//------------- Slider default setting -------------
		public static var sliderBackgroundScale9Grid:String = "1,1,1,1";
		
		//------------- ScrollBar default setting -------------
		public static var scrollBarDelay:Number = 500;
		
		//------------- Clip default setting -------------
		public static var clipInterval:int = 50;
		
		//------------- Canvas default setting -------------
		public static var canvasWidth:int = 100;
		public static var canvasHeight:int = 100;
		
		//------------- ComboBox default setting -------------
		public static var comboBoxMaxRows:int = 5;
		public static var comboBoxLabelAlign:String = TextFormatAlign.LEFT;
		public static var comboBoxLabelMargin:String = "2";
		public static var comboBoxListColors:Array = [0x8FA4B1, 0xFFFFFF];
		public static var comboBoxItemWidth:int = 50;
		public static var comboBoxItemHeight:int = 22;
		public static var comboBoxItemColors:Array = [0x5E95B6, 0xFFFFFF, 0x000000];
	}
}