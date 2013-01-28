package testPackage.component
{
	import com.canaan.lib.base.component.controls.ProgressBar;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	import flash.utils.setTimeout;
	
	public class TestProgressBar extends Sprite
	{
		private var progressBar:ProgressBar;
		
		public function TestProgressBar()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			ResourceManager.getInstance().add("assets/comp.swf");
			ResourceManager.getInstance().load(new Method(complete));
		}
		
		private function complete():void {
			progressBar = new ProgressBar();
			addChild(progressBar);
			progressBar.label = "牛逼";
			progressBar.width = 100;
			progressBar.skin = "png.comp.progress";
			progressBar.width = 200;
			progressBar.scale9 = "5,5,5,5";
//			progressBar.height = 50;
//			progressBar.value = 0.5;
//			progressBar.label = "牛逼";
			setTimeout(func, 1000);
		}
		
		private function func():void {
//			trace(progressBar.width);
		}
	}
}