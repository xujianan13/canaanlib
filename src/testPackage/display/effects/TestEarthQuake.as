package testPackage.display.effects
{
	import com.canaan.lib.base.component.controls.Image;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.display.effects.EarthQuake;
	import com.canaan.lib.base.managers.StageManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class TestEarthQuake extends Sprite
	{
		private var image:Image;
		private var earthEquak:EarthQuake = new EarthQuake();
		
		public function TestEarthQuake()
		{
			Application.initialize(this, new Method(initializeComplete));
			var image:Image;
			for (var i:int = 0; i < 100; i++) {
				image = new Image("assets/Altar.png");
				image.x = Math.random() * 1000;
				image.y = Math.random() * 600;
				addChild(image);
			}
		}
		
		private function initializeComplete():void {
			StageManager.getInstance().registerHandler(MouseEvent.CLICK, start);
		}
		
		private function start():void {
			earthEquak.start(this, 0.1, 10);
		}
	}
}