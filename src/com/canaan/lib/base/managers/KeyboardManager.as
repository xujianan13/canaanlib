package com.canaan.lib.base.managers
{
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.events.KeyEvent;
	
	import flash.events.EventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;

	[Event(name="keyDown", type="com.canaan.lib.base.events.KeyEvent")]
	[Event(name="keyUp", type="com.canaan.lib.base.events.KeyEvent")]
	[Event(name="keyDownCtrl", type="com.canaan.lib.base.events.KeyEvent")]
	[Event(name="keyUpCtrl", type="com.canaan.lib.base.events.KeyEvent")]
	[Event(name="keyDownShift", type="com.canaan.lib.base.events.KeyEvent")]
	[Event(name="keyUpShift", type="com.canaan.lib.base.events.KeyEvent")]
	[Event(name="keyDownCtrlShift", type="com.canaan.lib.base.events.KeyEvent")]
	[Event(name="keyUpCtrlShift", type="com.canaan.lib.base.events.KeyEvent")]
	
	public class KeyboardManager extends EventDispatcher
	{
		public static const CTRL:String = "Ctrl";
		public static const SHIFT:String = "Shift";
		
		private static var canInstantiate:Boolean;
		private static var instance:KeyboardManager;
		
		private var _enabled:Boolean = false;
		
		public function KeyboardManager()
		{
			if (!canInstantiate) {
				throw new Error("Can not instantiate, use getInstance() instead.");
			}
		}
		
		public static function getInstance():KeyboardManager {
			if (instance == null) {
				canInstantiate = true;
				instance = new KeyboardManager();
				canInstantiate = false;
			}
			return instance;
		}
		
		private function keyChangeHandler(event:KeyboardEvent):void {
			var eventType:String = event.type;
			dispatch(eventType, event);
			
			var ctrlKey:Boolean = event.ctrlKey && event.keyCode != Keyboard.CONTROL;
			if (ctrlKey) {
				dispatch(eventType + CTRL, event);
			}
			
			var shiftKey:Boolean = event.shiftKey && event.keyCode != Keyboard.SHIFT;
			if (shiftKey) {
				dispatch(eventType + SHIFT, event);
			}
			
			if (ctrlKey && shiftKey) {
				dispatch(eventType + CTRL + SHIFT, event);
			}
		}

		private function dispatch(type:String, keyBoardEvent:KeyboardEvent):void {
			var event:KeyEvent = new KeyEvent(type);
			event.keyCode = keyBoardEvent.keyCode;
			event.charCode = keyBoardEvent.charCode;
			event.keyLocation = keyBoardEvent.keyLocation;
			event.ctrlKey = keyBoardEvent.ctrlKey;
			event.shiftKey = keyBoardEvent.shiftKey;
			event.altKey = keyBoardEvent.altKey;
			dispatchEvent(event);
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = value;
				if (value) {
					Application.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyChangeHandler);
					Application.stage.addEventListener(KeyboardEvent.KEY_UP, keyChangeHandler);
				} else {
					Application.stage.removeEventListener(KeyboardEvent.KEY_DOWN, keyChangeHandler);
					Application.stage.removeEventListener(KeyboardEvent.KEY_UP, keyChangeHandler);
				}
			}
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
	}
}