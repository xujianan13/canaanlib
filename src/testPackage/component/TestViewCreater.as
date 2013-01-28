package testPackage.component
{
	import com.canaan.lib.base.component.Layouts;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class TestViewCreater extends Sprite
	{
		private var view:TestView;
		
		public function TestViewCreater()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			ResourceManager.getInstance().add("assets/comp.swf");
			ResourceManager.getInstance().load(new Method(complete));
		}
		
		private function complete():void {
			view = new TestView();
			view.btnClose.addEventListener(MouseEvent.CLICK, onClick);
			view.layout = Layouts.HORIZONTAL;
			addChild(view);
			trace(view.id);
			trace(view.container.top);
		}
		
		private function onClick(event:MouseEvent):void {
			view.vs.selectedIndex = view.vs.selectedIndex == 0 ? 1 : 0;
		}
	}
}