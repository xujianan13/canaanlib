package com.canaan.lib.base.core
{
	import com.canaan.lib.base.interfaces.IRecyclable;
	
	import flash.display.Loader;
	
	public class DLoader extends Loader implements IRecyclable
	{
		protected var _data:Object;
		
		public function DLoader()
		{
			super();
		}
		
		public function reinitialize():void {
			unloadAndStop();
			_data = null;
		}
		
		public function set data(value:Object):void {
			_data = value;
		}
		
		public function get data():Object {
			return _data;
		}
	}
}