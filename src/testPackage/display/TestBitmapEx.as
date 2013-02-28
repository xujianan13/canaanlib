package testPackage.display
{
	import com.canaan.lib.base.component.controls.Image;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.display.BitmapDataEx;
	import com.canaan.lib.base.display.BitmapEx;
	import com.canaan.lib.base.events.UIEvent;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	public class TestBitmapEx extends Sprite
	{
		private var image:Image;
		private var bitmap:BitmapEx;
		private var bitmapData:BitmapDataEx;
		
		public function TestBitmapEx()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			image = new Image("assets/Altar.png");
			image.dispatcher.addEventListener(UIEvent.COMPLETE, onComplete);
//			addChild(image);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseMove);
		}
		
		private function onComplete():void {
			image.dispatcher.removeEventListener(UIEvent.COMPLETE, onComplete);
			bitmapData = new BitmapDataEx(image.bitmap.bitmapData);
//			bitmapData = new BitmapDataEx(new BitmapData(100, 100, true, 0xFF000000));
			bitmap = new BitmapEx();
			bitmap.bitmapDataEx = bitmapData;
			addChild(bitmap);
			bitmap.setScale(1.5, 1.5);
			bitmap.setPivotXY(5, 5);
//			bitmap.rotation = 45;
		}
		
		private function mouseMove(event:MouseEvent):void {
//			trace(bitmap.getIntersect(new Point(mouseX, mouseY)));
		}
	}
}