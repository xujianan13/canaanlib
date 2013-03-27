package com.canaan.lib.base.events
{
	import com.canaan.lib.base.interfaces.ICEventDispatcher;
	
	import flash.utils.Dictionary;

	public class CEventDispatcher implements ICEventDispatcher
	{
		private var _target:Object;
		private var eventListeners:Dictionary;
		
		public function CEventDispatcher(target:Object = null)
		{
			_target = target || null;
		}
		
		public function addEventListener(type:String, listener:Function):void {
			if (eventListeners == null) {
				eventListeners = new Dictionary();
			}
			var listeners:Vector.<Function> = eventListeners[type];
			if (listeners == null) {
				eventListeners[type] = new <Function>[listener];
			} else if (listeners.indexOf(listener) == -1) {
				listeners.push(listener);
			}
		}
		
		public function removeEventListener(type:String, listener:Function):void {
			if (eventListeners) {
				var listeners:Vector.<Function> = eventListeners[type];
				if (listeners) {
					var numListeners:int = listeners.length;
					var remainingListeners:Vector.<Function> = new <Function>[];
					
					for (var i:int=0; i<numListeners; ++i) {
						if (listeners[i] != listener) remainingListeners.push(listeners[i]);
					}
					
					eventListeners[type] = remainingListeners;
				}
			}
		}
		
		public function removeEventListeners(type:String = null):void {
			if (type && eventListeners) {
				delete eventListeners[type];
			} else {
				eventListeners = null;
			}
		}
		
		public function hasEventListener(type:String):Boolean {
			var listeners:Vector.<Function> = eventListeners ? eventListeners[type] : null;
			return listeners ? listeners.length != 0 : false;
		}
		
		public function dispatchEvent(event:CEvent):void {
			if (eventListeners == null || !(event.type in eventListeners)) {
				return;
			}
			event.setTarget(_target);
			invoke(event);
		}
		
		public function dispatchEventWith(type:String, data:Object = null):void {
			if (hasEventListener(type)) {
				var event:CEvent = CEvent.fromPool(type, data);
				dispatchEvent(event);
				CEvent.toPool(event);
			}
		}
		
		private function invoke(event:CEvent):void {
			var listeners:Vector.<Function> = eventListeners ? eventListeners[event.type] : null;
			var numListeners:int = listeners == null ? 0 : listeners.length;
			if (numListeners) {
				event.setTarget(_target);
				for each (var listener:Function in listeners) {
					var numArgs:int = listener.length;
					if (numArgs == 0) {
						listener();
					} else if (numArgs == 1) {
						listener(event);
					} else {
						listener(event, event.data);
					}
				}
			}
		}
	}
}