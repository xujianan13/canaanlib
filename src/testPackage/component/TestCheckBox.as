package testPackage.component
{
	import com.canaan.lib.base.component.controls.CheckBox;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestCheckBox extends Sprite
	{
		private var checkBox:CheckBox;
		
		public function TestCheckBox()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			ResourceManager.getInstance().add("assets/comp.swf");
			ResourceManager.getInstance().load(new Method(complete));
		}
		
		private function complete():void {
			checkBox = new CheckBox("png.comp.checkbox", "checkbox");
			addChild(checkBox);
		}
	}
}