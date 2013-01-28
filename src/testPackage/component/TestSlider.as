package testPackage.component
{
	import com.canaan.lib.base.component.controls.HSlider;
	import com.canaan.lib.base.component.controls.Slider;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.events.UIEvent;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestSlider extends Sprite
	{
		private var slider:Slider;
		
		public function TestSlider()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			slider = new HSlider();
			slider.x = 50;
			slider.y = 50;
			addChild(slider);
			slider.dispatcher.addEventListener(UIEvent.CHANGE, onChange);
			
			ResourceManager.getInstance().add("assets/comp.swf");
			ResourceManager.getInstance().load(new Method(complete));
		}
		
		private function complete():void {
			slider.skin = "png.comp.hslider";
			slider.showLabel = true;
			slider.tick = 1;
			slider.value = 5;
			slider.width = 150;
		}
		
		private function onChange(event:UIEvent):void {
			
		}
	}
}