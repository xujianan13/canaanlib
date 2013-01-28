package testPackage.component
{
	import com.canaan.lib.base.component.controls.Clip;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.events.UIEvent;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class TestClips extends Sprite
	{
		private var clip:Clip;
		private var clip2:Clip;
		
		public function TestClips()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			ResourceManager.getInstance().add("assets/comp.swf");
			ResourceManager.getInstance().load(new Method(complete));
		}
		
		private function complete():void {
			clip = new Clip();
			clip.url = "png.comp.clip_num";
			clip.tileX = 10;
			clip.tileY = 1;
			clip.interval = 500;
			clip.left = 5;
			
//			clip.url = "assets/clip_num.png";
			addChild(clip);
			clip.play();
			
			clip.dispatcher.addEventListener(UIEvent.COMPLETE, onComplete);
			
//			clip.autoRemoved = true;
			stage.addEventListener(MouseEvent.CLICK, onClick);
//			clip.prevFrame();
			
//			TimerManager.getInstance().doOnce(1000, t);
//			clip2 = new Clip("png.comp.clip_num", 10, 1);
//			addChild(clip2);
//			clip2.y = 50;
		}
		
		private function onComplete():void {
//			clip.fromTo(0, 6, new Method(callback));
//			clip.autoRemoved = true;
//			clip.play();
		}
		
		private function callback():void {
			trace("callback");
//			clip.fromTo(0, 6, new Method(callback));
		}
		
		private function onClick(event:MouseEvent):void {
//			if (!clip.isPlaying) {
//				addChild(clip);
//				clip.play();
//				clip.interval = 500;
//			}
			clip.stop();
		}

		private function t():void {
			clip2 = new Clip("assets/clip_num.png", 10, 1);
			addChild(clip2);
			clip2.y = 50;
		}
	}
}