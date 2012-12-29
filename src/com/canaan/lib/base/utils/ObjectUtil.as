package com.canaan.lib.base.utils
{
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public class ObjectUtil
	{
		public static function clone(source:Object):Object {
	        var result:Object = {};
	        var prop:String;
	        for (prop in source) {
	        	result[prop] = source[prop];
	        }
	        return result;
	    }
	    
	    public static function deapClone(value:Object):* {
	    	var className:String = getQualifiedClassName(value);
	    	var clazz:Class = getDefinitionByName(className) as Class;
	    	if (className.indexOf("::") != -1) {
	    		className = className.split("::")[1];
	    	}
	    	registerClassAlias(className, clazz);
	    	var bytes:ByteArray = new ByteArray();
	    	bytes.writeObject(value);
	    	bytes.position = 0;
	    	return bytes.readObject();
	    }
	    
	    public static function count(source:Object):int {
	    	var count:int;
	    	var prop:String;
	    	for (prop in source) {
	    		count++;
	    	}
	    	return count;
	    }
	    
	    public static function merge(source:Object, target:Object):void {
	    	if (source == null) {
	    		return;
	    	}
	    	for (var key:Object in target) {
	    		source[key] = target[key];
	    	}
	    }
	    
	    public static function objectToArray(source:Object, addKey:Boolean = false, keyStr:String = "key", valueStr:String = "value"):Array {
	    	if (source == null) {
	    		return null;
	    	}
	    	var result:Array = [];
	    	var object:Object;
	    	for (var key:Object in source) {
	    		if (addKey) {
	    			object = {};
	    			object[keyStr] = key;
	    			object[valueStr] = source[key];
	    		} else {
	    			object = source[key];
	    		}
	    		result.push(object);
	    	}
	    	return result;
	    }
		
		public static function objectToVector(source:Object, addKey:Boolean = false, keyStr:String = "key", valueStr:String = "value"):Vector.<Object> {
			if (source == null) {
				return null;
			}
			var result:Vector.<Object> = new Vector.<Object>();
			var object:Object;
			for (var key:Object in source) {
				if (addKey) {
					object = {};
					object[keyStr] = key;
					object[valueStr] = source[key];
				} else {
					object = source[key];
				}
				result.push(object);
			}
			return result;
		}
		
		public static function dispose(source:*):void {
			if (source == null) {
				return;
			}
			var key:*;
			for (key in source) {
				delete source[key];
			}
		}
	}
}