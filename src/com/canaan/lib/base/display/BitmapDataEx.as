package com.canaan.lib.base.display
{
	import com.canaan.lib.base.interfaces.IRecyclable;
	
	import flash.display.BitmapData;

	public class BitmapDataEx implements IRecyclable
	{
		public var x:int;
		public var y:int;
		public var frameIndex:int;
		public var delay:int = 1;
		public var bitmapData:BitmapData;
		
		public function BitmapDataEx(bitmapData:BitmapData = null, x:int = 0, y:int = 0)
		{
			this.bitmapData = bitmapData;
			this.x = x;
			this.y = y;
		}
		
		public function reinitialize():void {
			if (bitmapData) {
				bitmapData.dispose();
				bitmapData = null;
			}
			x = 0;
			y = 0;
			frameIndex = 0;
			delay = 1;
		}
	}
}