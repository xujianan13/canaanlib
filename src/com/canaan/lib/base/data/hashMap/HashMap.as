package com.canaan.lib.base.data.hashMap
{
	import flash.utils.Dictionary;

	public class HashMap
	{
		private var dict:Dictionary;
		private var _size:int;
		
		public function HashMap()
		{
			dict = new Dictionary();
		}
		
		public function put(key:*, value:*):void {
			if (!has(key)) {
				_size++;
			}
			dict[key] = value;
		}
		
		public function get(key:*):* {
			var value:* = dict[key];
			if (value !== undefined) {
				return value;
			}
			return null;
		}
		
		public function remove(key:*):void {
			if (has(key)) {
				delete dict[key];
				_size--;
			}
		}
		
		public function has(key:*):Boolean {
			return dict.hasOwnProperty(key);
		}
		
		public function isEmpty():Boolean {
			return _size == 0;
		}
		
		public function clone():HashMap {
			var hashMap:HashMap = new HashMap();
			var key:*;
			for (key in dict) {
				hashMap.put(key, dict[key]);
			}
			return hashMap;
		}
		
		public function clear():void {
			dict = new Dictionary();
			_size = 0;
		}
		
		public function get size():int {
			return _size;
		}
	}
}