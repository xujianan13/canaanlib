package
{
	import com.canaan.lib.base.component.controls.Label;
	import com.canaan.lib.base.core.Application;
	
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	
	
	public class TestLabel extends Sprite
	{
		public function TestLabel()
		{
			Application.initialize(this);
			
			var label:Label = new Label("<Font color=\"#FF0000\">测试字体</Font>");
			label.left = 5;
			label.top = 5;
			label.height = 0;
			label.bold = false;
			label.htmlMode = true;
			addChild(label);

			
			var textField:TextField = new TextField();
			textField.autoSize = TextFieldAutoSize.LEFT;
			textField.autoSize = TextFieldAutoSize.NONE;
			addChild(textField);
			trace(textField.height);
		}
	}
}