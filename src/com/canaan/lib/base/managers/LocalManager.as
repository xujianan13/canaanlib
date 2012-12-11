package com.canaan.lib.base.managers
{
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
        
        public function loadResources(value:String):void {
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
                    messages[mKey] = rtrim;
                } 
            }
        }
        
        public function getString(name:String, parameters:Array = null):String {
			if (messages[name] == null) {
	            throw(new Error("not installed " + name));
	        }
	        
            var value:String = messages[name];
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
