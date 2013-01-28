package testPackage.component
{
	import com.canaan.lib.base.component.controls.TextInput;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class TestTextInput extends Sprite
	{
		private var textInput:TextInput;
		
		public function TestTextInput()
		{
			Application.initialize(this, new Method(initializeComplete));
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function initializeComplete():void {
			
			textInput = new TextInput("hi");
//			textInput.editable = false;
//			textInput.selectable = true;
//			textInput.selectable = false;
//			textInput.backgroundColor = 0x00FF00;
//			textInput.background = true;
//			textInput.border = true;
			textInput.restrict = "0-9";
			textInput.maxChars = 10;
			addChild(textInput);
		}
		
		private function onClick(event:MouseEvent):void {
//			textInput.borderColor = 0xFF0000;
		}
	}
}