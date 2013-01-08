package com.canaan.lib.base.events
{
	public class UIEvent extends CEvent
	{
		public static const RENDER_COMPLETED:String = "renderCompleted";
		public static const RESIZE:String = "resize";
		public static const COMPLETE:String = "complete";
		public static const ANIMATION_COMPLETE:String = "animationComplete";
		public static const VIEW_CREATED:String = "viewCreated";
		public static const CHANGE:String = "change";
		public static const TOOL_TIP_CHANGED:String = "toolTipChanged";
		public static const TOOL_TIP_START:String = "toolTipStart";
		public static const TOOL_TIP_SHOW:String = "toolTipShow";
		public static const TOOL_TIP_HIDE:String = "toolTipHide";
		
		private static var eventPool:Vector.<UIEvent> = new <UIEvent>[];

		public function UIEvent(type:String, data:Object = null)
		{
			super(type, data);
		}
		
		public static function fromPool(type:String, data:Object = null):UIEvent {
			if (eventPool.length != 0) {
				return eventPool.pop().reset(type, data);
			} else {
				return new UIEvent(type, data);
			}
		}
		
		public static function toPool(event:UIEvent):void {
			eventPool.push(event.reset());
		}
	}
}