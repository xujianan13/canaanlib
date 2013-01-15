package com.canaan.lib.base.managers
{
	import com.canaan.lib.base.debug.Log;
	import com.canaan.lib.base.utils.StringUtil;
	
	import flash.utils.Dictionary;
	
    public class LocalManager
    {
    	private static var canInstantiate:Boolean;
        private static var instance:LocalManager;

        private var messages:Dictionary = new Dictionary();

        public function LocalManager()
        {
            if (!canInstantiate) {
				throw new Error("Can not instantiate, use getInstance() instead.");
			}
        }
        
        public static function getInstance():LocalManager {
            if (instance == null) {
            	canInstantiate = true;
                instance = new LocalManager();
                canInstantiate = false;
            }
            return instance;
        }
        
        public function loadResources(value:String, resourceName:String):void {
			var resource:Dictionary = messages[resourceName];
			if (resource == null) {
				resource = new Dictionary();
				messages[resourceName] = resource;
			}
        	var list:Array = [];
        	var substring:int;
        	var lineNum:int = -1;
			var l:int = value.length;
			for (var i:int = 0; i < l; i++) {
                var char:String = value.charAt(i);
                if (char == "\n" || char == "\r") {
                    if (lineNum != -1) {
                        list[substring] = value.substring(lineNum, i);
                        substring++;
                        lineNum = -1;
                    }
                } else {
                    if (lineNum == -1) {
                        lineNum = i;
                    }
                }
            }
            if (lineNum != -1) {
                list[substring] = value.substring(lineNum);
                substring++;
            }
            for each (var line:String in list) {
                var indexOf:int = line.indexOf("=");
                if (indexOf != -1) {
                	var mKey:String = StringUtil.trim(line.substring(0, indexOf));
                    var rtrim:String = StringUtil.trim(line.substring(indexOf + 1));
                    var flag:Boolean = true;
                    do {
                        var r:String = rtrim.replace("\\n", "\n");
                        if (r == rtrim)
                        {
                            flag = false;
                        }
                        rtrim = r;
                    } while (flag);
                    
                    while (rtrim.indexOf("\\") != -1) {
                    	rtrim = rtrim.replace("\\", "");
                    }
					resource[mKey] = rtrim;
                } 
            }
        }
        
        public function getString(name:String, resourceName:String, parameters:Array = null):String {
			var resource:Dictionary = messages[resourceName];
			if (resource == null) {
				throw new Error("LocaleManager.getString error : Has not installed the resource \"" + resourceName + "\"");
			}
			if (resource[name] == null) {
	            Log.getInstance().error("LocaleManager.getString error : Has Not installed the string. resourceName:" + resourceName + ", name:" + name);
	        }
	        
            var value:String = resource[name] || resourceName + "::" + name;
			if (parameters != null) {
				var i:int = 0;
				while (i < parameters.length) {
					value = value.replace(new RegExp("\\{" + i + "\\}", "g"), parameters[i]);
					i++;
				}
			}
			return value;
        }
    }
}
