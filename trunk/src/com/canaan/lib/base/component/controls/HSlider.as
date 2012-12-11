package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Direction;

	public class HSlider extends Slider
	{
		public function HSlider(skin:String=null)
		{
			super(skin);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			direction = Direction.HORIZONTAL;
		}
	}
}