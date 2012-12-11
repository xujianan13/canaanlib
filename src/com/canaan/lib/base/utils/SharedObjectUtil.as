package com.canaan.lib.base.utils
{
	import flash.net.SharedObject;
	
	/**
	 * Cookies封装类
	 * 用于统一的储存Cookies
	 * PREFIX是一个前缀，因为可能有多版本多语言存在
	 * 如果不加PREFIX的话，会造成一台机器多个版本公用Cookies的情况发生
	 * 另外要注意，如果保存的Cookies名称中包含文件名不允许的字符，如":","*"的话会保存不了Cookies
	 * 所以需要用到replaceSharedObjectName去替换这些非法字符
	 * 
	 */
	public class SharedObjectUtil
	{
		public static var LOCAL_PATH:String = "/";
		public static var SHAREDOBJECT_PREFIX:String = "";
		
		public function SharedObjectUtil()
		{
			
		}
		
		public static function formatName(name:String):String {
			return replacePathString(SHAREDOBJECT_PREFIX + name);
		}
		
		public static function replacePathString(sharedObjectName:String, replacement:String = ""):String {
			var reg:RegExp = new RegExp("[\\\/:\*\?\"<>|,]", "g");
			return sharedObjectName.replace(reg, replacement);
		}

		public static function addSharedObject(name:String, value:*):void {
			name = formatName(name);
			var so:SharedObject = SharedObject.getLocal(name, LOCAL_PATH);
			so.data[name] = value;
			so.flush();
		}
		
		public static function removeSharedObject(name:String):void {
			name = formatName(name);
			var so:SharedObject = SharedObject.getLocal(name, LOCAL_PATH);
			so.clear();
		}
		
		public static function getSharedObject(name:String):Object {
			name = formatName(name);
			var so:SharedObject = SharedObject.getLocal(name, LOCAL_PATH);
			var result:Object = so.data[name];
			return result;
		}
		
		public static function hasSharedObject(name:String):Boolean {
			name = formatName(name);
			var so:SharedObject = SharedObject.getLocal(name, LOCAL_PATH);
			var result:Boolean = so.data.hasOwnProperty(name);
			return result;
		}
	}
}