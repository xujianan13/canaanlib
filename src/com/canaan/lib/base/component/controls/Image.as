package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.component.UIComponent;
	import com.canaan.lib.base.core.DLoader;
	import com.canaan.lib.base.events.UIEvent;
	import com.canaan.lib.base.managers.ResourceManager;
	import com.canaan.lib.base.utils.ArrayUtil;
	import com.canaan.lib.base.utils.DisplayUtil;
	import com.canaan.lib.base.utils.ObjectUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	
	[Event(name="complete", type="com.canaan.lib.base.events.UIEvent")]
	
	public class Image extends UIComponent
	{
		public static var cache:Dictionary = new Dictionary(true);

		protected var _bitmap:Bitmap;
		protected var _url:String;
		protected var _scale9:Array;
		
		public function Image(url:String = null)
		{
			this.url = url;
		}
		
		override protected function createChildren():void {
			_bitmap = new Bitmap();
			addChild(_bitmap);
		}
		
		public function set url(value:String):void {
			removeCache();
			if (_url != value) {
				_url = value;
				if (_url) {
					if (ResourceManager.getInstance().hasClass(_url)) {
						setBitmapData(ResourceManager.getInstance().getBitmapData(_url));
					} else {
						var fullUrl:String = ResourceManager.formatUrl(_url);
						var obj:* = cache[_url];
						if (obj != null) {
							if (obj is BitmapData) {
								setBitmapData(obj);
							} else {
								obj.push(this);
							}
						} else {
							cache[_url] = new <Image>[this];
							var loader:DLoader = DLoader.fromPool();
							loader.contentLoaderInfo.addEventListener(Event.COMPLETE, completeHandler);
							loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
							loader.data = _url;
							loader.load(new URLRequest(_url));
						}
					}
				} else {
					setBitmapData(null);
				}
			}
		}
		
		public function get url():String {
			return _url;
		}

		protected function setBitmapData(bmd:BitmapData):void {
			if (bmd != null) {
				_width = _width || bmd.width;
				_height = _height || bmd.height;
			}
			_bitmap.bitmapData = bmd;
			callLater(changeSize);
			sendEvent(UIEvent.COMPLETE);
		}
		
		override protected function changeSize():void {
			if (_bitmap.bitmapData != null) {
				if (_scale9 != null) {
					_bitmap.bitmapData = DisplayUtil.scale9Bmd(_bitmap.bitmapData, _scale9, _width, _height);
				} else {
					_bitmap.width = _width;
					_bitmap.height = _height;
				}
			}
			super.changeSize();
		}
		
		public function set scale9(value:String):void {
			_scale9 = ArrayUtil.copyAndFill(Styles.imageScale9Grid, value);
		}
		
		public function get scale9():String {
			return _scale9.toString();
		}
		
		public function get smoothing():Boolean {
			return _bitmap.smoothing;
		}
		
		public function set smoothing(value:Boolean):void {
			_bitmap.smoothing = value;
		}
		
		public function get bitmap():Bitmap {
			return _bitmap;
		}
		
		protected function removeCache():void {
			if (_url) {
				var images:Vector.<Image> = cache[_url] as Vector.<Image>;
				if (images) {
					images.splice(images.indexOf(this), 1);
				}
			}
		}

		protected function completeHandler(event:Event):void {
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			loaderInfo.removeEventListener(Event.COMPLETE, completeHandler);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
			var loader:DLoader = loaderInfo.loader as DLoader;
			var bmpd:BitmapData = Bitmap(loaderInfo.content).bitmapData;
			var list:Vector.<Image> = cache[loader.data];
			cache[loader.data] = bmpd;
			DLoader.toPool(loader);
			
			var image:Image;
			for each (image in list) {
				image.setBitmapData(bmpd);
			}
			list.length = 0;
		}
		
		protected function ioErrorHandler(event:IOErrorEvent):void {
			trace("Image load error:" + event.text);
		}

		public static function clearCache():void {
			ObjectUtil.dispose(cache);
		}
	}
}