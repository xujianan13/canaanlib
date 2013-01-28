package testPackage.managers
{
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.events.ResourceEvent;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	public class TestResourceManager extends Sprite
	{
		private var complete:Method;
		private var progress:Method;
		
		public function TestResourceManager()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			ResourceManager.getInstance().addEventListener(ResourceEvent.START_LOAD, startLoadHandler);
			ResourceManager.getInstance().addEventListener(ResourceEvent.COMPLETE, completeHandler);
			ResourceManager.getInstance().addEventListener(ResourceEvent.PROGRESS, progressHandler);
			complete = new Method(onComplete);
			progress = new Method(onProgress);
			ResourceManager.getInstance().add("assets/bear.swf");
			ResourceManager.getInstance().add("assets/Altar.png");
			ResourceManager.getInstance().add("assets/items.xml");
			ResourceManager.getInstance().add("assets/tooltip.swf");
			ResourceManager.getInstance().load(complete, progress);
		}
		
		private function onComplete():void {
			var mc:MovieClip = ResourceManager.getInstance().getNewInstance("Tooltip");
			addChild(mc);
			
			var mc2:* = new Bitmap(ResourceManager.getInstance().getContent("assets/Altar.png"));
			addChild(mc2);
			
//			trace(ResourceManager.getInstance().getContent("assets/items.xml"));
		}
		
		private function onProgress():void {
			trace(ResourceManager.getInstance().percentLoaded);
		}
		
		private function startLoadHandler(event:ResourceEvent):void {
			trace("startLoadHandler");
		}
		
		private function completeHandler(event:ResourceEvent):void {
			trace("completeHandler");
		}
		
		private function progressHandler(event:ResourceEvent):void {
			trace("current loaded:" + ResourceManager.getInstance().bytesLoadedCurrent + "/" + ResourceManager.getInstance().bytesTotalCurrent);
			trace("items loaded:" + ResourceManager.getInstance().itemsLoaded + "/" + ResourceManager.getInstance().itemsTotal);
		}
	}
}