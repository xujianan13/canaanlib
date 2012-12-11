package com.canaan.lib.base.events
{
	import flash.events.Event;

	public class KeyEvent extends Event
	{
		public static const KEY_DOWN:String = "keyDown";
		public static const KEY_UP:String = "keyUp";
		public static const KEY_DOWN_CTRL:String = "keyDownCtrl";
		public static const KEY_UP_CTRL:String = "keyUpCtrl";
		public static const KEY_DOWN_SHIFT:String = "keyDownShift";
		public static const KEY_UP_SHIFT:String = "keyUpShift";
		public static const KEY_DOWN_CTRL_SHIFT:String = "keyDownCtrlShift";
		public static const KEY_UP_CTRL_SHIFT:String = "keyUpCtrlShift";
		
		public var keyCode:uint;
		public var charCode:uint;
		public var keyLocation:uint;
		public var ctrlKey:Boolean;
		public var shiftKey:Boolean;
		public var altKey:Boolean;
		
		public function KeyEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}