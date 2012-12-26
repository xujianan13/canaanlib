package com.canaan.lib.rpg.core.map
{
	import com.canaan.lib.base.core.DLoader;
	import com.canaan.lib.base.core.ObjectPool;
	import com.canaan.lib.base.utils.ObjectUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;

	public class Map
	{
		/**
		 * 资源缓存
		 */
		public static var cache:Dictionary = new Dictionary();
		
		/**
		 * 源地图缓冲区
		 */
		protected var buffer:BitmapData;
		
		/**
		 * 缩略图缓冲区
		 */
		protected var thumbnailBuffer:BitmapData;
		
		/**
		 * tile x轴数量
		 */
		protected var tileX:int;
		
		/**
		 * tile y轴数量
		 */
		protected var tileY:int;
		
		/**
		 * 当前绘制起始点x轴坐标
		 */
		protected var currentStartX:int;
		
		/**
		 * 当前绘制起始点y轴坐标
		 */
		protected var currentStartY:int;
		
		/**
		 * 当前绘制的tile数组
		 */
		protected var drawTiles:Vector.<Point>;

		/**
		 * 地图数据
		 */
		protected var _mapData:MapData;
		
		/**
		 * 缩略图源数据
		 */
		protected var _bmpdThumbnail:BitmapData;
		
		/**
		 * 地图绘制区
		 */
//		protected var _drawBuffer:Shape;
		protected var _drawBuffer:Bitmap;
		
		/**
		 * 地图中心点坐标
		 */
		protected var _center:Point;
		
		public function Map()
		{
			_center = new Point();
//			_drawBuffer = new Shape();
			_drawBuffer = new Bitmap();
			drawTiles = new Vector.<Point>();
		}
		
		/**
		 * 初始化地图并开始加载缩略图
		 */
		public function initialize(value:MapData):void {
			_mapData = value;
			resize();
			loadThumbnail();
		}
		
		/**
		 * 加载缩略图
		 */
		protected function loadThumbnail():void {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, thumbnailComplete);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loader.load(new URLRequest(_mapData.thumbnailPath));
		}
		
		/**
		 * 加载地图切片
		 */
		protected function loadTiles():void {
//			_drawBuffer.cacheAsBitmap = false;
			var point:Point;
			var tilePath:String;
			var loader:DLoader;
			for (var i:int = drawTiles.length - 1; i >= 0; i--) {
				point = drawTiles[i];
				tilePath = _mapData.getTilePath(point.x, point.y);
				if (cache[tilePath] != null) {
					buffer.copyPixels(cache[tilePath], cache[tilePath].rect, new Point(int((point.x - currentStartX) * _mapData.tileWidth), int((point.y - currentStartY) * _mapData.tileHeight)));
					drawTiles.splice(i, 1);
				} else {
					loader = ObjectPool.getObject(DLoader) as DLoader;
					loader.data = point;
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, tileComplete);
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
					loader.load(new URLRequest(tilePath));
				}
			}
//			if (drawTiles.length == 0) {
//				_drawBuffer.cacheAsBitmap = true;
//			}
		}
		
		/**
		 * 缩略图完成事件
		 */
		protected function thumbnailComplete(event:Event):void {
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			_bmpdThumbnail = Bitmap(loaderInfo.content).bitmapData;
			var percentX:Number = _bmpdThumbnail.width / _mapData.mapWidth;
			var percentY:Number = _bmpdThumbnail.height / _mapData.mapHeight;
			thumbnailBuffer = new BitmapData(buffer.width * percentX, buffer.height * percentY, false, 0x000000);
			loaderInfo.removeEventListener(Event.COMPLETE, thumbnailComplete);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loaderInfo.loader.unloadAndStop();
			loaderInfo = null;
			update();
		}
		
		/**
		 * 地图切片完成事件
		 */
		protected function tileComplete(event:Event):void {
			var loaderInfo:LoaderInfo = event.target as LoaderInfo;
			loaderInfo.removeEventListener(Event.COMPLETE, tileComplete);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			
			var loader:DLoader = loaderInfo.loader as DLoader;
			var point:Point = loader.data as Point;
			var key:String = _mapData.getTilePath(point.x, point.y);
			cache[key] = Bitmap(loaderInfo.content).bitmapData;
			if (drawTiles.indexOf(point) != -1) {
				buffer.copyPixels(cache[key], cache[key].rect, new Point(int((point.x - currentStartX) * _mapData.tileWidth), int((point.y - currentStartY) * _mapData.tileHeight)));
				drawTiles.splice(drawTiles.indexOf(point), 1);
//				if (drawTiles.length == 0) {
//					_drawBuffer.cacheAsBitmap = true;
//				}
			}
			
			ObjectPool.disposeObject(loader);
		}
		
		/**
		 * IO异常
		 */
		protected function ioErrorHandler(event:IOErrorEvent):void {
			trace("Map load error:" + event.text);
		}
		
		/**
		 * 重绘
		 */
		public function resize():void {
			_center.x = _mapData.mapWidth * 0.5;
			_center.y = _mapData.mapHeight * 0.5;
			
			if (buffer != null) {
				buffer.dispose();
			}
			buffer = new BitmapData(_mapData.mapWidth + _mapData.tileWidth, _mapData.mapHeight + _mapData.tileHeight, false);
			
//			_drawBuffer.graphics.clear();
//			_drawBuffer.graphics.beginBitmapFill(buffer);
//			_drawBuffer.graphics.drawRect(0, 0, buffer.width, buffer.height);
			_drawBuffer.bitmapData = buffer;
			
			tileX = Math.ceil(_mapData.mapWidth / _mapData.tileWidth) + 1;
			tileY = Math.ceil(_mapData.mapHeight / _mapData.tileHeight) + 1;
			
			render(true);
		}
		
		/**
		 * 更新地图数据
		 */
		protected function update(startX:int = -1, startY:int = -1, redraw:Boolean = false):void {
			if (startX == -1) {
				startX = int(leftTop.x / _mapData.tileWidth);
				startY = int(leftTop.y / _mapData.tileHeight);
			}
			if (currentStartX == startX && currentStartY == startY && !redraw) {
				return;
			}
			currentStartX = startX;
			currentStartY = startY;
			
			drawTiles.length = 0;
			drawThumbnail(startX, startY);
			
			var maxTileX:int = Math.min(startX + tileX, _mapData.maxTileX);
			var maxTileY:int = Math.min(startY + tileY, _mapData.maxTileY);
			for (var y:int = startY; y < maxTileY; y++) {
				for (var x:int = startX; x < maxTileX; x++) {
					drawTiles.push(new Point(x, y));
				}
			}
			loadTiles();
		}
		
		/**
		 * 渲染
		 */
		public function render(redraw:Boolean = false):void {
			var startX:int = int(leftTop.x / _mapData.tileWidth);
			var startY:int = int(leftTop.y / _mapData.tileHeight);
			update(startX, startY, redraw);
			if (currentStartX == startX && currentStartY == startY) {
				_drawBuffer.x = -(leftTop.x % _mapData.tileWidth);
				_drawBuffer.y = -(leftTop.y % _mapData.tileHeight);
			}
		}
		
		protected function drawThumbnail(startX:int, startY:int):void {
			if (_bmpdThumbnail == null || thumbnailBuffer == null) {
				return;
			}
			var percentX:Number = _bmpdThumbnail.width / _mapData.maxWidth;
			var percentY:Number = _bmpdThumbnail.height / _mapData.maxHeight;
			thumbnailBuffer.fillRect(thumbnailBuffer.rect, 0x000000);
			thumbnailBuffer.copyPixels(_bmpdThumbnail, new Rectangle(startX * _mapData.tileWidth * percentX, startY * _mapData.tileHeight * percentY, _bmpdThumbnail.width, _bmpdThumbnail.height), new Point());
			percentX = _mapData.maxWidth / _bmpdThumbnail.width;
			percentY = _mapData.maxHeight / _bmpdThumbnail.height;
			buffer.draw(thumbnailBuffer, new Matrix(percentX, 0, 0, percentY), null, null, null, true);
		}
		
		public function moveTo(x:Number, y:Number):void {
			_center.x = Math.max(_mapData.mapWidth * 0.5, Math.min(_mapData.maxWidth - _mapData.mapWidth * 0.5, x));
			_center.y = Math.max(_mapData.mapHeight * 0.5, Math.min(_mapData.maxHeight - _mapData.mapHeight * 0.5, y));
		}
		
		public static function clearCache():void {
			ObjectUtil.dispose(cache);
		}
		
		public function get leftTop():Point {
			var xx:Number = Math.min(Math.max(0, center.x - _mapData.mapWidth * 0.5), _mapData.maxWidth - _mapData.mapWidth);
			var yy:Number = Math.min(Math.max(0, center.y - _mapData.mapHeight * 0.5), _mapData.maxHeight - _mapData.mapHeight);
			return new Point(xx, yy);
		}
		
		public function get mapData():MapData {
			return _mapData;
		}
		
		public function get bmpdThumbnail():BitmapData {
			return _bmpdThumbnail;
		}
		
//		public function get drawBuffer():Shape {
//			return _drawBuffer;
//		}
		
		public function get drawBuffer():Bitmap {
			return _drawBuffer;
		}

		public function get center():Point {
			return _center;
		}
	}
}