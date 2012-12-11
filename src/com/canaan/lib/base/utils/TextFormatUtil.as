package com.canaan.lib.base.utils
{
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class TextFormatUtil
	{
		public static const EMBED_FONT_NAME:String = "_sans";
		public static const DEFAULT_FONT_NAME:String = "I am not a font!";
		
		public static var defaultClass:Class;
		private static var defaultFont:Font;
		
		public function TextFormatUtil()
		{
		}
		
		public function validateTextFormat(value:DisplayObjectContainer):void {
			var child:DisplayObject;
			for (var i:int = 0; i < value.numChildren; i++) {
				child = value.getChildAt(i);
				if (child is TextField) {
					setTextFormat(child as TextField);
				} else if (child is DisplayObjectContainer) {
					validateTextFormat(child as DisplayObjectContainer);
				}
			}
		}

		public static function setTextFormat(value:TextField):void {
			if (value.defaultTextFormat.font == EMBED_FONT_NAME) {
				if (defaultFont == null) {
					if (defaultClass != null) {
						Font.registerFont(defaultClass);
						defaultFont = new defaultClass() as Font;
					}
				}
				if (value.embedFonts && value.defaultTextFormat.font == defaultFont.fontName) {
					return;
				}
				value.embedFonts = true;
                var textFormat:TextFormat = value.defaultTextFormat;
                textFormat.font = defaultFont.fontName;
                value.defaultTextFormat = textFormat;
                value.setTextFormat(textFormat);
			}
		}
		
		public static function createTextField(msg:String = "", fontSize:int = 12, embedFonts:Boolean = true, bold:Boolean = false, autoSize:String = TextFieldAutoSize.LEFT):TextField {
			var textField:TextField = new TextField();
            textField.text = msg;
            textField.autoSize = autoSize;
            textField.mouseEnabled = false;
        	var textFormat:TextFormat = textField.defaultTextFormat;
        	textFormat.font = embedFonts ? EMBED_FONT_NAME : DEFAULT_FONT_NAME;
        	textFormat.size = fontSize;
        	textFormat.bold = bold;
        	textField.defaultTextFormat = textFormat;
        	textField.setTextFormat(textFormat);
        	if (embedFonts) {
        		setTextFormat(textField);
        	}
        	return textField;
		}
	}
}