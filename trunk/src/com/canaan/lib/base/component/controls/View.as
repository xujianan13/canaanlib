package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.ViewCreater;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.core.Resources;
	import com.canaan.lib.base.events.UIEvent;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.utils.Dictionary;
	
	[Event(name="viewCreated", type="com.canaan.lib.base.events.UIEvent")]
	
	public class View extends Container
	{
		public static var xmlMap:Dictionary = new Dictionary();
		
		public function View()
		{
			super();
		}
		
		public function createView(xml:XML):void {
			ViewCreater.createView(this, xml);
			sendEvent(UIEvent.VIEW_CREATED);
		}
		
		public function loadUI(path:String):void {
			var xml:XML = xmlMap[path];
			if (xml != null) {
				createView(xml);
			} else {
				var url:String = Resources.dirUIXml + path;
				ResourceManager.getInstance().add(url, "", new Method(loadUIComplete, [path]));
				ResourceManager.getInstance().load();
			}
		}
		
		protected function loadUIComplete(path:String, content:*):void {
			var xml:XML = new XML(content);
			xmlMap[path] = xml;
			createView(xml);
		}
	}
}