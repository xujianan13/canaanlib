package com.canaan.lib.base.net
{
	public class ServerRequest
	{
		private var _cmd:int;
		private var _data:Object;
		
		public function ServerRequest(cmd:int = 0, data:Object = null)
		{
			reset(cmd, data);
		}
		
		public function reset(cmd:int, data:Object = null):void {
			_cmd = cmd;
			_data = data;
		}
		
		public function get cmd():int {
			return _cmd;
		}
		
		public function get data():Object {
			return _data;
		}
	}
}