package com.canaan.lib.base.events
{
	import flash.events.Event;
	
	public class UIEvent extends Event
	{
		public static const RENDER_COMPLETE:String = "renderComplete";
		public static const RESIZE:String = "resize";
		public static const COMPLETE:String = "complete";
		public static const ANIMATION_COMPLETE:String = "animationComplete";
		public static const VIEW_CREATED:String = "viewCreated";
		public static const CHANGE:String = "change";
		
		protected var _data:Object;
		
		public function UIEvent(type:String, data:Object = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			_data = data;
		}
		
		public function set data(value:Object):void {
			_data = value;
		}
		
		public function get data():Object {
			return _data;
		}
		
		override public function clone():Event {
			return new UIEvent(type, _data, bubbles, cancelable);
		}
	}
}