package
{
	import com.canaan.lib.base.component.controls.Label;
	import com.canaan.lib.base.core.Application;
	
	import flash.display.Sprite;
	
	
	public class TestLabel extends Sprite
	{
		public function TestLabel()
		{
			Application.initialize(this);
			
			var label:Label = new Label("<Font color=\"#FF0000\">测试字体</Font>");
			label.height = 0;
			label.bold = false;
			label.htmlMode = true;
			addChild(label);

		}
	}
}