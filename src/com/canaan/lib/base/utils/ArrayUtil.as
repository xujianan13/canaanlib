package com.canaan.lib.base.utils
{
	public class ArrayUtil
	{
		public function ArrayUtil()
		{
		}
		
		public static function find(source:*, key:*, value:*):* {
			if (source != null) {
				var item:Object;
				for each (item in source) {
					if (item[key] == value) {
						return item;
					}
				}
			}
			return null;
		}

		public static function findElement(source:*, keys:Array, value:*):* {
			if (source != null && keys != null && keys.length > 0) {
				var item:Object;
				var key:String;
				for each (item in source) {
					for each (key in keys) {
						if (item[key] == value) {
							return item;
						}
					}
				}
			}
			return null;
		}
		
		public static function findElements(source:*, keys:Array, value:*):Array {
			var result:Array = [];
			if (source != null && keys != null && keys.length > 0) {
				var item:Object;
				var key:String;
				for each (item in source) {
					for each (key in keys) {
						if (item[key] == value) {
							result.push(item);
							break;
						}
					}
				}
			}
			return result;
		}
		
		public static function findElement2(source:*, keys:Array, values:Array):* {
			if (source == null || keys == null || values == null) {
				return null;
			}
			if (keys.length != values.length) {
				throw new Error("Key's length must equal value's length!");
			}
			var item:Object;
			var length:int;
			for each (item in source) {
				length = keys.length;
				for (var i:int = 0; i < length; i++) {
					if (item[keys[i]] != values[i]) {
						break;
					}
					if (i == length - 1) {
						return item;
					}
				}
			}
			return null;
		}
		
		public static function getRandomItem(source:Array):* {
			if (source == null || source.length == 0) {
				return null;
			}
			var randomNum:int = MathUtil.randRange(0, source.length - 1);
			return source[randomNum];
		}
		
		public static function arrayToObject(source:Array, key:String):Object {
			if (source == null) {
				return null;
			}
			var result:Object = {};
			var object:Object;
			for each (object in source) {
				result[object[key]] = object;
			}
			return result;
		}
		
		public static function arrayToObjectMultiKey(source:Array, keys:Array, separator:String = "_"):Object {
			if (source == null) {
				return null;
			}
			var result:Object = {};
			var object:Object;
			var key:String;
			var length:int;
			for each (object in source) {
				key = "";
				length = keys.length;
				for (var i:int = 0; i < length; i++) {
					key += object[keys[i]];
					if (i != length - 1) {
						key += separator;
					}
					i++;
				}
				result[key] = object;
			}
			return result;
		}
		
		public static function dispose(source:Array):void {
			if (source == null || source.length == 0) {
				return;
			}
			source.length = 0;
//			source.splice(0, source.length);
		}
		
		public static function remove(source:Array, ...args):void {
			if (source == null || source.length == 0) {
				return;
			}
			var item:Object;
			var searchIndex:int;
			for (var i:int = source.length - 1; i >=0; i--) {
				if (args.length == 0) {
					return;
				}
				item = source[i];
				searchIndex = args.indexOf(item);
				if (searchIndex != -1) {
					source.splice(i, 1);
					args.splice(searchIndex, 1);
				}
			}
		}
		
		public static function copyAndFill(source:Array, elementStr:String, separator:String = ","):Array {
			var result:Array = source.concat();
			var elements:Array = elementStr.split(separator);
			var index:int;
			var length:int = Math.min(result.length, elements.length);
			for (var i:int = 0; i < length; i++) {
				var value:String = elements[index];
				result[index] = (value == "true" ? true : (value == "false" ? false : value));
			}
			return result;
		}
	}
}