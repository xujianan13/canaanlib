package testPackage.component
{
	import com.canaan.lib.base.component.controls.ScrollBar;
	import com.canaan.lib.base.component.controls.VScrollBar;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestScrollBar extends Sprite
	{
		private var scrollBar:ScrollBar;
		
		public function TestScrollBar()
		{
			Application.initialize(this);
			
			scrollBar = new VScrollBar();
			addChild(scrollBar);
			ResourceManager.getInstance().add("assets/comp.swf", new Method(complete));
			ResourceManager.getInstance().load();
		}
		
		private function complete(content:*):void {
			scrollBar.skin = "png.comp.vscroll";
			scrollBar.setScroll(0, 100, 50);
			scrollBar.height = 100;
		}
	}
}