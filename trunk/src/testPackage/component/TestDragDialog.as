package testPackage.component
{
	import com.canaan.lib.base.component.controls.Dialog;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.events.KeyEvent;
	import com.canaan.lib.base.managers.DialogManager;
	import com.canaan.lib.base.managers.KeyboardManager;
	
	import flash.display.Sprite;
	import flash.ui.Keyboard;
	
	public class TestDragDialog extends Sprite
	{
		public function TestDragDialog()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			addChild(DialogManager.getInstance());
			var dragDialog:Dialog = new Dialog();
			dragDialog.draggable = true;
			dragDialog.graphics.beginFill(0xFFFFFF * Math.random());
			dragDialog.graphics.drawRect(0, 0, 600 * Math.random(), 400 * Math.random());
			dragDialog.graphics.endFill();
			dragDialog.popup();
			
			KeyboardManager.getInstance().addEventListener(KeyEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(event:KeyEvent):void {
			if (event.keyCode == Keyboard.ENTER) {
				var dragDialog:Dialog = new Dialog();
				dragDialog.draggable = true;
				dragDialog.graphics.beginFill(0xFFFFFF * Math.random());
				dragDialog.graphics.drawRect(0, 0, 600 * Math.random(), 400 * Math.random());
				dragDialog.graphics.endFill();
				dragDialog.popup();
			}
		}
	}
}