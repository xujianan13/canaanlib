package testPackage.display.effects
{
	import com.canaan.lib.base.component.controls.Image;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.display.effects.Fade;
	import com.canaan.lib.base.managers.StageManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class TestFade extends Sprite
	{
		private var image:Image;
		private var fade:Fade = new Fade();
		
		public function TestFade()
		{
			Application.initialize(this, new Method(initializeComplete));
			image = new Image("assets/Altar.png");
			addChild(image);
		}
		
		private function initializeComplete():void {
			StageManager.getInstance().registerHandler(MouseEvent.CLICK, start);
		}
		
		private function start():void {
			fade.start(this, 1);
		}
	}
}