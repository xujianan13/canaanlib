package testPackage.display.effects
{
	import com.canaan.lib.base.animation.Transitions;
	import com.canaan.lib.base.component.controls.Image;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.display.effects.EasingMove;
	import com.canaan.lib.base.managers.StageManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class TestEasingMove extends Sprite
	{
		private var image:Image;
		private var easingMove:EasingMove = new EasingMove();
		
		public function TestEasingMove()
		{
			Application.initialize(this, new Method(initializeComplete));
			image = new Image("assets/Altar.png");
			addChild(image);
		}
		
		private function initializeComplete():void {
			StageManager.getInstance().registerHandler(MouseEvent.CLICK, start);
		}
		
		private function start():void {
			easingMove.start(image, 2, 0, 0, 200, 200, null, null, Transitions.EASE_OUT_ELASTIC);
		}
	}
}