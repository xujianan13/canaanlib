package com.canaan.lib.base.events
{
	public class SceneEvent extends CEvent
	{
		public static const ENTER_SCENE:String = "enterScene";
		public static const EXIT_SCENE:String = "exitScene";
		
		private static var eventPool:Vector.<SceneEvent> = new <SceneEvent>[];
		
		public function SceneEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		public static function fromPool(type:String, data:Object = null):SceneEvent {
			if (eventPool.length != 0) {
				return eventPool.pop().reset(type, data);
			} else {
				return new SceneEvent(type, data);
			}
		}
		
		public static function toPool(event:SceneEvent):void {
			eventPool.push(event.reset());
		}
	}
}