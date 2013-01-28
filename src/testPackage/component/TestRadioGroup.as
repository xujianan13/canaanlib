package testPackage.component
{
	import com.canaan.lib.base.component.Layouts;
	import com.canaan.lib.base.component.controls.RadioGroup;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestRadioGroup extends Sprite
	{
		private var radioGroup:RadioGroup;
		
		public function TestRadioGroup()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			ResourceManager.getInstance().add("assets/comp.swf");
			ResourceManager.getInstance().load(new Method(complete));
		}
		
		private function complete():void {
			radioGroup = new RadioGroup("a,b,c,d", "png.comp.radio");
			addChild(radioGroup);
//			radioGroup.layout = Layouts.HORIZONTAL;
			radioGroup.layout = Layouts.VERTICAL;
			radioGroup.gap = 10;
		}
	}
}