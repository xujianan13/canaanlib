package com.canaan.lib.base.utils
{
	import com.canaan.lib.base.display.Effect;
	import com.canaan.lib.base.interfaces.IDispose;
	import com.canaan.lib.base.managers.StageManager;
	
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.StageDisplayState;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class DisplayUtil
	{
		public static var matrixArray:Array = [];
		public static var matrix:Matrix = new Matrix();
		public static var rect:Rectangle = new Rectangle();
		public static var point:Point = new Point();
		
		public static function gray(target:DisplayObject, isGray:Boolean = true):void {
			if (isGray) {
				addFilter(target, Effect.GRAY_FILTER);
			} else {
				removeFilter(target, ColorMatrixFilter);
			}
		}

		/**
		 * 根据RGBA值获取ColorMatrixFilter
		 * 50, 100, 50为绿色
		 * 100, -50, -50为红色
		 */
		public static function getColorMatrixFilter(r:Number, g:Number, b:Number, alpha:Number):ColorMatrixFilter {
			matrixArray = 	[alpha,	0,		0,		0,		r,
							0,		alpha,	0,		0, 		g,
							0,		0,		alpha,	0,		b,
							0,		0,		0,		1,		0];
			return new ColorMatrixFilter(matrixArray);
		}
		
		public static function removeChild(parent:DisplayObjectContainer, child:DisplayObject, dispose:Boolean = false):void {
			if (parent != null && child != null) {
				if (parent.contains(child)) {
					parent.removeChild(child);
					if (dispose) {
						if (child is IDispose) {
							IDispose(child).dispose();
						}
					}
				}
			}
		}
		
		public static function removeAllChildren(container:DisplayObjectContainer, dispose:Boolean = false):void {
			if (container != null) {
				while (container.numChildren > 0) {
					removeChild(container, container.getChildAt(0), dispose);
				}
			}
		}
		
		public static function center(target:DisplayObject, offsetX:Number = 0, offsetY:Number = 0):void {
			var x:Number = (StageManager.getInstance().stage.stageWidth - target.width) * 0.5;
			var y:Number = (StageManager.getInstance().stage.stageHeight - target.height) * 0.5;
			x += offsetX;
			y += offsetY;
			target.x = x;
			target.y = y;
		}
		
		public static function centerToParent(target:DisplayObject, offsetX:Number = 0, offsetY:Number = 0):void {
			var parent:DisplayObjectContainer = target.parent;
			if (parent != null) {
				var x:Number = (parent.width - target.width) * 0.5;
				var y:Number = (parent.height - target.height) * 0.5;
				x += offsetX;
				y += offsetY;
				target.x = x;
				target.y = y;
			}
		}
		
		public static function fullScreen(value:Boolean):void {
			if (value) {
				if (StageManager.getInstance().stage.displayState == StageDisplayState.NORMAL) {
					StageManager.getInstance().stage.displayState = StageDisplayState.FULL_SCREEN;
				}
			} else {
				if (StageManager.getInstance().stage.displayState == StageDisplayState.FULL_SCREEN) {
					StageManager.getInstance().stage.displayState = StageDisplayState.NORMAL;
				}
			}
        }

        public static function stopAllMovieClip(container:DisplayObjectContainer):void {
        	if (container != null) {
        		if (container is MovieClip) {
        			MovieClip(container).stop();
        		}
        		var child:DisplayObject;
				for (var i:int = 0; i < container.numChildren; i++) {
        			child = container.getChildAt(i);
        			if (child is DisplayObjectContainer) {
        				stopAllMovieClip(child as DisplayObjectContainer);
        			}
        			i++;
        		}
        	}
        }
        
        public static function startAllMovieClip(container:DisplayObjectContainer):void {
        	if (container != null) {
        		if (container is MovieClip) {
        			MovieClip(container).play();
        		}
				var child:DisplayObject;
				for (var i:int = 0; i < container.numChildren; i++) {
        			child = container.getChildAt(i);
        			if (child is DisplayObjectContainer) {
        				startAllMovieClip(child as DisplayObjectContainer);
        			}
        			i++;
        		}
        	}
        }
        
		public static function horizontalFlip(source:BitmapData, target:BitmapData):BitmapData {
			if (target == null) {
				target = new BitmapData(source.width, source.height, true, 0x00FFFFFF);
			}
			matrix.identity();
			matrix.a = -1;
			matrix.tx = source.width;
			target.draw(source, matrix);
			return target;
		}
		
		public static function verticalFlip(source:BitmapData, target:BitmapData):BitmapData {
			if (target == null) {
				target = new BitmapData(source.width, source.height, true, 0x00FFFFFF);
			}
			matrix.identity();
			matrix.d = -1;
			matrix.ty = source.width;
			target.draw(source, matrix);
			return target;
		}
		
		public static function addFilter(target:DisplayObject, filter:BitmapFilter):void {
			var filters:Array = target.filters;
			filters.push(filter);
			target.filters = filters;
		}
		
		public static function removeFilter(target:DisplayObject, filterType:Class):void {
			var filters:Array = target.filters;
			var l:int = filters.length;
			if (l > 0) {
				var filter:BitmapFilter;
				for (var i:int = l - 1; i >= 0; i--) {
					filter = filters[i];
					if (filter is filterType) {
						filters.splice(i, 1);
					}
					i--;
				}
				target.filters = filters;
			}
		}
		
		/**
		 * yungzhu的创建切片方法
		 */
		public static function createTiles(source:BitmapData, x:int, y:int):Vector.<BitmapData> {
			var tiles:Vector.<BitmapData> = new Vector.<BitmapData>();
			var width:int = Math.max(source.width / x, 1);
			var height:int = Math.max(source.height / y, 1);
			var bmd:BitmapData;
			point.x = 0;
			point.y = 0;
			for (var i:int = 0; i < x; i++) {
				for (var j:int = 0; j < y; j++) {
					bmd = new BitmapData(width, height);
					rect.setTo(i * width, j * height, width, height);
					bmd.copyPixels(source, rect, point);
					tiles.push(bmd);
				}
			}
			return tiles;
		}
		
		/**
		 * yungzhu的九宫格处理方法
		 * 
		 */
		public static function scale9Bmd(bmd:BitmapData, sizeGrid:Array, width:int, height:int):BitmapData {
			if (bmd.width == width && bmd.height == height) {
				return bmd;
			}
			if (width == 0 || height == 0) {
				return null;
			}
			
			var gw:int = int(sizeGrid[0]) + int(sizeGrid[2]);
			var gh:int = int(sizeGrid[1]) + int(sizeGrid[3]);
			var newBmd:BitmapData = new BitmapData(width, height, bmd.transparent, 0x00000000);
			
			if (width > gw && height > gh) {
				rect.setTo(sizeGrid[0], sizeGrid[1], bmd.width - sizeGrid[0] - sizeGrid[2], bmd.height - sizeGrid[1] - sizeGrid[3]);
				var rows:Array = [0, rect.top, rect.bottom, bmd.height];
				var cols:Array = [0, rect.left, rect.right, bmd.width];
				var newRows:Array = [0, rect.top, height - (bmd.height - rect.bottom), height];
				var newCols:Array = [0, rect.left, width - (bmd.width - rect.right), width];
				var newRectWidth:Number;
				var newRectHeight:Number;
				var newRectX:Number;
				var newRectY:Number;
				for (var i:int = 0; i < 3; i++) {
					for (var j:int = 0; j < 3; j++) {
						rect.setTo(cols[i], rows[j], cols[i + 1] - cols[i], rows[j + 1] - rows[j]);
						newRectWidth = rect.width;
						newRectHeight = rect.height;
						newRectX = rect.x;
						newRectY = rect.y;
						rect.setTo(newCols[i], newRows[j], newCols[i + 1] - newCols[i], newRows[j + 1] - newRows[j]);
						matrix.identity();
						matrix.a = rect.width / newRectWidth;
						matrix.d = rect.height / newRectHeight;
						matrix.tx = rect.x - newRectX * matrix.a;
						matrix.ty = rect.y - newRectY * matrix.d;
						newBmd.draw(bmd, matrix, null, null, rect, true);
					}
				}
			} else {
				matrix.identity();
				matrix.a = width / bmd.width;
				matrix.d = height / bmd.height;
				rect.setTo(0, 0, width, height);
				newBmd.draw(bmd, matrix, null, null, rect, true);
			}
			return newBmd;
		}
	}
}