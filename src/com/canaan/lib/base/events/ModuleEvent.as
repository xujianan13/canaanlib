package com.canaan.lib.base.events
{
	public class ModuleEvent extends CEvent
	{
		public static const ADDED_TO_SCENE:String = "addedToScene";
		public static const REMOVE_FROM_SCENE:String = "removeFromScene";
		
		private static var eventPool:Vector.<ModuleEvent> = new <ModuleEvent>[];
		
		public function ModuleEvent(type:String, sceneName:String)
		{
			super(type, sceneName);
		}
		
		public function get sceneName():String {
			return _data.toString();
		}
		
		public static function fromPool(type:String, data:Object = null):ModuleEvent {
			if (eventPool.length != 0) {
				return eventPool.pop().reset(type, data);
			} else {
				return new ModuleEvent(type, data);
			}
		}
		
		public static function toPool(event:ModuleEvent):void {
			eventPool.push(event.reset());
		}
	}
}