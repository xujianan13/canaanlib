package com.canaan.lib.base.events
{
	import flash.events.Event;

	public class LogEvent extends Event
	{
		public static const LOG:String = "log";
		
		public var owner:String;
		public var logLevel:int;
		public var value:*;
		public var logString:String;
		
		public function LogEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}