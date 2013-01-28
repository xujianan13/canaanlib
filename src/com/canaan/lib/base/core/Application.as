package com.canaan.lib.base.core
{
	import com.canaan.lib.base.managers.ResourceManager;
	import com.canaan.lib.base.managers.StageManager;
	
	import flash.display.Sprite;

	public class Application
	{
		private static var callback:Method;
		private static var app:Sprite;
		
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
			var xml:XML = new XML(ResourceManager.getInstance().getContent(configPath));
			initializeConfig(xml);
			// initialize stage
			StageManager.getInstance().initialize(app.stage);
			// excute callback
			callback.apply();
		}
		
		private static function initializeConfig(xml:XML):void {
			Config.initialize(xml.config);
			Setting.initialize(xml.setting);
			Resources.initialize(xml.resources);
		}
	}
}