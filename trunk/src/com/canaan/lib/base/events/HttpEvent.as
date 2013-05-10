package com.canaan.lib.base.events
{
	import com.canaan.lib.base.net.ServerRequest;
	import com.canaan.lib.base.net.ServerResult;

	public class HttpEvent extends CEvent
	{
		public static const IO_ERROR:String = "ioError";
		public static const SECURITY_ERROR:String = "securityError";
		public static const SEND:String = "send";
		public static const RECEIVED:String = "received";
		public static const COMPLETE:String = "complete";
		public static const SERVER_ERROR:String = "serverError";
		
		private static var eventPool:Vector.<HttpEvent> = new <HttpEvent>[];
		
		public function HttpEvent(type:String, data:Object=null)
		{
			super(type, data);
		}
		
		public function get hostName():String {
			return _data.toString();
		}
		
		public function get serverRequest():ServerRequest {
			return _data as ServerRequest;
		}
		
		public function get serverResult():ServerResult {
			return _data as ServerResult;
		}
		
		public static function fromPool(type:String, data:Object = null):HttpEvent {
			if (eventPool.length != 0) {
				return eventPool.pop().reset(type, data);
			} else {
				return new HttpEvent(type, data);
			}
		}
		
		public static function toPool(event:HttpEvent):void {
			eventPool.push(event.reset());
		}
	}
}