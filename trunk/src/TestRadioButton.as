package
{
	import com.canaan.lib.base.component.controls.RadioButton;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestRadioButton extends Sprite
	{
		private var radioButton:RadioButton;
		
		public function TestRadioButton()
		{
			Application.initialize(this);
			
			radioButton = new RadioButton();
//			radioButton.label = "checkbox";
			addChild(radioButton);
			ResourceManager.getInstance().add("assets/comp.swf", new MethodElement(complete));
			ResourceManager.getInstance().load();
		}
		
		private function complete(content:*):void {
			radioButton.skin = "png.comp.radio";
			radioButton.label = "checkbox";
			radioButton.mouseClickHandler = new MethodElement(onClick);
		}
		
		private function onClick():void {
			radioButton.label = "fucku";
		}
	}
}