package com.canaan.lib.rpg.core.objects
{
	import com.canaan.lib.base.events.CEventDispatcher;
	import com.canaan.lib.base.interfaces.IRecyclable;
	import com.canaan.lib.rpg.core.model.objects.AbstractObjectVo;
	import com.canaan.lib.rpg.core.view.AbstractView;
	import com.canaan.lib.rpg.events.RPGEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	public class AbstractObject extends CEventDispatcher implements IRecyclable
	{
		protected var _view:AbstractView;
		protected var _vo:AbstractObjectVo;
		
		public function AbstractObject()
		{
			super();
			initializeView();
		}
		
		override public function dispatchEventWith(type:String, data:Object = null):void {
			if (hasEventListener(type)) {
				var event:RPGEvent = RPGEvent.fromPool(type, data);
				dispatchEvent(event);
				RPGEvent.toPool(event);
			}
		}
		
		public function reinitialize():void {
			_view.reinitialize();
			_vo = null;
		}

		override public function dispose():void {
			_view.dispose();
			_vo = null;
		}
		
		protected function initializeView():void {
			_view = new AbstractView();
		}
		
		public function move(x:Number, y:Number, speed:int = 4):void {
			
		}
		
		public function set vo(value:AbstractObjectVo):void {
			if (_vo != value) {
				_vo = value;
			}
		}
		
		public function get vo():AbstractObjectVo {
			return _vo;
		}
		
		public function get view():AbstractView {
			return _view;
		}
		
		public function get mapX():int {
			return _vo.mapX;
		}
		
		public function get mapY():int {
			return _vo.mapY;
		}
		
		public function getIntersect(point:Point, parent:DisplayObjectContainer = null):Boolean {
			return _view.getIntersect(point, parent);
		}
	}
}