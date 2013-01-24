package testPackage.managers
{
	import com.canaan.lib.base.component.controls.Dialog;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.DialogManager;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class TestDialogManager extends Sprite
	{
		private var gd:Dialog;
		
		public function TestDialogManager()
		{
			Application.initialize(this);
			
			ResourceManager.getInstance().add("assets/bear.swf", new Method(onComplete));
			ResourceManager.getInstance().load();
			addChild(DialogManager.getInstance());
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			
//			gd = new Dialog();
//			gd.graphics.beginFill(0xFFFFFF * Math.random(), Math.random());
//			gd.graphics.drawRect(0, 0, 600 * Math.random(), 400 * Math.random());
//			gd.graphics.endFill();
//			gd.popup(true);
//			gd.addEventListener(MouseEvent.CLICK, onClick2);
		}
		
		private function onKeyDown(event:KeyboardEvent):void {
			if (DialogManager.getInstance().numChildren > 5) {
				gd.popup(true);
				return;
			}
			var dialog:Dialog = new Dialog();
			if (event.keyCode == Keyboard.ENTER) {
				dialog.graphics.beginFill(0xFFFFFF * Math.random(), Math.random());
				dialog.graphics.drawRect(0, 0, 600 * Math.random(), 400 * Math.random());
				dialog.graphics.endFill();
				dialog.popup();
				dialog.addEventListener(MouseEvent.CLICK, onClick2);
//				dialog.addEventListener(MouseEvent.MOUSE_DOWN, onClick2);
			} else if (event.keyCode == Keyboard.SPACE) {
				dialog.graphics.beginFill(0xFFFFFF * Math.random(), Math.random());
				dialog.graphics.drawRect(0, 0, 600 * Math.random(), 400 * Math.random());
				dialog.graphics.endFill();
				dialog.show();
				dialog.addEventListener(MouseEvent.CLICK, onClick2);
			}
		}
		
		private function onClick2(event:MouseEvent):void {
			var dialog:Dialog = event.currentTarget as Dialog;
//			trace(dialog.isPopup);
//			dialog.close();
//			trace(dialog.isPopup);
			
			dialog.doDrag();
		}
		
		private function onComplete(content:*):void {
			
		}
	}
}