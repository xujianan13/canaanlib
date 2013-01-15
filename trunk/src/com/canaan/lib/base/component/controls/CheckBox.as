package com.canaan.lib.base.component.controls
{
	import flash.text.TextFieldAutoSize;

	public class CheckBox extends Button
	{
		public function CheckBox(skin:String = null, label:String = "")
		{
			super(skin, label);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			scale9Mode = false;
			_toggle = true;
		}
		
		override protected function initialize():void {
			super.initialize();
			_btnLabel.autoSize = TextFieldAutoSize.LEFT;
		}
		
		override protected function changeLabelSize():void {
			_btnLabel.validateNow();
			_btnLabel.x = bitmap.width + _labelMargin[0];
			_btnLabel.y = (bitmap.height -_btnLabel.height) * 0.5 + _labelMargin[1];
		}
	}
}