package com.canaan.lib.base.interfaces
{
	import com.canaan.lib.base.events.CEvent;

	public interface ICEventDispatcher
	{
		function addEventListener(type:String, listener:Function):void;
		function removeEventListener(type:String, listener:Function):void;
		function removeEventListeners(type:String = null):void;
		function hasEventListener(type:String):Boolean;
		function dispatchEvent(event:CEvent):void;
		function dispatchEventWith(type:String, data:Object = null):void;
	}
}