package testPackage.animation
{
	import com.canaan.lib.base.animation.Tween;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class TestTween extends Sprite
	{
		private var sprite:Sprite;
		private var tween:Tween;
		private var time:int;
		
		public function TestTween()
		{
			super();
			sprite = new Sprite();
			sprite.graphics.beginFill(0);
			sprite.graphics.drawCircle(0, 0, 20);
			sprite.graphics.endFill();
			addChild(sprite);
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
			
			tween = Tween.fromPool(sprite, 2);
			tween.onStart = onStart;
			tween.onUpdate = onUpdate;
			tween.onComplete = onComplete;
			tween.moveTo(500, 0);
			tween.repeatCount = 4;
			tween.reverse = true;
			
//			var tween2:Tween = Tween.fromPool(sprite, 2);
//			tween2.moveTo(0, 0);
			
			tween.start();
//			tween.nextTween = tween2;
		}
		
		private function onStart():void {
			
		}
		
		private function onUpdate():void {
			trace(tween.transitionValue);
		}
		
		private function onComplete():void {
			
		}
		
		private function onClick(event:MouseEvent):void {
			if (tween.running) {
				tween.stop();
			} else {
				tween.start();
			}
		}
	}
}