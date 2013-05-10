package com.canaan.lib.base.utils
{
	import com.canaan.lib.base.debug.Log;
	
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Dictionary;

	public class FontUtil
	{
		private static var cache:Dictionary = new Dictionary();
		
		public static function registerFont(clazz:Class, id:String):void {
			Font.registerFont(clazz);
			cache[id] = new clazz();
		}
		
		public static function setFont(textField:TextField, id:String):void {
			var font:Font = cache[id];
			if (!font) {
				Log.getInstance().error("FontUtil.setFont:" + id + " is not found!");
				return;
			}
			textField.embedFonts = true;
			var textFormat:TextFormat = textField.defaultTextFormat;
			textFormat.font = font.fontName;
			textField.defaultTextFormat = textFormat;
			textField.setTextFormat(textFormat);
		}
	}
}