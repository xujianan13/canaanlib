package com.canaan.lib.base.core
{
	import com.canaan.lib.base.utils.BooleanUtil;

	public class Setting
	{
		// game fps
		public static function set fps(value:int):void {
			Config.setConfig("fps", value);
		}
		
		public static function get fps():int {
			return int(Config.getConfig("fps")) || 24;
		}
		
		// asset host
		public static function set assetHost(value:String):void {
			Config.setConfig("assetHost", value);
		}
		
		public static function get assetHost():String {
			return Config.getConfig("assetHost");
		}
		
		// locale
		public static function set locale(value:String):void {
			Config.setConfig("locale", value);
		}
		
		public static function get locale():String {
			return Config.getConfig("locale");
		}
		
		// platform
		public static function set platform(value:String):void {
			Config.setConfig("platform", value);
		}
		
		public static function get platform():String {
			return Config.getConfig("platform");
		}
		
		// version
		public static function set version(value:String):void {
			Config.setConfig("version", value);
		}
		
		public static function get version():String {
			return Config.getConfig("version");
		}
		
		// debug mode
		public static function set debugMode(value:Boolean):void {
			Config.setConfig("debugMode", value);
		}
		
		public static function get debugMode():Boolean {
			return BooleanUtil.toBoolean(Config.getConfig("debugMode"));
		}
	}
}