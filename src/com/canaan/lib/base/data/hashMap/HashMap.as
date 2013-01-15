package com.canaan.lib.base.data.hashMap
{
	import flash.utils.Dictionary;

	public class HashMap
	{
		private var dict:Dictionary = new Dictionary();
		private var _size:int;
		
		public function HashMap()
		{
		}
		
		public function put(key:*, value:*):void {
			if (!has(key)) {
				_size++;
			}
			dict[key] = value;
		}
		
		public function get(key:*):* {
			return dict[key];
		}
		
		public function remove(key:*):void {
			var value:Object = dict[key];
			if (value) {
				delete dict[key];
				_size--;
			}
		}
		
		public function has(key:*):Boolean {
			return dict.hasOwnProperty(key);
		}
		
		public function get size():int {
			return _size;
		}
	}
}