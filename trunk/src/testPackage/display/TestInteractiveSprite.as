package testPackage.display
{
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.display.InteractiveSprite;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class TestInteractiveSprite extends Sprite
	{
		private var loader:Loader;
		private var test:InteractiveSprite;
		
		public function TestInteractiveSprite()
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.load(new URLRequest("assets/Altar.png"));
		}
		
		private function onComplete(event:Event):void {
			test = new InteractiveSprite();
			test.bitmapData = Bitmap(loader.content).bitmapData;
			test.mouseUp = new Method(onMouseUp);
			test.mouseDown = new Method(onMouseDown);
			test.mouseOver = new Method(onMouseOver);
			test.mouseOut = new Method(onMouseout);
			test.mouseMove = new Method(onMouseMove);
			test.mouseClick = new Method(onMouseClick);
			addChild(test);
		}
		
		private function onMouseUp():void {
			trace("onMouseUp");
		}
		
		private function onMouseDown():void {
			trace("onMouseDown");
		}
		
		private function onMouseOver():void {
			trace("onMouseOver");
		}
		
		private function onMouseout():void {
			trace("onMouseout");
		}
		
		private function onMouseMove():void {
			trace("onMouseMove");
		}
		
		private function onMouseClick():void {
			trace("onMouseClick");
		}
	}
}