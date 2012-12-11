package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.ViewCreater;
	import com.canaan.lib.base.events.UIEvent;
	
	public class View extends Container
	{
		public function View()
		{
			super();
		}
		
		public function createView(xml:XML):void {
			ViewCreater.createView(this, xml);
			sendEvent(UIEvent.VIEW_CREATED);
		}
	}
}