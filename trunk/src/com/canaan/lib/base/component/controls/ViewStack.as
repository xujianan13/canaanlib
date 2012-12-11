package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.IInitialItems;
	
	import flash.display.DisplayObject;

	public class ViewStack extends Container implements IInitialItems
	{
		protected var _items:Array;
		protected var _selectedIndex:int;
		
		public function ViewStack()
		{
			super();
		}
		
		public function initialItems():void {
			_items = [];
			var item:DisplayObject;
			for (var i:int = 0; i < numChildren; i++) {
				item = getChildAt(i);
				item.visible = i == _selectedIndex;
				_items[i] = item;
			}
		}
		
		public function addItem(value:DisplayObject):void {
			addChild(value);
			initialItems();
		}
		
		protected function setItemVisible(index:int, visible:Boolean):void {
			if (index >= 0 && index < _items.length) {
				_items[index].visible = visible;
			}
		}
		
		public function set selectedIndex(value:int):void {
			if (_selectedIndex != value) {
				setItemVisible(_selectedIndex, false);
				_selectedIndex = value;
				setItemVisible(_selectedIndex, true);
			}
		}
		
		public function get selectedIndex():int {
			return _selectedIndex;
		}
		
		public function set selectedItem(value:DisplayObject):void {
			selectedIndex = _items.indexOf(value);
		}
		
		public function get selectedItem():DisplayObject {
			return _items[_selectedIndex];
		}
		
		public function get items():Array {
			return _items;
		}
	}
}