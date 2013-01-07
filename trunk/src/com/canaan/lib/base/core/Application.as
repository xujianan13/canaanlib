package com.canaan.lib.base.core
{
	import com.canaan.lib.base.managers.StageManager;
	
	import flash.display.Sprite;

	public class Application
	{
		public function Application()
		{
			throw new Error("Application can not be initialize!");
		}
		
		public static function initialize(app:Sprite):void {
			StageManager.getInstance().initialize(app.stage);
		}
	}
}