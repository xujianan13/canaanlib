package test.managers
{
	import com.canaan.lib.base.managers.TimerManager;
	import com.canaan.lib.base.utils.DateUtil;
	
	import flash.display.Sprite;
	
	public class TestTimerManager extends Sprite
	{
		public function TestTimerManager()
		{
			super();
			
			TimerManager.getInstance().time = new Date().time;
			TimerManager.getInstance().doFrameLoop(48, test);
//			TimerManager.getInstance().doFrameLoop(48, test);
		}
		
		private function test():void {
			trace(DateUtil.formatDate(new Date(TimerManager.getInstance().time)));
		}
	}
}