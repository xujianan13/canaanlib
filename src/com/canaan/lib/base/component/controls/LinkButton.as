package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Styles;
	
	import flash.text.TextFieldAutoSize;

	public class LinkButton extends Button
	{
		public function LinkButton(label:String = "")
		{
			super(null, label);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			buttonMode = true;
			scale9Mode = false;
			_labelColors = Styles.linkButtonLabelColors;
		}
		
		override protected function initialize():void {
			super.initialize();
			_btnLabel.underline = true;
			_btnLabel.autoSize = TextFieldAutoSize.LEFT;
//			_btnLabel.stroke = null;
		}
		
		override protected function changeLabelSize():void {
			
		}
	}
}