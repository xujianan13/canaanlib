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
			if (!ExternalInterface.available) {
				Log.getInstance().error("ExternalInterface is not available!");
			}
			ExternalInterface.addCallback(functionName, closure);
		}
		
		public static function call(functionName:String, ...args):* {
			if (!ExternalInterface.available) {
				Log.getInstance().error("ExternalInterface is not available!");
			}
			ExternalInterface.call(functionName, args);
		}
	}
}