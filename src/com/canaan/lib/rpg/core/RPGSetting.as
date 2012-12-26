package com.canaan.lib.rpg.core
{
	import com.canaan.lib.base.core.Config;

	public class RPGSetting
	{
		// socket host
		public static function set gameSocketHost(value:String):void {
			Config.setConfig("gameSocketHost", value);
		}
		
		public static function get gameSocketHost():String {
			return Config.getConfig("gameSocketHost");
		}
		
		// socket port
		public static function set gameSocketPort(value:String):void {
			Config.setConfig("gameSocketPort", value);
		}
		
		public static function get gameSocketPort():String {
			return Config.getConfig("gameSocketPort");
		}
		
		// chat socket host
		public static function set chatSocketHost(value:String):void {
			Config.setConfig("chatSocketHost", value);
		}
		
		public static function get chatSocketHost():String {
			return Config.getConfig("chatSocketHost");
		}
		
		// chat socket port
		public static function set chatSocketPort(value:String):void {
			Config.setConfig("chatSocketPort", value);
		}
		
		public static function get chatSocketPort():String {
			return Config.getConfig("chatSocketPort");
		}
	}
}