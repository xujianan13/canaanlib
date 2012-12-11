package com.canaan.lib.base.events
{
	import flash.events.Event;

	public class ResourceEvent extends Event
	{
		public static const START_LOAD:String = "startLoad";
		public static const COMPLETE:String = "complete";
		public static const PROGRESS:String = "progress";
		
		public function ResourceEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
	}
}