package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Direction;

	public class VSlider extends Slider
	{
		public function VSlider(skin:String=null)
		{
			super(skin);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			direction = Direction.VERTICAL;
		}
	}
}