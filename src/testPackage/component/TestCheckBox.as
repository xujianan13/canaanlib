package testPackage.component
{
	import com.canaan.lib.base.component.controls.CheckBox;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
//	[SWF(backgroundColor="0x000000")]
	public class TestCheckBox extends Sprite
	{
		private var checkBox:CheckBox;
		
		public function TestCheckBox()
		{
			Application.initialize(this);
			
//			checkBox.disabled = true;
			ResourceManager.getInstance().add("assets/comp.swf", new Method(complete));
			ResourceManager.getInstance().load();

		}
		
		private function complete(content:*):void {
			checkBox = new CheckBox("png.comp.checkbox", "checkbox");
			addChild(checkBox);
		}
	}
}