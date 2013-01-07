package com.canaan.lib.base.managers
{
	import com.canaan.lib.base.core.Config;
	import com.canaan.lib.base.core.Methods;
	import com.canaan.lib.base.core.Setting;
	
	import flash.display.LoaderInfo;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class StageManager
	{
		private static var canInstantiate:Boolean;
		private static var instance:StageManager;
		
		public var stage:Stage;
		public var mouseClickMethods:Methods;
		public var mouseDownMethods:Methods;
		public var mouseUpMethods:Methods;
		public var mouseMoveMethods:Methods;
		public var resizeMethods:Methods;
		
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
			stage.stageFocusRect = false;
			
			setFlashVars();
			stage.frameRate = Setting.fps;
			
			mouseClickMethods = new Methods();
			mouseDownMethods = new Methods();
			mouseUpMethods = new Methods();
			mouseMoveMethods = new Methods();
			resizeMethods = new Methods();
			
			stage.addEventListener(MouseEvent.CLICK, mouseEvent);
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mouseEvent);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseEvent);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, mouseEvent);
			stage.addEventListener(Event.RESIZE, eventHandler);
		}
		
		private function setFlashVars():void {
			var loaderInfo:LoaderInfo = stage.loaderInfo;
			var flashVars:Object = loaderInfo.parameters;
			if (flashVars != null) {
				for (var key:String in flashVars) {
					Config.setConfig(key, flashVars[key]);
				}
			}
		}
		
		private function mouseEvent(event:MouseEvent):void {
			switch (event.type) {
				case MouseEvent.CLICK:
					mouseClickMethods.apply();
					break;
				case MouseEvent.MOUSE_DOWN:
					mouseDownMethods.apply();
					break;
				case MouseEvent.MOUSE_UP:
					mouseUpMethods.apply();
					break;
				case MouseEvent.MOUSE_MOVE:
					mouseMoveMethods.apply();
					break;
			}
		}
		
		private function eventHandler(event:Event):void {
			switch (event.type) {
				case Event.RESIZE:
					resizeMethods.apply();
					break;
			}
		}
	}
}