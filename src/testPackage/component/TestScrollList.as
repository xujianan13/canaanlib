package testPackage.component
{
	import com.canaan.lib.base.component.ViewCreater;
	import com.canaan.lib.base.component.controls.Button;
	import com.canaan.lib.base.component.controls.ScrollList;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestScrollList extends Sprite
	{
		private var list:ScrollList;
		
		public function TestScrollList()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			ViewCreater.addUserClass("TestListItem", TestListItem);
			ResourceManager.getInstance().add("assets/comp.swf");
			ResourceManager.getInstance().load(new Method(complete));
		}
		
		private function complete():void {
			list = new ScrollList("TestListItem", "png.comp.vscroll");
			list.horizontalGap = 5;
			list.verticalGap = 5;
			list.row = 10;
			list.column = 1;
//			list.layout = Layouts.VERTICAL;
//			list.scrollSkin = "png.comp.hscroll";
			list.showBorder();
			var data:Array = [];
			for (var i:int = 0; i < 21; i++) {
				data.push("test" + i);
			}
			list.data = data;
			list.currentPage = 4;
			addChild(list);
			list.left = 5;
			list.top = 5;
			
			var button:Button = new Button("png.comp.btn_blue", "change");
			button.mouseClickHandler = new Method(mouseClick);
			button.moveTo(200, 200);
			addChild(button);
		}
		
		private function mouseClick():void {
//			list.currentPage = list.currentPage == 0 ? 1 : 0;
			list.column = 2;
		}
	}
}