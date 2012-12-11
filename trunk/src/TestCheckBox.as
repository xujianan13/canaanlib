package
{
	import com.canaan.lib.base.component.controls.CheckBox;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
//	[SWF(backgroundColor="0x000000")]
	public class TestCheckBox extends Sprite
	{
		private var checkBox:CheckBox;
		
		public function TestCheckBox()
		{
			Application.initialize(this);
			checkBox = new CheckBox();
			addChild(checkBox);
//			checkBox.disabled = true;
			ResourceManager.getInstance().add("assets/comp.swf", new MethodElement(complete));
			ResourceManager.getInstance().load();

		}
		
		private function complete(content:*):void {
			checkBox.skin = "png.comp.checkbox";
			checkBox.label = "checkbox";
		}
	}
}