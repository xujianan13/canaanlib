package com.canaan.lib.base.managers
{
	import com.canaan.lib.base.core.GameSetting;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.core.ResourceItem;
	import com.canaan.lib.base.core.ResourceLoader;
	import com.canaan.lib.base.debug.Log;
	import com.canaan.lib.base.events.ResourceEvent;
	import com.canaan.lib.base.utils.DisplayUtil;
	import com.canaan.lib.base.utils.MathUtil;
	import com.canaan.lib.base.utils.ObjectUtil;
	
	import flash.display.BitmapData;
	import flash.events.EventDispatcher;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;

	[Event(name="startLoad", type="com.canaan.lib.base.events.ResourceEvent")]
	[Event(name="complete", type="com.canaan.lib.base.events.ResourceEvent")]
	[Event(name="progress", type="com.canaan.lib.base.events.ResourceEvent")]
	
	public class ResourceManager extends EventDispatcher
	{
		private static var canInstantiate:Boolean;
		private static var instance:ResourceManager;
		
		private var bmdCache:Dictionary = new Dictionary();
		private var tileCache:Dictionary = new Dictionary();
		private var loadList:Array = [];
		private var loader:ResourceLoader = new ResourceLoader();
		private var _isLoading:Boolean;
		private var _itemsTotal:int;
		private var _itemsLoaded:int;
		
		public function ResourceManager()
		{
			if (!canInstantiate) {
				throw new Error("Can not instantiate, use getInstance() instead.");
			}
		}
		
		public static function getInstance():ResourceManager {
			if (instance == null) {
				canInstantiate = true;
				instance = new ResourceManager();
				canInstantiate = false;
			}
			return instance;
		}
		
		public function add(url:String, completeHandler:MethodElement = null, progressHandler:MethodElement = null):void {
			url = formatUrl(url);
			var resourceItem:ResourceItem = new ResourceItem(url, completeHandler, progressHandler);
			loadList.push(resourceItem);
			_itemsTotal++;
		}
		
		public function load():void {
			if (_isLoading) {
				return;
			}
			_isLoading = true;
			dispatchEvent(new ResourceEvent(ResourceEvent.START_LOAD));
			loadNext();
		}
		
		private function loadNext():void {
			var resourceItem:ResourceItem;
			var content:*;
			while (loadList.length > 0) {
				resourceItem = loadList.shift();
				content = ResourceLoader.getResource(resourceItem.url);
				if (content != null) {
					endLoad(resourceItem, content);
				} else {
					startLoad(resourceItem);
					return;
				}
			}
			if (hasEventListener(ResourceEvent.COMPLETE)) {
				dispatchEvent(new ResourceEvent(ResourceEvent.COMPLETE));
			}
			_isLoading = false;
			_itemsTotal = 0;
			_itemsLoaded = 0;
		}
		
		private function startLoad(resourceItem:ResourceItem):void {
			loader.load(resourceItem.url, new MethodElement(onComplete, [resourceItem]), new MethodElement(onProgress, [resourceItem]));
		}
		
		private function endLoad(resourceItem:ResourceItem, content:*):void {
			var completeHandler:MethodElement = resourceItem.completeHandler;
			if (completeHandler != null) {
				completeHandler.applyWith([content]);
			}
			_itemsLoaded++;
		}
		
		private function onComplete(resourceItem:ResourceItem, content:*):void {
			endLoad(resourceItem, content);
			loadNext();
		}
		
		private function onProgress(resourceItem:ResourceItem, percent:Number):void {
			var progressHandler:MethodElement = resourceItem.progressHandler;
			if (progressHandler != null) {
				progressHandler.applyWith([percent]);
			}
			if (hasEventListener(ResourceEvent.PROGRESS)) {
				dispatchEvent(new ResourceEvent(ResourceEvent.PROGRESS));
			}
		}
		
		public function get isLoading():Boolean {
			return _isLoading;
		}
		
		public function get itemsTotal():int {
			return _itemsTotal;
		}
		
		public function get itemsLoaded():int {
			return _itemsLoaded;
		}
		
		public function get percentLoaded():Number {
			return MathUtil.floorFixed(_itemsLoaded / _itemsTotal, 2);
		}
		
		public function get bytesLoadedCurrent():int {
			return loader.bytesLoaded;
		}
		
		public function get bytesTotalCurrent():int {
			return loader.bytesTotal;
		}
		
		public function get percentCurrent():Number {
			return loader.percentLoaded;
		}
		
		public function hasClass(name:String):Boolean {
			return ApplicationDomain.currentDomain.hasDefinition(name);
		}
		
		public function getClass(name:String):Class {
			if (hasClass(name)) {
				return ApplicationDomain.currentDomain.getDefinition(name) as Class;
			}
			Log.getInstance().error("ResourceMananger getClass error: Class \"" + name + "\" is not found!");
			return null;
		}
		
		public function getContent(url:String):* {
			return ResourceLoader.getResource(url);
		}
		
		public function getNewInstance(name:String):* {
			var clazz:Class = getClass(name);
			if (clazz != null) {
				return new clazz();
			}
			return null;
		}
		
		public function getBitmapData(name:String):BitmapData {
			var bmd:BitmapData = bmdCache[name];
			if (bmd == null) {
				var bmdClass:Class = getClass(name);
				if (bmdClass == null) {
					return null;
				}
				bmd = new bmdClass(0, 0);
				bmdCache[name] = bmd;
			}
			return bmd;
		}
		
		public function getTiles(name:String, x:int, y:int):Array {
			var tiles:Array = tileCache[name];
			if (tiles == null) {
				var bmd:BitmapData = getBitmapData(name);
				if (bmd == null) {
					return null;
				}
				tiles = DisplayUtil.createTiles(bmd, x, y);
				tileCache[name] = tiles;
			}
			return tiles;
		}
		
		public function clearBmdCache():void {
			ObjectUtil.dispose(bmdCache);
		}
		
		public function clearTileCache():void {
			ObjectUtil.dispose(tileCache);
		}
		
		public static function formatUrl(url:String):String {
			if (url.indexOf("http") == -1) {
				url = GameSetting.assetHost + url;
			}
			if (url.indexOf("version") == -1) {
				url += "?version=" + GameSetting.version;
			}
			return url;
		}
	}
}