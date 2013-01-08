package com.canaan.lib.base.utils
{
	import flash.net.LocalConnection;
	
	public class GameUtil
	{
		/**
		 * 垃圾回收
		 */
		public static function gc():void {
			try {
				new LocalConnection().connect("gc");
				new LocalConnection().connect("gc");
			} catch (error:Error) {
				
			}
		}
	}
}