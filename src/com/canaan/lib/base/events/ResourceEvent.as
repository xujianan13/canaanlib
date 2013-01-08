package com.canaan.lib.base.events
{
	public class ResourceEvent extends CEvent
	{
		public static const START_LOAD:String = "startLoad";
		public static const COMPLETE:String = "complete";
		public static const PROGRESS:String = "progress";
		
		public function ResourceEvent(type:String)
		{
			super(type);
		}
	}
}