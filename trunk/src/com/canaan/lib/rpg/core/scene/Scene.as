package com.canaan.lib.rpg.core.scene
{
	import com.canaan.lib.base.astar.AStar;
	import com.canaan.lib.base.managers.StageManager;
	import com.canaan.lib.rpg.core.RPGSetting;
	import com.canaan.lib.rpg.core.camera.Camera;
	import com.canaan.lib.rpg.core.layers.BackgroundLayer;
	import com.canaan.lib.rpg.core.layers.EffectLayer;
	import com.canaan.lib.rpg.core.layers.ObjectsLayer;
	import com.canaan.lib.rpg.core.map.Map;
	import com.canaan.lib.rpg.core.model.map.MapVo;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;

	public class Scene
	{
		protected var astar:AStar;
		protected var map:Map;
		protected var camera:Camera;
		protected var container:DisplayObjectContainer;
		protected var backgroundLayer:BackgroundLayer;
		protected var objectsLayer:ObjectsLayer;
		protected var effectLayer:EffectLayer;
		
		public function Scene(container:DisplayObjectContainer)
		{
			this.container = container;
			initialize();
		}
		
		protected function initialize():void {
			astar = new AStar(RPGSetting.gridType);
			map = new Map();
			camera = new Camera();
			camera.initialize(map);

			backgroundLayer = new BackgroundLayer();
			objectsLayer = new ObjectsLayer();
			effectLayer = new EffectLayer();
			
			container.addChild(backgroundLayer);
			container.addChild(map.drawBuffer);
			container.addChild(objectsLayer);
			container.addChild(effectLayer);
			
			StageManager.getInstance().registerHandler(Event.RESIZE, onResize);
		}
		
		public function initializeMap(mapVo:MapVo):void {
			map.initialize(mapVo);
		}
		
		protected function onResize():void {
			map.changeMapSize(StageManager.getInstance().stage.stageWidth, StageManager.getInstance().stage.stageHeight);
		}
	}
}