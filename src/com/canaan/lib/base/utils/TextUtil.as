package com.canaan.lib.base.utils
{
	import flash.text.TextField;
	
	public class TextUtil
	{
		public static const TEXT_WIDTH_PADDING:Number = 5;

		/**
		 * 截断字符串
		 * 
		 */
		public static function truncateToFit(textField:TextField, maxWidth:Number, ellipsis:String = "..."):Boolean {
		    var originalText:String = textField.text;
		    var w:Number = maxWidth;
		    
		    if (originalText != "" && textField.textWidth + TEXT_WIDTH_PADDING > w + 0.00000000000001) {
		        var s:String = textField.text = originalText;
	            originalText.slice(0, Math.floor((w / (textField.textWidth + TEXT_WIDTH_PADDING)) * originalText.length));
		
		        while (s.length > 1 && textField.textWidth + TEXT_WIDTH_PADDING > w) {
		            s = s.slice(0, -1);
		            textField.text = s + ellipsis;
		        }
		        
		        return true;
		    }
		    return false;
		}
		
		public static function getHtmlText(text:String, color:String = "#FFFFFF", underLine:Boolean = false):String {
			var htmlText:String = text;
			if (underLine) {
				htmlText = "<u>" + text + "</u>";
			}
			htmlText = "<font color=\"" + color + "\">" + htmlText + "</font>";
			return htmlText;
		}
	}
}