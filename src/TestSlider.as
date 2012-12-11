package
{
	import com.canaan.lib.base.component.controls.HSlider;
	import com.canaan.lib.base.component.controls.Slider;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestSlider extends Sprite
	{
		private var slider:Slider;
		
		public function TestSlider()
		{
			Application.initialize(this);
			
			slider = new HSlider();
			slider.x = 50;
			slider.y = 50;
			addChild(slider);
			
			ResourceManager.getInstance().add("assets/comp.swf", new MethodElement(complete));
			ResourceManager.getInstance().load();
		}
		
		private function complete(content:*):void {
			slider.skin = "png.comp.hslider";
			slider.showLabel = true;
			slider.width = 50;
			slider.tick = 1;
			slider.value = 5;
		}
	}
}