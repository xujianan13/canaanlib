package testPackage.managers
{
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.HttpManager;
	import com.canaan.lib.base.net.ServerResult;
	
	import flash.display.Sprite;
	
	public class TestHttpManager extends Sprite
	{
		public function TestHttpManager()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			HttpManager.getInstance().connect("http://localhost/YunLongJue/", "php");
			HttpManager.getInstance().registerHandler(1, onComplete);
			HttpManager.getInstance().send(1, {data:"data"});
		}
		
		private function onComplete(result:ServerResult):void {
			trace(result.data);
		}
	}
}