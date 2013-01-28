package testPackage.component
{
	import com.canaan.lib.base.component.controls.Label;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	public class TestLabel extends Sprite
	{
		public function TestLabel()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			var label:Label = new Label("<Font color=\"#FF0000\">测试字体</Font>");
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