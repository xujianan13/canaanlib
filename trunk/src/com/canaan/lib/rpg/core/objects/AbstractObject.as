package com.canaan.lib.rpg.core.objects
{
	import com.canaan.lib.base.events.CEventDispatcher;
	import com.canaan.lib.base.interfaces.IRecyclable;
	import com.canaan.lib.rpg.core.model.action.ActionVo;
	import com.canaan.lib.rpg.core.model.objects.AbstractObjectVo;
	import com.canaan.lib.rpg.core.view.AbstractView;
	import com.canaan.lib.rpg.events.RPGEvent;
	
	import flash.display.DisplayObjectContainer;
	import flash.geom.Point;

	public class AbstractObject extends CEventDispatcher implements IRecyclable
	{
		protected var _view:AbstractView;
		protected var _vo:AbstractObjectVo;
		protected var _mapX:int;
		protected var _mapY:int;
		
		public function AbstractObject(vo:AbstractObjectVo)
		{
			super();
			_vo = vo;
			_mapX = vo.mapX;
			_mapY = vo.mapY;
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
			_mapX = 0;
			_mapY = 0;
		}

		override public function dispose():void {
			_view.dispose();
			_vo = null;
		}
		
		protected function initializeView():void {
			_view = new AbstractView();
		}

		protected function updatePosition():void {
			_vo.mapX = _mapX;
			_vo.mapY = _mapY;
		}
		
		public function move(x:Number, y:Number, speed:int = 4):void {
			
		}
		
		public function moveToMap(mapX:Number, mapY:Number):void {
			_mapX = mapX;
			_mapY = mapY;
			updatePosition();
		}
		
		public function get vo():ActionVo {
			return _vo;
		}
		
		public function get view():AbstractView {
			return _view;
		}
		
		public function get mapX():int {
			return _mapX;
		}
		
		public function get mapY():int {
			return _mapY;
		}
		
		public function getIntersect(point:Point, parent:DisplayObjectContainer = null):Boolean {
			return _view.getIntersect(point, parent);
		}
	}
}