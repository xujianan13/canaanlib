package test.component
{
	import com.canaan.lib.base.component.Layouts;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class TestViewCreater extends Sprite
	{
		private var view:TestView;
		
		public function TestViewCreater()
		{
			Application.initialize(this);
			ResourceManager.getInstance().add("assets/comp.swf", new MethodElement(complete));
			ResourceManager.getInstance().load();
		}
		
		private function complete(content:*):void {
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