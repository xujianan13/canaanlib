package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.ViewCreater;
	import com.canaan.lib.base.component.layout.ListLayout;
	import com.canaan.lib.base.core.Method;

	public class List extends ListBase
	{
		protected var _skin:String;
		protected var _row:int;
		protected var _column:int;
		protected var _autoVisible:Boolean = true;
		
		public function List(skin:String = null, row:int = 0, column:int = 0)
		{
			this.skin = skin;
			this.row = row;
			this.column = column;
		}
		
		override protected function initialize():void {
			layoutObject = new ListLayout();
			layoutObject.target = this;
		}
		
		protected function get listLayout():ListLayout {
			return layoutObject as ListLayout;
		}

		override public function initialItems():void {
			var item:ListItem;
			var i:int;
			var l:int = size;
			var length:int;
			if (_items.length < l) {
				length = l - _items.length;
				for (i = 0; i < length; i++) {
					item = ViewCreater.getConponentInstance(_skin) as ListItem;
					if (item == null) {
						throw new Error(_skin + " must extends ListItem");
					}
					if (_autoVisible) {
						item.visible = false;
					}
					item.selected = false;
					item.mouseClickHandler = new Method(itemClickHandler, [item]);
					_items.push(addChild(item));
				}
			} else {
				length = _items.length - l;
				for (i = 0; i < length; i++) {
					item = removeChild(_items.pop()) as ListItem;
					item.dispose();
				}
			}
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				_items.length = 0;
				callLater(initialItems);
				callLater(refresh);
			}
		}
		
		public function get skin():String {
			return _skin;
		}
		
		override public function set data(value:Object):void {
			if (_data != value) {
				_data = value;
				callLater(refresh);
			}
		}
		
		public function refresh():void {
			if (_data != null) {
				var l:int = size;
				var item:ListItem;
				for (var i:int = 0; i < l; i++) {
					item = _items[i];
					if (i < _data.length) {
						if (_autoVisible) {
							item.visible = true;
						}
						item.data = _data[i];
						item.selected = _data[i] == _selectedValue;
					} else {
						if (_autoVisible) {
							item.visible = false;
						}
						item.data = null;
						item.selected = false;
					}
				}
			}
		}
		
		public function get size():int {
			return _row * _column;
		}
		
		public function set row(value:int):void {
			if (_row != value) {
				_row = value;
				callLater(initialItems);
				listLayout.row = value;
				callLater(refresh);
			}
		}
		
		public function get row():int {
			return listLayout.row;
		}
		
		public function set column(value:int):void {
			if (_column != value) {
				_column = value;
				callLater(initialItems);
				listLayout.column = value;
				callLater(refresh);
			}
		}
		
		public function get column():int {
			return listLayout.column;
		}
		
		public function set horizontalGap(value:Number):void {
			listLayout.horizontalGap = value;
		}
		
		public function get horizontalGap():Number {
			return listLayout.horizontalGap;
		}
		
		public function set verticalGap(value:Number):void {
			listLayout.verticalGap = value;
		}
		
		public function get verticalGap():Number {
			return listLayout.verticalGap;
		}
		
		public function set autoVisible(value:Boolean):void {
			if (_autoVisible != value) {
				_autoVisible = value;
				var l:int = _items.length;
				var item:ListItem;
				for (var i:int = 0; i < l; i++) {
					item = _items[i];
					item.visible = !value || _data && i < _data.length;
				}
			}
		}
		
		public function get autoVisible():Boolean {
			return _autoVisible;
		}
	}
}