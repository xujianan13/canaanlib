package com.canaan.lib.base.core
{
	import com.canaan.lib.base.managers.ResourceManager;
	import com.canaan.lib.base.managers.StageManager;
	
	import flash.display.Sprite;
	
	public class Application
	{
		public static var app:Sprite;
		public static var config:XML;
		private static var callback:Method;
		
		public function Application()
		{
			throw new Error("Application can not be initialize!");
		}
		
		public static function initialize(app:Sprite, callback:Method):void {
			Application.app = app;
			Application.callback = callback;
			loadConfig();
		}
		
		private static function loadConfig():void {
			var configPath:String = "config.xml?" + Math.random();
			ResourceManager.getInstance().add(configPath);
			ResourceManager.getInstance().load(new Method(onConfigComplete, [configPath]));
		}
		
		private static function onConfigComplete(configPath:String):void {
			// initialize config
			config = new XML(ResourceManager.getInstance().getContent(configPath));
			initializeConfig();
			// initialize stage
			StageManager.getInstance().initialize(app.stage);
			// excute callback
			callback.apply();
		}
		
		private static function initializeConfig():void {
			Resources.initialize(config.resources);
			Setting.initialize(config.setting);
		}
	}
}