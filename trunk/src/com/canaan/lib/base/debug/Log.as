package com.canaan.lib.base.debug
{
	import com.canaan.lib.base.events.LogEvent;
	import com.canaan.lib.base.managers.TimerManager;
	import com.canaan.lib.base.utils.DateUtil;
	
	import flash.events.EventDispatcher;
	
	[Event(name="log", type="com.canaan.lib.base.events.LogEvent")]
	
	public class Log extends EventDispatcher
	{
		public static const INFO:int = 0;
		public static const WARN:int = 1;
		public static const ERROR:int = 2;
		public static const FATAL:int = 3;
		
		public static const LEVEL_CONFIG:Object = {
			0:"INFO",
			1:"WARN",
			2:"ERROR",
			3:"FATAL"
		}
		private static var canInstantiate:Boolean = false;
		private static var instance:Log;
		
		private var logEntities:Object = {};
		private var _enabled:Boolean = true;

		public function Log()
		{
			if (!canInstantiate) {
				throw new Error("Can not instantiate, use getInstance() instead.");
			}
		}
		
		public static function getInstance():Log {
			if (instance == null) {
				canInstantiate = true;
				instance = new Log();
				canInstantiate = false;
			}
			return instance;
		}
		
		public function initialLog(owner:String = "default", logLevel:int = 0):void {
			if (logEntities[owner] == null) {
				var logEntity:LogEntity = new LogEntity(owner, logLevel);
				logEntities[owner] = logEntity;
			}
		}

		public function info(value:*, owner:String = "default"):void {
			log(owner, INFO, value);
		}
		
		public function warn(value:*, owner:String = "default"):void {
			log(owner, WARN, value);
		}
		
		public function error(value:*, owner:String = "default"):void {
			log(owner, ERROR, value);
		}
		
		public function fatal(value:*, owner:String = "default"):void {
			log(owner, FATAL, value);
		}
		
		private function log(owner:String, logLevel:int, value:*):void {
			if (!_enabled) {
				return;
			}
			
			if (logEntities[owner] == null) {
				initialLog(owner, INFO);
			}
				
			var logEntity:LogEntity = logEntities[owner];
			
			if (logLevel >= logEntity.logLevel) {
				var logString:String = formatLogString(owner, logLevel, value);
				var logEvent:LogEvent = new LogEvent("log");
				logEvent.owner = owner;
				logEvent.logLevel = logLevel;
				logEvent.value = value;
				logEvent.logString = logString;
				dispatchEvent(logEvent);
				trace(logString);
			}
		}
		
		private function formatLogString(owner:String, logLevel:int, value:*):String {
			var logString:String = "[LOG] " + DateUtil.formateDateFromSeconds(TimerManager.getInstance().time) + " ";
			logString += "[owner:\"" + owner + "\" ";
			logString += "level:\"" + LEVEL_CONFIG[logLevel] + "\"] - ";
			logString += value.toString();
			return logString;
		}
		
		public function set enabled(value:Boolean):void {
			this._enabled = value;
		}
		
		public function get enabled():Boolean {
			return this._enabled;
		}
	}
}

internal class LogEntity
{
	public var owner:String;
	public var logLevel:int;
	
	public function LogEntity(owner:String, logLevel:int)
	{
		this.owner = owner;
		this.logLevel = logLevel;
	}

}