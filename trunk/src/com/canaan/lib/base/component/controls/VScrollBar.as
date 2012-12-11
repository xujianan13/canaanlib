package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Direction;

	public class VScrollBar extends ScrollBar
	{
		public function VScrollBar(skin:String = null)
		{
			super(skin);
		}
		
		override protected function initialize():void {
			super.initialize();
			slider.direction = Direction.VERTICAL;
		}
	}
}