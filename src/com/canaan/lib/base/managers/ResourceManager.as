package com.canaan.lib.base.managers
{
	import com.canaan.lib.base.core.Config;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.core.Methods;
	import com.canaan.lib.base.core.ResourceItem;
	import com.canaan.lib.base.core.ResourceLoader;
	import com.canaan.lib.base.debug.Log;
	import com.canaan.lib.base.events.CEventDispatcher;
	import com.canaan.lib.base.events.ResourceEvent;
	import com.canaan.lib.base.utils.DisplayUtil;
	import com.canaan.lib.base.utils.MathUtil;
	import com.canaan.lib.base.utils.ObjectUtil;
	
	import flash.display.BitmapData;
	import flash.system.ApplicationDomain;
	import flash.utils.Dictionary;

	[Event(name="startLoad", type="com.canaan.lib.base.events.ResourceEvent")]
	[Event(name="complete", type="com.canaan.lib.base.events.ResourceEvent")]
	[Event(name="progress", type="com.canaan.lib.base.events.ResourceEvent")]
	
	public class ResourceManager extends CEventDispatcher
	{
		private static var canInstantiate:Boolean;
		private static var instance:ResourceManager;
		
		private var bmdCache:Dictionary = new Dictionary();
		private var tileCache:Dictionary = new Dictionary();
		private var loadList:Vector.<ResourceItem> = new Vector.<ResourceItem>();
		private var loader:ResourceLoader = new ResourceLoader();
		private var completeHandlers:Methods = new Methods();
		private var progressHandlers:Methods = new Methods();
		private var _isLoading:Boolean;
		private var _itemsTotal:int;
		private var _itemsLoaded:int;
		private var _current:ResourceItem;
		
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
		
		public function add(url:String, id:String = "", name:String = "", completeHandler:Method = null, progressHandler:Method = null):void {
			var resourceItem:ResourceItem = new ResourceItem(url, id, name, completeHandler, progressHandler);
			addItem(resourceItem);
		}
		
		public function addItem(resourceItem:ResourceItem):void {
			loadList.push(resourceItem);
			_itemsTotal++;
		}
		
		public function addList(loadList:Vector.<ResourceItem>):void {
			for each (var resourceItem:ResourceItem in loadList) {
				addItem(resourceItem);
			}
		}
		
		public function load(completeHandler:Method = null, progressHandler:Method = null):void {
			if (completeHandler != null) {
				completeHandlers.registerMethod(completeHandler);
			}
			if (progressHandler != null) {
				progressHandlers.registerMethod(progressHandler);
			}
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
				content = ResourceLoader.getResource(resourceItem.id);
				if (content != null) {
					endLoad(resourceItem, content);
				} else {
					startLoad(resourceItem);
					return;
				}
			}
			_isLoading = false;
			_itemsTotal = 0;
			_itemsLoaded = 0;
			_current = null;
			if (hasEventListener(ResourceEvent.COMPLETE)) {
				dispatchEvent(new ResourceEvent(ResourceEvent.COMPLETE));
			}
			excuteComplete();
		}
		
		private function startLoad(resourceItem:ResourceItem):void {
			_current = resourceItem;
			loader.load(resourceItem.url, resourceItem.id, new Method(onComplete, [resourceItem]), new Method(onProgress, [resourceItem]));
		}
		
		private function endLoad(resourceItem:ResourceItem, content:*):void {
			var completeHandler:Method = resourceItem.completeHandler;
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
			var progressHandler:Method = resourceItem.progressHandler;
			if (progressHandler != null) {
				progressHandler.applyWith([percent]);
			}
			progressHandlers.apply();
			if (hasEventListener(ResourceEvent.PROGRESS)) {
				dispatchEvent(new ResourceEvent(ResourceEvent.PROGRESS));
			}
		}
		
		private function excuteProgress():void {
			var methods:Methods = progressHandlers.clone();
			progressHandlers.clear();
			methods.apply();
		}
		
		private function excuteComplete():void {
			var methods:Methods = completeHandlers.clone();
			completeHandlers.clear();
			methods.apply();
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
		
		public function get current():ResourceItem {
			return _current;
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
		
		public function hasContent(id:String):Boolean {
			return ResourceLoader.hasResuorce(id);
		}
		
		public function getContent(id:String):* {
			return ResourceLoader.getResource(id);
		}
		
		public function removeContent(id:String):void {
			ResourceLoader.clearCache(id);
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
		
		public function getTiles(name:String, x:int, y:int, cache:Boolean = true):Vector.<BitmapData> {
			var tiles:Vector.<BitmapData> = tileCache[name];
			if (tiles == null) {
				var bmd:BitmapData = getBitmapData(name);
				if (bmd == null) {
					return null;
				}
				tiles = DisplayUtil.createTiles(bmd, x, y);
				if (cache) {
					tileCache[name] = tiles;
				}
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
				var resHost:String = Config.getConfig("resHost");
				if (resHost != null) {
					url = resHost + url;
				}
			}
			if (url.indexOf("version") == -1) {
				var version:String = Config.getConfig("version");
				if (version != null) {
					url += "?version=" + version;
				}
			}
			return url;
		}
	}
}