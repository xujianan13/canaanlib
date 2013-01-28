package testPackage.component
{
	import com.canaan.lib.base.component.Layouts;
	import com.canaan.lib.base.component.controls.Button;
	import com.canaan.lib.base.component.controls.Container;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestContainer extends Sprite
	{
		private var container:Container;
		
		public function TestContainer()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			container = new Container();
			container.left = 5;
			container.top = 5;
			container.gap = 5;
			container.layout = Layouts.VERTICAL;
			addChild(container);
			
			ResourceManager.getInstance().add("assets/comp.swf");
			ResourceManager.getInstance().load(new Method(complete));
		}
		
		private function complete():void {
			var button1:Button = new Button("png.comp.btn_blue");
			button1.label = "button1";
			container.addChild(button1);
//			container.showBorder();
			
			var button2:Button = new Button("png.comp.btn_blue");
			button2.label = "button2";
			container.addChild(button2);
			
			var button3:Button = new Button("png.comp.btn_blue");
			button3.label = "button3";
			container.addChild(button3);
			
			container.layout = Layouts.HORIZONTAL;
			
			container.showBorder();
		}
	}
}