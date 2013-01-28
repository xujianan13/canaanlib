package testPackage.events
{
	import com.canaan.lib.base.events.CEvent;
	import com.canaan.lib.base.events.CEventDispatcher;
	
	import flash.display.Sprite;
	
	public class TestEvent extends Sprite
	{
		private var eventDispatcher:CEventDispatcher;
		
		public function TestEvent()
		{
			super();
			eventDispatcher = new CEventDispatcher();
			eventDispatcher.addEventListener("TestEvent", test);
			eventDispatcher.addEventListener("TestEvent", test1);
			eventDispatcher.addEventListener("TestEvent", test2);
			
			var event:CEvent = new CEvent("TestEvent");
			trace(event.toString());
			
			eventDispatcher.dispatchEvent(event);
		}
		
		private function test():void {
			trace("test");
		}
		
		private function test1(event:CEvent):void {
			trace("test1");
		}
		
		private function test2(event:CEvent, data:Object):void {
			trace("test2");
		}
	}
}