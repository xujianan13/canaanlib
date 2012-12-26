package
{
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.events.KeyEvent;
	import com.canaan.lib.base.managers.KeyboardManager;
	
	import flash.display.Sprite;
	
	public class TestKeyBoardManager extends Sprite
	{
		public function TestKeyBoardManager()
		{
			Application.initialize(this);
			
			KeyboardManager.getInstance().enabled = true;
			KeyboardManager.getInstance().addEventListener(KeyEvent.KEY_DOWN, keyEvent);
			KeyboardManager.getInstance().addEventListener(KeyEvent.KEY_UP, keyEvent);
			KeyboardManager.getInstance().addEventListener(KeyEvent.KEY_DOWN_CTRL, keyEvent);
			KeyboardManager.getInstance().addEventListener(KeyEvent.KEY_UP_CTRL, keyEvent);
			KeyboardManager.getInstance().addEventListener(KeyEvent.KEY_DOWN_CTRL_SHIFT, keyEvent);
			KeyboardManager.getInstance().addEventListener(KeyEvent.KEY_UP_CTRL_SHIFT, keyEvent);
		}
		
		private function keyEvent(event:KeyEvent):void {
			trace(event.type);
		}
	}
}