package test.component
{
	import com.canaan.lib.base.component.controls.Clip;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Config;
	import com.canaan.lib.base.core.Setting;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.managers.ResourceManager;
	import com.canaan.lib.base.managers.TimerManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.utils.setTimeout;
	
	public class TestClips extends Sprite
	{
		private var clip:Clip;
		private var clip2:Clip;
		
		public function TestClips()
		{
			Setting.fps = 2;
			
			Application.initialize(this);
			
			clip = new Clip();
			
			ResourceManager.getInstance().add("assets/comp.swf", new MethodElement(complete));
			ResourceManager.getInstance().load();
		}
		
		private function complete(content:*):void {
			clip.tileX = 10;
			clip.tileY = 1;
			clip.interval = 200;
			clip.left = 5;
//			clip.url = "png.comp.clip_num";
			clip.url = "assets/clip_num.png";
			addChild(clip);
			clip.fromTo(0, 6, new MethodElement(callback));
//			clip.autoRemoved = true;
			stage.addEventListener(MouseEvent.CLICK, onClick);
//			clip.prevFrame();
			
//			TimerManager.getInstance().doOnce(1000, t);
//			clip2 = new Clip("png.comp.clip_num", 10, 1);
//			addChild(clip2);
//			clip2.y = 50;
		}
		
		private function callback():void {
			trace("callback");
			clip.fromTo(0, 6, new MethodElement(callback));
		}
		
		private function onClick(event:MouseEvent):void {
//			if (!clip.isPlaying) {
//				addChild(clip);
//				clip.play();
//				clip.interval = 500;
//			}
			clip.stop();
		}
		
		private function onComplete(event:Event):void {
			trace("onComplete");
		}
		
		private function t():void {
			clip2 = new Clip("assets/clip_num.png", 10, 1);
			addChild(clip2);
			clip2.y = 50;
		}
	}
}