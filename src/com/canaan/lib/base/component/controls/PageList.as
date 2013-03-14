package com.canaan.lib.base.component.controls
{
	public class PageList extends List
	{
		protected var _currentPage:int;
		
		public function PageList(skin:String=null, row:int=0, column:int=0)
		{
			super(skin, row, column);
		}
		
		override public function refresh():void {
			if (_data != null) {
				var itemIndex:int;
				var l:int = size;
				var item:ListItem;
				for (var i:int = 0; i < l; i++) {
					item = _items[i];
					itemIndex = _currentPage * size + i;
					if (itemIndex < _data.length) {
						if (_autoVisible) {
							item.visible = true;
						}
						item.data = _data[itemIndex];
						item.selected = _data[itemIndex] == _selectedValue;
					} else {
						if (_autoVisible) {
							item.visible = false;
						}
						item.selected = false;
					}
				}
			}
		}
		
		public function set currentPage(value:int):void {
			value = Math.max(0, Math.min(maxPage, value));
			if (_currentPage != value) {
				_currentPage = value;
				callLater(refresh);
			}
		}
		
		public function get currentPage():int {
			return _currentPage;
		}
		
		public function get maxPage():int {
			if (_data != null) {
				return Math.max(0, Math.ceil(_data.length / size) - 1);
			}
			return 0;
		}
	}
}