package
{
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.managers.CursorManager;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	public class TestCursorManager extends Sprite
	{
		private var show:Boolean;
		
		public function TestCursorManager()
		{
			ResourceManager.getInstance().add("assets/bear.swf", new MethodElement(onComplete));
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