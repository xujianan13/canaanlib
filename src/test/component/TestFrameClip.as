package test.component
{
	import com.canaan.lib.base.component.controls.FrameClip;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class TestFrameClip extends Sprite
	{
		private var frameClip:FrameClip;
		
		public function TestFrameClip()
		{
			Application.initialize(this);
			
			frameClip = new FrameClip();
			frameClip.addEventListener(Event.COMPLETE, playComplete);
			addChild(frameClip);
			ResourceManager.getInstance().add("assets/vector.swf", new MethodElement(complete));
			ResourceManager.getInstance().load();
		}

		private function playComplete(event:Event):void {
			trace("playComplete");
		}
		
		private function complete(content:*):void {
			
//			frameClip.autoRemoved = true;
			frameClip.play();
//			frameClip.stop();
//			frameClip.width = 100;
//			frameClip.height = 50;
//			frameClip.gotoAndPlay(216);
//			frameClip.prevFrame();
			
			
			frameClip.mc = ResourceManager.getInstance().getNewInstance("assets.frameclip_Clock");
//			frameClip.gotoAndStop(50);
//			frameClip.skin = "assets.frameclip_Bear";
			
			frameClip.fromTo(0, 6);
			
			frameClip.showBorder();
		}
		
		private function onComplete():void {
//			frameClip.fromTo(0, 6, new MethodElement(onComplete));
		}
	}
}