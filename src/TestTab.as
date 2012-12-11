package
{
	import com.canaan.lib.base.component.Layouts;
	import com.canaan.lib.base.component.controls.Tab;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestTab extends Sprite
	{
		private var tab:Tab;
		
		public function TestTab()
		{
			Application.initialize(this);

			ResourceManager.getInstance().add("assets/comp.swf", new MethodElement(complete));
			ResourceManager.getInstance().load();
		}
		
		private function complete(content:*):void {
			tab = new Tab("a,b,c,d", "png.comp.btn_blue");
			addChild(tab);
			tab.layout = Layouts.HORIZONTAL;
//			tab.layout = Layouts.VERTICAL;
			tab.gap = 10;
			tab.left = 10;
			tab.top = 10;
		}
	}
}