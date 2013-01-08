package testPackage.debug
{
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.debug.Log;
	import com.canaan.lib.base.events.LogEvent;
	
	import flash.display.Sprite;
	
	public class TestLog extends Sprite
	{
		public function TestLog()
		{
			super();
			Application.initialize(this);
			
			Log.getInstance().addEventListener(LogEvent.LOG, onLog);
			Log.getInstance().error("test");
		}
		
		private function onLog(event:LogEvent):void {
			trace("onLog:" + event.logString);
		}
	}
}