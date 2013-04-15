package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.IListItem;
	
	import flash.display.DisplayObject;

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
				var item:IListItem;
				for (var i:int = 0; i < l; i++) {
					item = _items[i];
					if (item != null) {
						itemIndex = _currentPage * size + i;
						if (itemIndex < _data.length) {
							if (_autoVisible) {
								DisplayObject(item).visible = true;
							}
							item.data = _data[itemIndex];
							item.selected = _data[itemIndex] == _selectedValue;
						} else {
							if (_autoVisible) {
								DisplayObject(item).visible = false;
							}
							item.data = null;
							item.selected = false;
						}
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