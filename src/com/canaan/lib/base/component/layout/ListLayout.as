package com.canaan.lib.base.component.layout
{
	import com.canaan.lib.base.component.Layouts;
	import com.canaan.lib.base.component.controls.List;
	
	import flash.display.DisplayObject;

	public class ListLayout extends ContainerLayout
	{
		protected var _horizontalGap:Number = 0;
		protected var _verticalGap:Number = 0;
		protected var _row:int;
		protected var _column:int;
		
		public function ListLayout()
		{
			super();
			_layout = Layouts.HORIZONTAL;
		}
		
		override public function updateDisplayList():void {
			var item:DisplayObject;
			var l:int = list.size;
			var ww:Number;
			var hh:Number;
			for (var i:int = 0; i < l; i++) {
				item = list.items[i];
				ww = item.width;
				hh = item.height;
				if (_layout == Layouts.HORIZONTAL) {
					item.x = (ww + _horizontalGap) * int(i % _column);
					item.y = (hh + _verticalGap) * int(i / _column);
				} else if (_layout == Layouts.VERTICAL) {
					item.x = (ww + _horizontalGap) * int(i / _row);
					item.y = (hh + _verticalGap) * int(i % _row);
				}
			}
		}
		
		public function set row(value:int):void {
			if (_row != value) {
				_row = value;
				callLater(updateDisplayList);
			}
		}
		
		public function get row():int {
			return _row;
		}
		
		public function set column(value:int):void {
			if (_column != value) {
				_column = value;
				callLater(updateDisplayList);
			}
		}
		
		public function get column():int {
			return _column;
		}
		
		public function set horizontalGap(value:Number):void {
			if (_horizontalGap != value) {
				_horizontalGap = value;
				callLater(updateDisplayList);
			}
		}
		
		public function get horizontalGap():Number {
			return _horizontalGap;
		}
		
		public function set verticalGap(value:Number):void {
			if (_verticalGap != value) {
				_verticalGap = value;
				callLater(updateDisplayList);
			}
		}
		
		public function get verticalGap():Number {
			return _verticalGap;
		}
		
		protected function get list():List {
			return _target as List;
		}
	}
}