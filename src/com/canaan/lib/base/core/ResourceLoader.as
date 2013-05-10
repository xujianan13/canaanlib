package com.canaan.lib.base.core
{
	import com.canaan.lib.base.debug.Log;
	import com.canaan.lib.base.managers.ResourceManager;
	import com.canaan.lib.base.utils.MathUtil;
	import com.canaan.lib.base.utils.ObjectUtil;
	
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.HTTPStatusEvent;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLLoaderDataFormat;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	public class ResourceLoader extends EventDispatcher
	{
		public static const FILE_TYPE_SWF:uint = 0;
		public static const FILE_TYPE_IMAGE:uint = 1;
		public static const FILE_TYPE_TEXT:uint = 2;
		public static const FILE_TYPE_BINARY:uint = 3;
		
		public static var SWF_EXTENSIONS:Array = ["swf"];
		public static var IMAGE_EXTENSIONS:Array = ["jpg", "jpeg", "gif", "png", "bmp"];
		public static var TEXT_EXTENSIONS:Array = ["txt", "xml", "csv"];
		public static var BINARY_EXTENSIONS:Array = ["byte"];
		
		private static var cache:Dictionary = new Dictionary();
		private var loader:Loader;
		private var urlRequest:URLRequest;
		private var urlLoader:URLLoader;
		private var loaderContext:LoaderContext;
		
		private var _url:String;
		private var _id:String;
		private var _fileType:uint;
		private var _completeHandler:Method;
		private var _progressHandler:Method;
		private var _bytesLoaded:int;
		private var _bytesTotal:int;
		
		public function ResourceLoader()
		{
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, onStatus);
			
			urlLoader = new URLLoader();
			urlLoader.addEventListener(ProgressEvent.PROGRESS, onProgress);
			urlLoader.addEventListener(Event.COMPLETE, onComplete);
			urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onError);
			urlLoader.addEventListener(HTTPStatusEvent.HTTP_STATUS, onStatus);
			urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onError);
			
			urlRequest = new URLRequest();
			loaderContext = new LoaderContext(false, ApplicationDomain.currentDomain);
			if (loaderContext.hasOwnProperty("imageDecodingPolicy")) {
				loaderContext["imageDecodingPolicy"] = "onLoad";
			}
		}
		
		public function load(url:String, id:String, completeHandler:Method, progressHandler:Method):void {
			loader.unloadAndStop();
			_url = url;
			_id = id;
			_fileType = getFileType(url);
			_completeHandler = completeHandler;
			_progressHandler = progressHandler;
			
			var content:* = getResource(_url);
			if (content != null) {
				return endLoad(content);
			}
			
			_bytesLoaded = 0;
			_bytesTotal = 0;
			startLoad();
		}
		
		private function endLoad(content:*):void {
			_completeHandler.applyWith([content]);
		}
		
		private function startLoad():void {
			urlRequest.url = ResourceManager.formatUrl(_url);
			switch (_fileType) {
				case FILE_TYPE_SWF:
				case FILE_TYPE_IMAGE:
					loader.load(urlRequest, loaderContext);
					break;
				case FILE_TYPE_TEXT:
					urlLoader.dataFormat = URLLoaderDataFormat.TEXT;
					urlLoader.load(urlRequest);
					break;
				case FILE_TYPE_BINARY:
					urlLoader.dataFormat = URLLoaderDataFormat.BINARY;
					urlLoader.load(urlRequest);
					break;
			}
		}
		
		public function get bytesLoaded():int {
			return _bytesLoaded;
		}
		
		public function get bytesTotal():int {
			return _bytesTotal;
		}
		
		public function get percentLoaded():Number {
			return MathUtil.floorFixed(bytesLoaded / bytesTotal, 2);
		}
		
		private function onComplete(event:Event):void {
			var content:*;
			switch (_fileType) {
				case FILE_TYPE_SWF:
					content = loader.content;
					break;
				case FILE_TYPE_IMAGE:
					content = Bitmap(loader.content).bitmapData;
					break;
				case FILE_TYPE_TEXT:
					content = urlLoader.data;
					break;
				case FILE_TYPE_BINARY:
					var bytes:ByteArray = urlLoader.data as ByteArray;
					bytes.uncompress();
					content = bytes;
					break;
			}
			endLoad(cache[_id] = content);
		}
		
		private function onProgress(event:ProgressEvent):void {
			_bytesTotal = event.bytesTotal;
			_bytesLoaded = event.bytesLoaded;
			_progressHandler.applyWith([percentLoaded]);
		}
		
		private function onError(event:Event):void {
			Log.getInstance().error("ResourceLoader Load Error:\"" + _url + "\"");
		}
		
		private function onStatus(event:HTTPStatusEvent):void {
			
		}
		
		public static function getFileType(url:String):uint {
			var index:int = url.indexOf("?");
			if (index != -1) {
				url = url.substring(0, index);
			}
			url = url.substring(url.lastIndexOf(".") + 1).toLowerCase();
			if (SWF_EXTENSIONS.indexOf(url) != -1) {
				return FILE_TYPE_SWF;
			} else if (IMAGE_EXTENSIONS.indexOf(url) != -1) {
				return FILE_TYPE_IMAGE;
			} else if (TEXT_EXTENSIONS.indexOf(url) != -1) {
				return FILE_TYPE_TEXT;
			} else if (BINARY_EXTENSIONS.indexOf(url) != -1) {
				return FILE_TYPE_BINARY;
			}
			Log.getInstance().error("ResourceLoader getFileType Error:Could not find fileType \"" + url + "\"");
			return FILE_TYPE_BINARY;
		}
		
		public static function hasResuorce(id:String):Boolean {
			return cache.hasOwnProperty(id);
		}
		
		public static function getResource(id:String):* {
			return cache[id];
		}
		
		public static function clearCache(id:String):void {
			delete cache[id];
		}
		
		public static function clearAllCache():void {
			ObjectUtil.dispose(cache);
		}
	}
}