package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Direction;

	public class HScrollBar extends ScrollBar
	{
		public function HScrollBar(skin:String = null)
		{
			super(skin);
		}
		
		override protected function initialize():void {
			super.initialize();
			_slider.direction = Direction.HORIZONTAL;
		}
	}
}