package testPackage.util
{
	import com.canaan.lib.base.component.controls.Image;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.utils.DisplayUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Matrix;
	
	public class TestDisplayUtil extends Sprite
	{
		private var image:Image;
		private var bitmap:Bitmap;
		private var bitmapData:BitmapData;
		
		public function TestDisplayUtil()
		{
			Application.initialize(this);
			
			image = new Image("assets/Altar.png");
			addChild(image);
			image.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
			
			bitmapData = new BitmapData(100, 100, true);
			bitmap = new Bitmap(bitmapData);
			bitmap.x = 200;
			addChild(bitmap);
		}
		
		private function mouseMove(event:MouseEvent):void {
			trace(DisplayUtil.containsPoint(image, event.localX, event.localY));
			
			var color:uint = DisplayUtil.getColor(image, event.localX, event.localY) + 0xFF000000;
			
//			var b:BitmapData = new BitmapData(image.width, image.height, false, 0xFFFFFF);
//			var matrix:Matrix = new Matrix();
//			matrix.tx = -event.localX;
//			matrix.ty = -event.localY;
//			b.draw(image, matrix);
//			var color:int = b.getPixel(0, 0) + 0xFF000000;
//			trace(color);
			
			bitmapData.fillRect(bitmapData.rect, color);
		}
	}
}