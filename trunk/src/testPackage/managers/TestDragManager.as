package testPackage.managers
{
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.DragManager;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class TestDragManager extends Sprite
	{
		private var mc:MovieClip;
		private var ss:Sprite;;
		
		public function TestDragManager()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			addChild(DragManager.getInstance());
			ResourceManager.getInstance().add("assets/bear.swf", "", new Method(onComplete));
			ResourceManager.getInstance().add("assets/Altar.png", "", new Method(onComplete2));
			ResourceManager.getInstance().load();
		}
		
		private function onComplete(content:*):void {
			var s:Sprite = new Sprite();
			addChild(s);
			mc = content as MovieClip;
			s.addChild(mc);
			s.addEventListener(MouseEvent.MOUSE_DOWN, onClick);
		}
		
		private function onComplete2(content:*):void {
			ss = new Sprite();
			ss.addChild(new Bitmap(content));
		}
		
		private function onClick(event:MouseEvent):void {
			DragManager.getInstance().doDrag(mc, ss);
		}
	}
}