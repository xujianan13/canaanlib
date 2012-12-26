package
{
	import com.canaan.lib.base.component.Layouts;
	import com.canaan.lib.base.component.ViewCreater;
	import com.canaan.lib.base.component.controls.Button;
	import com.canaan.lib.base.component.controls.PageList;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.events.UIEvent;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestPageList extends Sprite
	{
		private var list:PageList;
		
		public function TestPageList()
		{
			Application.initialize(this);
			ResourceManager.getInstance().add("assets/comp.swf", new MethodElement(complete));
			ResourceManager.getInstance().load();
			
			ViewCreater.addUserClass("TestListItem", TestListItem);
		}
		
		private function complete(content:*):void {
			list = new PageList("TestListItem", 2, 3);
			list.horizontalGap = 5;
			list.verticalGap = 5;
			list.showBorder();
			list.data = ["shit1", "shit2", "shit3", "shit4", "shit5", "shit6", "shit7", "shit8"];
			list.addEventListener(UIEvent.CHANGE, onChange);
			list.layout = Layouts.HORIZONTAL;
			addChild(list);
			list.left = 5;
			list.top = 5;
			
			var button:Button = new Button("png.comp.btn_blue", "change");
			button.mouseClickHandler = new MethodElement(mouseClick);
			button.moveTo(200, 200);
			addChild(button);
		}
		
		private function mouseClick():void {
			list.currentPage = list.currentPage == 0 ? 1 : 0;
		}
		
		private function onChange(event:UIEvent):void {
			trace(list.selectedValue);
		}
	}
}