package testPackage.managers
{
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.TimerManager;
	import com.canaan.lib.base.utils.DateUtil;
	
	import flash.display.Sprite;
	
	public class TestTimerManager extends Sprite
	{
		public function TestTimerManager()
		{
			super();
			Application.initialize(this, new Method(callback))
		}
		
		private function callback():void {
			TimerManager.getInstance().time = new Date().time;
			TimerManager.getInstance().doFrameLoop(48, test);
//			TimerManager.getInstance().doFrameLoop(48, test);
		}
		
		private function test():void {
			trace(DateUtil.formatDate(new Date(TimerManager.getInstance().time)));
		}
	}
}