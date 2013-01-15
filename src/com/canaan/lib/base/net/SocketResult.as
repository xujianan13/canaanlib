package com.canaan.lib.base.net
{
	public class SocketResult
	{
		private var _data:Object;
		
		public function SocketResult(data:Object = null)
		{
			setData(data);
		}
		
		public function setData(data:Object):void {
			_data = data;
		}
		
		public function get cmd():int {
			return int(_data.cmd);
		}
		
		public function get data():Object {
			return _data.data;
		}
		
		public function get error():int {
			return int(_data.error);
		}
		
		public function get success():Boolean {
			return error != 0;
		}
	}
}