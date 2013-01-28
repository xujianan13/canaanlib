package testPackage.managers
{
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.CursorManager;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class TestCursorManager extends Sprite
	{
		private var show:Boolean;
		
		public function TestCursorManager()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			ResourceManager.getInstance().add("assets/bear.swf");
			ResourceManager.getInstance().load(new Method(onComplete));
			addChild(CursorManager.getInstance());
		}
		
		private function onComplete():void {
			CursorManager.getInstance().addCursor("bear", ResourceManager.getInstance().getContent("assets/bear.swf"));
			stage.addEventListener(MouseEvent.CLICK, onClick);
			CursorManager.getInstance().removeCursor();
		}
		
		private function onClick(event:MouseEvent):void {
			show = !show;
			if (show) {
				CursorManager.getInstance().showCursor("bear");
			} else {
//				CursorManager.getInstance().removeCursor();
				CursorManager.getInstance().showSystemCursor();
			}
		}
	}
}