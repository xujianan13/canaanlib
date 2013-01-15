package com.canaan.lib.base.net
{
	import flash.net.Socket;
	
	public class SocketClient extends Socket
	{
		protected var _socketName:String;
		protected var _host:String;
		protected var _port:int;
		
		public function SocketClient(socketName:String)
		{
			super();
			_socketName = socketName;
		}
		
		override public function connect(host:String, port:int):void {
			_host = host;
			_port = port;
			super.connect(host, port);
		}
		
		public function get socketName():String {
			return _socketName;
		}
		
		public function get host():String {
			return _host;
		}
		
		public function get port():int {
			return _port;
		}
	}
}