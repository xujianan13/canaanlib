package com.canaan.lib.base.events
{
	import flash.utils.getQualifiedClassName;

	public class CEvent
	{
		private static var eventPool:Vector.<CEvent> = new <CEvent>[];
		
		protected var _target:CEventDispatcher;
		protected var _type:String;
		protected var _data:Object;
		
		public function CEvent(type:String, data:Object = null)
		{
			_type = type;
			_data = data;
		}
		
		public function get target():CEventDispatcher {
			return _target;
		}
		
		public function get type():String {
			return _type;
		}
		
		public function get data():Object {
			return _data;
		}
		
		public function toString():String {
			return "[" + getQualifiedClassName(this).split("::").pop() + " type=\"" + _type + "\"]";
		}
		
		internal function setTarget(target:CEventDispatcher):void {
			_target = target;
		}
		
		internal function reset(type:String = null, data:Object = null):CEvent {
			_type = type;
			_data = data;
			_target = null;
			return this;
		}
		
		public static function fromPool(type:String, data:Object = null):CEvent {
			if (eventPool.length != 0) {
				return eventPool.pop().reset(type, data);
			} else {
				return new CEvent(type, data);
			}
		}
		
		public static function toPool(event:CEvent):void {
			eventPool.push(event.reset());
		}
	}
}