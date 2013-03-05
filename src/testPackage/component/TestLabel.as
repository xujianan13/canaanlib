package testPackage.component
{
	import com.canaan.lib.base.component.UIComponent;
	import com.canaan.lib.base.component.controls.Label;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.LocalManager;
	
	import flash.display.Sprite;
	
	public class TestLabel extends Sprite
	{
		public function TestLabel()
		{
			UIComponent.langFunc = langFunc;
			LocalManager.getInstance().loadResources("test1 = testString", "test");
			LocalManager.getInstance().loadResources("test2 = testString {0} is ok", "test");
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function langFunc(id:String, args:Array = null):String {
			return LocalManager.getInstance().getString(id, "test", args);
		}
		
		private function initializeComplete():void {
			var label:Label = new Label("<Font color=\"#FF0000\">测试字体</Font>");
			label.langId = "test2";
			label.langArgs = ["oy"];
			label.left = 5;
			label.top = 5;
			label.height = 0;
			label.bold = false;
			label.htmlMode = true;
			label.background = true;
			label.border = true;
			label.backgroundColor = 0xFF00FF;
			addChild(label);
		}
	}
}