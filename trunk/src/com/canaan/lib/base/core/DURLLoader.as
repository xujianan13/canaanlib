package com.canaan.lib.base.core
{
	import com.canaan.lib.base.interfaces.IRecyclable;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	
	public class DURLLoader extends URLLoader implements IRecyclable
	{
		protected var _loaderData:Object;
		
		public function DURLLoader(request:URLRequest=null)
		{
			super(request);
			
		}
		
		public function reinitialize():void {
			close();
			_loaderData = null;
		}
		
		public function set loaderData(value:Object):void {
			_loaderData = value;
		}
		
		public function get loaderData():Object {
			return _loaderData;
		}
		
		public static function fromPool():DURLLoader {
			return ObjectPool.getObject(DURLLoader) as DURLLoader;
		}
		
		public static function toPool(urlLoader:DURLLoader):void {
			ObjectPool.disposeObject(urlLoader);
		}
	}
}