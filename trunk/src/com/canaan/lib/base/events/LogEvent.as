package com.canaan.lib.base.events
{
	public class LogEvent extends CEvent
	{
		public static const LOG:String = "log";
		
		private var _owner:String;
		private var _logLevel:int;
		private var _logString:String;
		
		public function LogEvent(type:String, data:Object, owner:String, logLevel:int, logString:String)
		{
			super(type, data);
			_owner = owner;
			_logLevel = logLevel;
			_logString = logString;
		}
		
		public function get value():String {
			return _data.toString();
		}
		
		public function get owner():String {
			return _owner;
		}
		
		public function get logLevel():int {
			return _logLevel;
		}
		
		public function get logString():String {
			return _logString;
		}
	}
}