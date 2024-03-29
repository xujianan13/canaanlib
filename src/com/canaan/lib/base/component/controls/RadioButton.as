package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.utils.TextUtil;
	
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;

	public class RadioButton extends Button
	{
		public function RadioButton(skin:String = null, label:String = "")
		{
			super(skin, label);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			scale9Mode = false;
		}
		
		override protected function initialize():void {
			super.initialize();
			_btnLabel.autoSize = TextFieldAutoSize.LEFT;
			addEventListener(MouseEvent.CLICK, clickHandler);
		}
		
		protected function clickHandler(event:MouseEvent):void {
			selected = true;
		}
		
		override protected function changeLabelSize():void {
			_btnLabel.validateNow();
			_btnLabel.height = TextUtil.getTextHeight(_btnLabel.format);
			_btnLabel.x = bitmap.width + Number(_labelMargin[0]);
			_btnLabel.y = (bitmap.height - _btnLabel.height) * 0.5 + Number(_labelMargin[1]);
		}
		
		override public function dispose():void {
			super.dispose();
			removeEventListener(MouseEvent.CLICK, clickHandler);
		}
	}
}