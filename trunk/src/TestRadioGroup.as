package
{
	import com.canaan.lib.base.component.Layouts;
	import com.canaan.lib.base.component.controls.RadioGroup;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestRadioGroup extends Sprite
	{
		private var radioGroup:RadioGroup;
		
		public function TestRadioGroup()
		{
			Application.initialize(this);

			ResourceManager.getInstance().add("assets/comp.swf", new MethodElement(complete));
			ResourceManager.getInstance().load();
		}
		
		private function complete(content:*):void {
			radioGroup = new RadioGroup("a,b,c,d", "png.comp.radio");
			addChild(radioGroup);
//			radioGroup.layout = Layouts.HORIZONTAL;
			radioGroup.layout = Layouts.VERTICAL;
			radioGroup.gap = 10;
		}
	}
}