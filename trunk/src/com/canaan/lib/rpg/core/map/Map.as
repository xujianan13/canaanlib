package com.canaan.lib.rpg.core.map
{
	import com.canaan.lib.base.core.DLoader;
	import com.canaan.lib.base.utils.ObjectUtil;
	import com.canaan.lib.rpg.core.model.map.MapVo;
	
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
		 * 当前绘制的tile
		 */
		protected var drawTiles:Dictionary;
		
		/**
		 * 地图数据
		 */
		protected var _mapVo:MapVo;
		
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
		}
		
		/**
		 * 初始化地图并开始加载缩略图
		 */
		public function initialize(mapVo:MapVo):void {
			_mapVo = mapVo;
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
			loader.load(new URLRequest(_mapVo.thumbnailPath));
		}
		
		/**
		 * 加载地图切片
		 */
		protected function loadTiles():void {
//			_drawBuffer.cacheAsBitmap = false;
			var point:Point;
			var tilePath:String;
			var loader:DLoader;
			var bmpDataCache:BitmapData;
			for (var key:String in drawTiles) {
				point = drawTiles[key];
				tilePath = _mapVo.getTilePath(point.x, point.y);
				if (cache[tilePath] != null) {
					bmpDataCache = cache[tilePath] as BitmapData;
					if (bmpDataCache != null) {
						buffer.copyPixels(bmpDataCache, bmpDataCache.rect, new Point(int((point.x - currentStartX) * _mapVo.tileWidth), int((point.y - currentStartY) * _mapVo.tileHeight)));
						delete drawTiles[key];
					}
				} else {
					loader = DLoader.fromPool();
					loader.data = point;
					loader.contentLoaderInfo.addEventListener(Event.COMPLETE, tileComplete);
					loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
					loader.load(new URLRequest(tilePath));
					cache[tilePath] = loader;
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
			var percentX:Number = _bmpdThumbnail.width / _mapVo.mapWidth;
			var percentY:Number = _bmpdThumbnail.height / _mapVo.mapHeight;
			thumbnailBuffer = new BitmapData(buffer.width * percentX, buffer.height * percentY, false, 0x000000);
			loaderInfo.removeEventListener(Event.COMPLETE, thumbnailComplete);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
			loaderInfo.loader.unloadAndStop();
			loaderInfo = null;
			update(-1, -1, true);
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
			var key:String = _mapVo.getTileKey(point.x, point.y);
			var tilePath:String = _mapVo.getTilePath(point.x, point.y);
			cache[tilePath] = Bitmap(loaderInfo.content).bitmapData;
			if (drawTiles[key]) {
				buffer.copyPixels(cache[tilePath], cache[tilePath].rect, new Point(int((point.x - currentStartX) * _mapVo.tileWidth), int((point.y - currentStartY) * _mapVo.tileHeight)));
				delete drawTiles[key];
//				if (drawTiles.length == 0) {
//					_drawBuffer.cacheAsBitmap = true;
//				}
			}
			
			DLoader.toPool(loader);
		}
		
		/**
		 * IO异常
		 */
		protected function ioErrorHandler(event:IOErrorEvent):void {
			trace("Map load error:" + event.text);
		}
		
		public function changeMapSize(width:Number, height:Number):void {
			if (_mapVo == null) {
				return;
			}
			if (_mapVo.mapWidth == width && _mapVo.mapHeight == height) {
				return;
			}
			_mapVo.mapWidth = width;
			_mapVo.mapHeight = height;
			resize();
		}
		
		/**
		 * 重绘
		 */
		public function resize():void {
			if (_mapVo == null) {
				return;
			}
			if (buffer != null) {
				buffer.dispose();
			}
			buffer = new BitmapData(_mapVo.mapWidth + _mapVo.tileWidth, _mapVo.mapHeight + _mapVo.tileHeight, false);
			
//			_drawBuffer.graphics.clear();
//			_drawBuffer.graphics.beginBitmapFill(buffer);
//			_drawBuffer.graphics.drawRect(0, 0, buffer.width, buffer.height);
			_drawBuffer.bitmapData = buffer;
			
			tileX = Math.ceil(_mapVo.mapWidth / _mapVo.tileWidth) + 1;
			tileY = Math.ceil(_mapVo.mapHeight / _mapVo.tileHeight) + 1;
			
			render(true);
		}
		
		/**
		 * 更新地图数据
		 */
		protected function update(startX:int = -1, startY:int = -1, redraw:Boolean = false):void {
			var pLeftTop:Point = leftTop;
			if (startX == -1) {
				startX = int(pLeftTop.x / _mapVo.tileWidth);
				startY = int(pLeftTop.y / _mapVo.tileHeight);
			}
			if (currentStartX == startX && currentStartY == startY && !redraw) {
				return;
			}
			currentStartX = startX;
			currentStartY = startY;
			
			drawTiles = new Dictionary();
			drawThumbnail(startX, startY);
			
			var maxTileX:int = Math.min(startX + tileX, _mapVo.maxTileX);
			var maxTileY:int = Math.min(startY + tileY, _mapVo.maxTileY);
			for (var y:int = startY; y < maxTileY; y++) {
				for (var x:int = startX; x < maxTileX; x++) {
					drawTiles[mapVo.getTileKey(x, y)] = new Point(x, y);
				}
			}
			loadTiles();
		}
		
		/**
		 * 渲染
		 */
		public function render(redraw:Boolean = false):void {
			var pLeftTop:Point = leftTop;
			var startX:int = int(pLeftTop.x / _mapVo.tileWidth);
			var startY:int = int(pLeftTop.y / _mapVo.tileHeight);
			update(startX, startY, redraw);
			if (currentStartX == startX && currentStartY == startY) {
				_drawBuffer.x = -(pLeftTop.x % _mapVo.tileWidth);
				_drawBuffer.y = -(pLeftTop.y % _mapVo.tileHeight);
			}
		}
		
		protected function drawThumbnail(startX:int, startY:int):void {
			if (_bmpdThumbnail == null || thumbnailBuffer == null) {
				return;
			}
			var percentX:Number = _bmpdThumbnail.width / _mapVo.maxWidth;
			var percentY:Number = _bmpdThumbnail.height / _mapVo.maxHeight;
			thumbnailBuffer.fillRect(thumbnailBuffer.rect, 0x000000);
			thumbnailBuffer.copyPixels(_bmpdThumbnail, new Rectangle(startX * _mapVo.tileWidth * percentX, startY * _mapVo.tileHeight * percentY, _bmpdThumbnail.width, _bmpdThumbnail.height), new Point());
			percentX = _mapVo.maxWidth / _bmpdThumbnail.width;
			percentY = _mapVo.maxHeight / _bmpdThumbnail.height;
			buffer.draw(thumbnailBuffer, new Matrix(percentX, 0, 0, percentY), null, null, null, true);
		}
		
		public function moveTo(x:Number, y:Number):void {
			_center.x = Math.max(_mapVo.mapWidth * 0.5, Math.min(_mapVo.maxWidth - _mapVo.mapWidth * 0.5, x));
			_center.y = Math.max(_mapVo.mapHeight * 0.5, Math.min(_mapVo.maxHeight - _mapVo.mapHeight * 0.5, y));
			render();
		}
		
		public static function clearCache():void {
			ObjectUtil.dispose(cache);
		}
		
		public function get leftTop():Point {
			var xx:Number = Math.min(Math.max(0, _center.x - _mapVo.mapWidth * 0.5), _mapVo.maxWidth - _mapVo.mapWidth);
			var yy:Number = Math.min(Math.max(0, _center.y - _mapVo.mapHeight * 0.5), _mapVo.maxHeight - _mapVo.mapHeight);
			return new Point(xx, yy);
		}
		
		public function get mapVo():MapVo {
			return _mapVo;
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
		
		public function getScreenPosition(mapX:Number, mapY:Number):Point {
			var screenPosition:Point = new Point(_mapVo.mapWidth / 2, _mapVo.mapHeight / 2);
			screenPosition.x += mapX - _center.x;
			screenPosition.y += mapY - _center.y;
			return screenPosition;
		}
		
		public function getMapPosition(x:Number, y:Number):Point {
			var mapPosition:Point = _center.clone();
			mapPosition.x += x - _mapVo.mapWidth / 2;
			mapPosition.y += y - _mapVo.mapHeight / 2;
			return mapPosition;
		}
	}
}