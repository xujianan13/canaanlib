package com.canaan.lib.base.utils
{
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.display.Effect;
	import com.canaan.lib.base.interfaces.IDispose;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.StageDisplayState;
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class DisplayUtil
	{
		private static var matrixArray:Array = [];
		private static var matrix:Matrix = new Matrix();
		
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
				if (Application.stage.displayState == StageDisplayState.NORMAL) {
					Application.stage.displayState = StageDisplayState.FULL_SCREEN;
				}
			} else {
				if (Application.stage.displayState == StageDisplayState.FULL_SCREEN) {
					Application.stage.displayState = StageDisplayState.NORMAL;
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
        
		/**
		 * This method may has problems.
		 */
        public static function alignContainer(container:DisplayObjectContainer, layout:String, align:String = "leftTop", gap:Number = 0, paddingLeft:Number = 0, paddingTop:Number = 0, childSize:Number = NaN, ignoreList:Array = null):void {
        	var size:Number = 0;
        	var child:DisplayObject;
        	var index:int;
        	var i:int;
			for (i = 0; i < container.numChildren; i++) {
        		child = container.getChildAt(i);
        		if (!(child is Shape) && (!ignoreList || ignoreList.indexOf(child) == -1)) {
        			if (isNaN(childSize)) {
	        			if (layout == "vertical") {
	        				size += child.height;
	        			} else if (layout == "horizontal") {
	        				size += child.width;
	        			}
        			} else {
        				size += childSize;
        			}
        			index++;
        		}
        	}
        	size += (index - 1) & gap;
        	var startPos:Number;
        	switch (align) {
        		case "leftTop":
        			startPos = 0;
        			break;
        		case "rightBottom":
        			if (layout == "vertical") {
        				startPos = container.height - size;
        			} else if (layout == "horizontal") {
        				startPos = container.width - size;
        			}
        			break;
        		case "center":
        			if (layout == "vertical") {
        				startPos = (container.height - size) * 0.5;
        			} else if (layout == "horizontal") {
        				startPos = (container.width - size) * 0.5;
        			}
        			break;
        	}
        	var tmpSize:Number = 0;
			for (i = 0; i < container.numChildren; i++) {
        		child = container.getChildAt(i);
        		if (!(child is Shape) && (!ignoreList || ignoreList.indexOf(child) == -1)) {
        			if (layout == "vertical") {
        				child.y = startPos;
        				tmpSize = child.height;
        			} else if (layout == "horizontal") {
        				child.x = startPos;
        				tmpSize = child.width;
        			}
        			child.x += paddingLeft;
        			child.y += paddingTop;
        			startPos += (isNaN(childSize) ? tmpSize : childSize) + gap;
        		}
        	}
        }
		
		public static function horizontalFlip(source:BitmapData, target:BitmapData):BitmapData {
			if (target == null) {
				target = new BitmapData(source.width, source.height, true, 0x00FFFFFF);
			}
			matrix.a = -1;
			matrix.b = 0;
			matrix.c = 0;
			matrix.d = 1;
			matrix.tx = source.width;
			target.draw(source, matrix);
			return target;
		}
		
		public static function verticalFlip(source:BitmapData, target:BitmapData):BitmapData {
			if (target == null) {
				target = new BitmapData(source.width, source.height, true, 0x00FFFFFF);
			}
			matrix.a = 1;
			matrix.b = 0;
			matrix.c = 0;
			matrix.d = -1;
			matrix.tx = 0;
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
		public static function createTiles(source:BitmapData, x:int, y:int):Array {
			var tiles:Array = [];
			var width:int = Math.max(source.width / x, 1);
			var height:int = Math.max(source.height / y, 1);
			var point:Point = new Point();
			var bmd:BitmapData;
			for (var i:int = 0; i < x; i++) {
				for (var j:int = 0; j < y; j++) {
					bmd = new BitmapData(width, height);
					bmd.copyPixels(source, new Rectangle(i * width, j * height, width, height), point);
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
			var grid:Rectangle = new Rectangle(sizeGrid[0], sizeGrid[1], bmd.width - sizeGrid[0] - sizeGrid[2], bmd.height - sizeGrid[1] - sizeGrid[3]);
			width = Math.max(width, bmd.width - grid.width);
			height = Math.max(height, bmd.height - grid.height);
			
			var newBmd:BitmapData = new BitmapData(width, height, bmd.transparent, 0x00000000);
			var rows:Array = [0, grid.top, grid.bottom, bmd.height];
			var cols:Array = [0, grid.left, grid.right, bmd.width];
			var newRows:Array = [0, grid.top, height - (bmd.height - grid.bottom), height];
			var newCols:Array = [0, grid.left, width - (bmd.width - grid.right), width];
			var newRect:Rectangle;
			var clipRect:Rectangle;
			var m:Matrix = new Matrix();
			for (var i:int = 0; i < 3; i++) {
				for (var j:int = 0; j < 3; j++) {
					newRect = new Rectangle(cols[i], rows[j], cols[i + 1] - cols[i], rows[j + 1] - rows[j]);
					clipRect = new Rectangle(newCols[i], newRows[j], newCols[i + 1] - newCols[i], newRows[j + 1] - newRows[j]);
					m.identity();
					m.a = clipRect.width / newRect.width;
					m.d = clipRect.height / newRect.height;
					m.tx = clipRect.x - newRect.x * m.a;
					m.ty = clipRect.y - newRect.y * m.d;
					newBmd.draw(bmd, m, null, null, clipRect, true);
				}
			}
			return newBmd;
		}
		
		/**
		 * 创建单色不透明位图 多用于遮罩
		 */
		public static function createBitmap(width:int, height:int, color:uint = 0, alpha:Number = 1):Bitmap {
			var bitmap:Bitmap = new Bitmap(new BitmapData(1, 1, false, color));
			bitmap.alpha = alpha;
			bitmap.width = width;
			bitmap.height = height;
			return bitmap;
		}
	}
}