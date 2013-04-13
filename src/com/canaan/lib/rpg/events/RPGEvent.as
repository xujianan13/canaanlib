package com.canaan.lib.rpg.events
{
	import com.canaan.lib.base.events.CEvent;
	
	public class RPGEvent extends CEvent
	{
		public static const OBJECT_MOVE:String = "objectMove";
		
		private static var eventPool:Vector.<RPGEvent> = new <RPGEvent>[];
		
		public function RPGEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		public static function fromPool(type:String, data:Object = null):RPGEvent {
			if (eventPool.length != 0) {
				return eventPool.pop().reset(type, data);
			} else {
				return new RPGEvent(type, data);
			}
		}
		
		public static function toPool(event:RPGEvent):void {
			event._type = null;
			event._data = null;
			event._target = null;
			eventPool.push(event);
		}
	}
}