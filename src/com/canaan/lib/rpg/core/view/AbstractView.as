package com.canaan.lib.rpg.core.view
{
	import com.canaan.lib.base.display.BaseSprite;
	import com.canaan.lib.base.display.BitmapDataEx;
	import com.canaan.lib.base.display.BitmapMovieClip;
	import com.canaan.lib.base.interfaces.IRecyclable;
	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;
	
	public class AbstractView extends BaseSprite implements IRecyclable
	{
		protected var _skin:BitmapMovieClip;
		
		public function AbstractView()
		{
			super();
		}
		
		protected function initialize():void {
			_skin = new BitmapMovieClip();
			addChild(_skin);
		}
		
		public function reinitialize():void {
			_skin.reinitialize();
		}
		
		override public function dispose():void {
			super.dispose();
			_skin.dispose();
		}
		
		public function setDefaultSkin(value:BitmapDataEx):void {
			_skin.bitmapDataEx = value;
		}
		
		public function getIntersect(point:Point, parent:DisplayObjectContainer = null):Boolean {
			return _skin.getIntersect(point, parent);
		}
	}
}