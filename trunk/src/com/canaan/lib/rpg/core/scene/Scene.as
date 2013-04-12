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
	import com.canaan.lib.rpg.core.model.objects.AbstractObjectVo;
	import com.canaan.lib.rpg.core.objects.AbstractObject;
	import com.canaan.lib.rpg.core.objects.ObjectCreater;
	
	import flash.display.DisplayObjectContainer;
	import flash.events.Event;
	import flash.utils.Dictionary;

	public class Scene
	{
		protected var astar:AStar;
		protected var map:Map;
		protected var camera:Camera;
		protected var container:DisplayObjectContainer;
		protected var backgroundLayer:BackgroundLayer;
		protected var objectsLayer:ObjectsLayer;
		protected var effectLayer:EffectLayer;
		
		protected var objectsDict:Dictionary;
		protected var objectsList:Vector.<AbstractObject>;
		
		public function Scene(container:DisplayObjectContainer)
		{
			this.container = container;
			initialize();
		}
		
		protected function initialize():void {
			objectsDict = new Dictionary();
			objectsList = new Vector.<AbstractObject>();
			
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
		
		protected function onResize():void {
			map.changeMapSize(StageManager.getInstance().stage.stageWidth, StageManager.getInstance().stage.stageHeight);
		}
		
		/**
		 * 显示对象排序
		 * 
		 */		
		protected function sortObjectDepth():void {
			objectsList.sort(sortObjectDepthFunc);
			var index:int;
			for each (var object:AbstractObject in objectsList) {
				objectsLayer.setChildIndex(object.view, index);
				index++;
			}
		}
		
		protected function sortObjectDepthFunc(objectA:AbstractObject, objectB:AbstractObject):int {
			return objectA.view.y > objectB.view.y ? 1 : -1;
		}
		
		/**
		 * 初始化地图
		 * @param mapVo
		 * 
		 */		
		public function initializeMap(mapVo:MapVo):void {
			map.initialize(mapVo);
		}
		
		/**
		 * 添加显示对象
		 * @param objectVo
		 * 
		 */		
		public function addObject(objectVo:AbstractObjectVo):void {
			var object:AbstractObject = ObjectCreater.createObject(objectVo);
			objectsDict[objectVo.id] = object;
			objectsList.push(object);
			objectsLayer.addChild(object.view);
			sortObjectDepth();
		}
	}
}