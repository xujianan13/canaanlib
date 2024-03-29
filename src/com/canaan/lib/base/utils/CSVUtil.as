package com.canaan.lib.base.utils
{
	public class CSVUtil
	{
		public static var wrap:String = "\r\n";
		public static var separator:String = ",";
		public static var quote:String = "\"";
		public static var doubleQuotes:String = "\"\"";
		public static var quoteReg:RegExp = /""/g;
		public static var doubleQuotesReg:RegExp = /\"/g;
		public static var splitReg:RegExp = /"?,(?=[^"]*(?:(?:"[^"]*){2})*$)"?/; 

		private static function escape(value:String):String {
			return value.replace(quoteReg, quote);
		}
		
		private static function eacapeForEach(element:String, index:int, array:Array):void {
			element = escape(element);
			var searchIndex:int;
			if (index == 0) {
				searchIndex = element.indexOf(quote);
				if (searchIndex == 0) {
					element = element.substring(1);
				}
			} else if (index == array.length - 1) {
				searchIndex = element.lastIndexOf(quote);
				if (searchIndex == element.length - 1) {
					element = element.substring(0, searchIndex);
				}
			}
			array[index] = element;
		}

		public static function getTitles(csv:String):Array {
			var result:Array;
			var lines:Array = csv.split(wrap);
			if (lines.length > 0) {
				result = lines[0].split(splitReg);
				result.forEach(eacapeForEach);
			}
			return result;
		}

		public static function CSVToArray(csv:String):Array {
			var result:Array = [];
			var lines:Array = csv.split(wrap);
			// remove the last line ""
			if (lines.length > 0) {
				lines.pop();
			}
			// remove the first line title
			var keys:Array = lines.shift().split(splitReg);
			keys.forEach(eacapeForEach);
			var line:String;
			var values:Array;
			var object:Object;
			for each (line in lines) {
				values = line.split(splitReg);
				values.forEach(eacapeForEach);
				object = {};
				for (var i:int = 0; i < keys.length; i++) {
					object[keys[i]] = values[i];
				}
				result.push(object);
			}
			return result;
		}
		
		public static function CSVToVector(csv:String):Vector.<Object> {
			var result:Vector.<Object> = new Vector.<Object>();
			var lines:Array = csv.split(wrap);
			// remove the last line ""
			if (lines.length > 0) {
				lines.pop();
			}
			// remove the first line title
			var keys:Array = lines.shift().split(splitReg);
			keys.forEach(eacapeForEach);
			var line:String;
			var values:Array;
			var object:Object;
			for each (line in lines) {
				values = line.split(splitReg);
				values.forEach(eacapeForEach);
				object = {};
				for (var i:int = 0; i < keys.length; i++) {
					object[keys[i]] = values[i];
				}
				result.push(object);
			}
			return result;
		}
		
		public static function CSVToObject(csv:String, key:* = null):Object {
			var csvVector:Vector.<Object> = CSVToVector(csv);
			if (key != null) {
				if (key is Array) {
					return ArrayUtil.arrayToObjectMultiKey(csvVector, key);
				} else if (key is String) {
					return ArrayUtil.arrayToObject(csvVector, key);
				}
			} else {
				var titles:Array = getTitles(csv);
				return ArrayUtil.arrayToObject(csvVector, titles[0]);
			}
			return null;
		}
		
		private static function createLine(value:Array):String {
			var result:String = "";
			var str:String;
			var l:int = value.length;
			for (var i:int = 0; i < l; i++) {
				str = value[i];
				if (str.indexOf(separator) != -1 || str.indexOf(quote) != -1) {
					str = str.replace(doubleQuotesReg, doubleQuotes);
					str = quote + str + quote;
				}
				result += str;
				if (i != value.length - 1) {
					result += separator;
				}
			}
			return result;
		}
		
		public static function ArrayToCSV(source:Array, titles:Array):String {
			if (source == null || source.length == 0 || titles == null || titles.length == 0) {
				return null;
			}
			
			var result:String = "";
			result += createLine(titles) + wrap;
			
			var obj:Object;
			var title:String;
			var array:Array;
			for each (obj in source) {
				array = [];			
				for each (title in titles) {
					if (!obj.hasOwnProperty(title)) {
						obj[title] = "";
					}
					array.push(obj[title]);
				}
				result += createLine(array) + wrap;
			}
			return result;
		}
		
		public static function ObjectToCSV(source:Object, titles:Array):String {
			if (source == null) {
				return null;
			}
			var array:Array = ObjectUtil.objectToArray(source);
			return ArrayToCSV(array, titles);
		}
	}
}