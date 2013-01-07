package testPackage.managers
{
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.managers.DoubleClickManager;
	
	import flash.display.Sprite;
	
	public class TestDoubleClickManager extends Sprite
	{
		public function TestDoubleClickManager()
		{
			super();
			Application.initialize(this);
			
			var sprite:Sprite = new Sprite();
			sprite.graphics.beginFill(0);
			sprite.graphics.drawCircle(50, 50, 50);
			sprite.graphics.endFill();
			addChild(sprite);
			
			DoubleClickManager.getInstance().register(sprite, onDoubleClick);
		}
		
		private function onDoubleClick():void {
			trace("onDoubleClick");
		}
	}
}