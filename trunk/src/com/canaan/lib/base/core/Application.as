package com.canaan.lib.base.core
{
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;

	public class Application
	{
		public static var stage:Stage;

		public function Application()
		{
			throw new Error("Application can not be initialize!");
		}
		
		public static function initialize(app:Sprite):void {
			stage = app.stage;
			
			if (stage != null) {
				stage.align = StageAlign.TOP_LEFT;
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.stageFocusRect = false;
				
				// set flashvars
				var loaderInfo:LoaderInfo = stage.loaderInfo;
				var flashVars:Object = loaderInfo.parameters;
				if (flashVars != null) {
					for (var key:String in flashVars) {
						Config.setConfig(key, flashVars[key]);
					}
				}
				
				// initial
				stage.frameRate = GameSetting.fps;
			}
		}
	}
}