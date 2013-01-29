package com.canaan.lib.base.managers
{
	import com.canaan.lib.base.core.Methods;
	
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class StageManager
	{
		private static var canInstantiate:Boolean;
		private static var instance:StageManager;
		
		public var stage:Stage;
		
		private var methodsDict:Dictionary = new Dictionary();

		public function StageManager()
		{
			if (!canInstantiate) {
				throw new Error("Can not instantiate, use getInstance() instead.");
			}
		}
		
		public static function getInstance():StageManager {
			if (instance == null) {
				canInstantiate = true;
				instance = new StageManager();
				canInstantiate = false;
			}
			return instance;
		}
		
		public function initialize(value:Stage):void {
			if (!value) {
				return;
			}
			stage = value;
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.tabChildren = false;
			stage.stageFocusRect = false;
		}

		public function registerHandler(type:String, func:Function, args:Array = null):void {
			var methods:Methods = methodsDict[type];
			if (!methods) {
				methods = new Methods();
				methodsDict[type] = methods;
				stage.addEventListener(type, eventHandler);
			}
			methods.register(func, args);
		}
		
		public function deleteHandler(type:String, func:Function):void {
			var methods:Methods = methodsDict[type];
			if (methods) {
				methods.del(func);
				if (methods.length == 0) {
					delete methodsDict[type];
					stage.removeEventListener(type, eventHandler);
				}
			}
		}
		
		private function eventHandler(event:Event):void {
			var methods:Methods = methodsDict[event.type];
			if (methods) {
				methods.apply();
			}
		}
	}
}