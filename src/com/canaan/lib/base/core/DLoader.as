package com.canaan.lib.base.core
{
	import flash.display.Loader;
	
	public class DLoader extends Loader
	{
		protected var _data:Object;
		
		public function DLoader()
		{
			super();
		}
		
		public function set data(value:Object):void {
			_data = value;
		}
		
		public function get data():Object {
			return _data;
		}
	}
}