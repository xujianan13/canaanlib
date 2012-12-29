package com.canaan.lib.base.utils
{
	import com.canaan.lib.base.debug.Log;
	
	import flash.external.ExternalInterface;
	
	public class JSUtil
	{
		public function JSUtil()
		{
		}

		public static function addCallback(functionName:String, closure:Function):void {
			if (!available) {
				Log.getInstance().error("ExternalInterface is not available!");
				return;
			}
			ExternalInterface.addCallback(functionName, closure);
		}
		
		public static function call(functionName:String, ...args):* {
			if (!available) {
				Log.getInstance().error("ExternalInterface is not available!");
				return;
			}
			ExternalInterface.call(functionName, args);
		}
		
		public static function get available():Boolean {
			if (!ExternalInterface.available) {
				return false;
			}
			if (!ExternalInterface.marshallExceptions) {
				ExternalInterface.marshallExceptions = true;
			}
			return true;
		}
	}
}