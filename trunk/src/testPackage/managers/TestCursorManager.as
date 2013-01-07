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
			Application.initialize(this);
			ResourceManager.getInstance().add("assets/bear.swf", new Method(onComplete));
			ResourceManager.getInstance().load();
			addChild(CursorManager.getInstance());
		}
		
		private function onComplete(content:*):void {
			CursorManager.getInstance().addCursor("bear", content);
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