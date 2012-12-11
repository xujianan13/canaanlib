package com.canaan.lib.base.display
{
	import com.canaan.lib.base.utils.DisplayUtil;
	
	import flash.display.Sprite;
	
	public class BaseSprite extends Sprite
	{
		public function BaseSprite()
		{
			super();
		}
		
		public function center(offsetX:Number = 0, offsetY:Number = 0):void {
			DisplayUtil.center(this, offsetX, offsetY);
		}
		
		public function moveTo(x:Number, y:Number):void {
			this.x = x;
			this.y = y;
		}
		
		public function setSize(width:Number, height:Number):void {
			this.width = width;
			this.height = height;
		}
		
		public function setScale(scaleX:Number, scaleY:Number = NaN):void {
			this.scaleX = scaleX;
			this.scaleY = scaleY || scaleX;
		}
		
		public function remove():void {
			DisplayUtil.removeChild(parent, this);
		}
		
		public function removeAllChildren():void {
			DisplayUtil.removeAllChildren(this);
		}
		
		public function dispose():void {
			DisplayUtil.removeAllChildren(this, true);
			remove();
			graphics.clear();
		}
	}
}