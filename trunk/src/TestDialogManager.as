package
{
	import com.canaan.lib.base.component.controls.Dialog;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.managers.DialogManager;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class TestDialogManager extends Sprite
	{
		public function TestDialogManager()
		{
			ResourceManager.getInstance().add("assets/bear.swf", new MethodElement(onComplete));
			ResourceManager.getInstance().load();
			addChild(DialogManager.getInstance());
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
		}
		
		private function onKeyDown(event:KeyboardEvent):void {
			var dialog:Dialog = new Dialog();
			if (event.keyCode == Keyboard.ENTER) {
				dialog.graphics.beginFill(0xFFFFFF * Math.random(), Math.random());
				dialog.graphics.drawRect(0, 0, 600 * Math.random(), 400 * Math.random());
				dialog.graphics.endFill();
				dialog.popup(true);
				dialog.addEventListener(MouseEvent.CLICK, onClick2);
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
			dialog.close();
		}
		
		private function onComplete(content:*):void {
			
		}
	}
}