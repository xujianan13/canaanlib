package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Styles;
	
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;

	public class CheckBox extends Button
	{
		public function CheckBox(skin:String = null, label:String = "")
		{
			super(skin, label);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			skinW = Styles.checkBoxSkinW;
			_toggle = true;
		}
		
		override protected function initialize():void {
			super.initialize();
			_btnLabel.autoSize = TextFieldAutoSize.LEFT;
		}
		
		override protected function mouseHandler(event:MouseEvent):void {
			if (!_toggle && _selected || _disabled) {
				return;
			}
			if (event.type == MouseEvent.CLICK) {
				if (_mouseClickHandler != null) {
					_mouseClickHandler.apply();
				}
				if (_toggle) {
					selected = !_selected;
					state = 1;
				}
				return;
			}
			state = states[event.type];
		}
		
		override protected function changeState():void {
			if (tiles != null) {
				bitmap.bitmapData = _selected ? tiles[_state + skinH] : tiles[_state];
			}
			_btnLabel.color = _labelColors[_state];
		}
		
		override protected function changeLabelSize():void {
			_btnLabel.validateNow();
			_btnLabel.x = bitmap.width + _labelMargin[0];
			_btnLabel.y = tiles ? (bitmap.height - _btnLabel.height) * 0.5 + _labelMargin[1] : 0;
		}
	}
}