package com.canaan.lib.base.core
{
	import flash.utils.Dictionary;
	
	public class Config
	{
        private static var config:Dictionary = new Dictionary();

        public static function setConfig(key:*, value:*):void {
        	config[key] = value;
        }
        
        public static function getConfig(key:*):* {
        	if (hasConfig(key)) {
        		return config[key];
        	}
        	return "";
        }
		
		public static function hasConfig(key:*):Boolean {
			return config.hasOwnProperty(key);
		}
	}
}