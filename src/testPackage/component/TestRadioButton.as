package testPackage.component
{
	import com.canaan.lib.base.component.controls.RadioButton;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestRadioButton extends Sprite
	{
		private var radioButton:RadioButton;
		
		public function TestRadioButton()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			radioButton = new RadioButton();
//			radioButton.label = "checkbox";
			addChild(radioButton);
			ResourceManager.getInstance().add("assets/comp.swf");
			ResourceManager.getInstance().load(new Method(complete));
		}
		
		private function complete():void {
			radioButton.skin = "png.comp.radio";
			radioButton.label = "checkbox";
			radioButton.mouseClickHandler = new Method(onClick);
		}
		
		private function onClick():void {
			radioButton.label = "fucku";
		}
	}
}