package
{
	import com.canaan.lib.base.component.controls.ProgressBar;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestProgressBar extends Sprite
	{
		private var progressBar:ProgressBar;
		
		public function TestProgressBar()
		{
			Application.initialize(this);
			
			progressBar = new ProgressBar();
			progressBar.width = 100;
			progressBar.label = "牛逼";
			addChild(progressBar);
			
			ResourceManager.getInstance().add("assets/comp.swf", new MethodElement(complete));
			ResourceManager.getInstance().load();
		}
		
		private function complete(content:*):void {
			progressBar.skin = "png.comp.progress";
			progressBar.scale9 = "5,5,5,5";
			progressBar.width = 200;
			progressBar.height = 50;
			progressBar.value = 0.5;
//			progressBar.label = "牛逼";
		}
	}
}