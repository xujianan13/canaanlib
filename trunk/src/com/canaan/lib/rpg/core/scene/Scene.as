package com.canaan.lib.rpg.core.scene
{
	import com.canaan.lib.base.astar.AStar;
	import com.canaan.lib.rpg.core.map.Map;
	
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

	public class Scene
	{
		protected var astar:AStar;
		protected var map:Map;
		protected var objects:Array;
		protected var renderList:Array;
		protected var container:DisplayObjectContainer;
		protected var backgroundLayer:Sprite;
		protected var objectsLayer:Sprite;
		protected var effectLayer:Sprite;
		
		public function Scene(container:DisplayObjectContainer)
		{
			this.container = container;
			initialize();
		}
		
		protected function initialize():void {
			astar = new AStar();
			map = new Map();
			objects = [];
			renderList = [];
			
			backgroundLayer = new Sprite();
			objectsLayer = new Sprite();
			effectLayer = new Sprite();
			container.addChild(backgroundLayer);
			container.addChild(objectsLayer);
			container.addChild(effectLayer);
		}
	}
}