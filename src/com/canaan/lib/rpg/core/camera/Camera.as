package com.canaan.lib.rpg.core.camera
{
	import com.canaan.lib.base.animation.Tween;
	import com.canaan.lib.rpg.core.map.Map;
	import com.canaan.lib.rpg.core.objects.AbstractObject;
	import com.canaan.lib.rpg.events.RPGEvent;

	public class Camera
	{
		protected var target:AbstractObject;
		protected var map:Map;
		protected var tween:Tween;
		
		public function Camera()
		{
		}
		
		public function initialize(map:Map):void {
			this.map = map;
		}
		
		public function focus(object:AbstractObject):void {
			if (target != object) {
				target = object;
				clearTarget();
				target.addEventListener(RPGEvent.OBJECT_MOVE, onObjectMove);
			}
		}
		
		protected function onObjectMove():void {
			if (tween && tween.running)
				return;
			map.moveTo(target.mapX, target.mapY);
		}
		
		protected function moveMap(time:Number):void {
			if (tween != null) {
				Tween.toPool(tween);
				tween = Tween.fromPool(map, time);
				tween.onUpdate = updateMapPosition();
				tween.start();
			}
		}
		
		protected function updateMapPosition():void {
			
		}
		
		protected function clearTarget():void {
			if (target) {
				target.removeEventListener(RPGEvent.OBJECT_MOVE, onObjectMove);
				target = null;
			}
		}
	}
}