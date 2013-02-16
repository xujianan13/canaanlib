package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.IInitialItems;
	import com.canaan.lib.base.component.IList;
	import com.canaan.lib.base.component.IListItem;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.events.UIEvent;
	import com.canaan.lib.base.utils.ArrayUtil;
	
	[Event(name="change", type="com.canaan.lib.base.events.UIEvent")]
	
	public class ListBase extends Container implements IInitialItems, IList
	{
		protected var _items:Array = [];
		protected var _selectedValue:Object;
		//		protected var _selectedItem:IListItem;
		protected var _changeCallback:Method;
		
		public function ListBase()
		{
			super();
		}
		
		public function initialItems():void {
			if (_data != null) {
				return;
			}
			var item:IListItem;
			for (var i:int = 0; i < numChildren; i++) {
				item = getChildAt(i) as IListItem;
				if (item != null) {
					_items.push(item);
					item.selected = false;
					item.mouseClickHandler = new Method(itemClickHandler, [item]);
				}
			}
		}
		
		public function get items():Array {
			return _items;
		}
		
		public function set selectedValue(value:Object):void {
			if (_data == null || (value != null && _data.indexOf(value) == -1)) {
				return;
			}
			if (_selectedValue != value) {
				if (selectedItem != null) {
					selectedItem.selected = false;
				}
				_selectedValue = value;
				if (selectedItem != null) {
					selectedItem.selected = true;
				}
			}
		}
		
		public function get selectedValue():Object {
			return _selectedValue;
		}
		
		public function set selectedItem(value:IListItem):void {
			selectedValue = value.data;
		}
		
		public function get selectedItem():IListItem {
			return ArrayUtil.find(_items, "data", _selectedValue);
		}
		
		public function set selectedIndex(value:int):void {
			if (_data == null || _data.length == 0) {
				_selectedValue = null;
				return;
			}
			if (value < 0) {
				selectedValue = null;
			} else {
				value = Math.min(_data.length - 1, value);
				selectedValue = _data[value];
			}
		}
		
		public function get selectedIndex():int {
			if (_selectedValue != null) {
				return _data.indexOf(_selectedValue);
			}
			return -1;
		}
		
		//		public function set selectedItem(value:IListItem):void {
		//			if (_selectedItem != value) {
		//				if (_selectedItem != null) {
		//					_selectedItem.selected = false;
		//				}
		//				_selectedItem = value;
		//				_selectedItem.selected = true;
		//			}
		//		}
		//		
		//		public function get selectedItem():IListItem {
		//			return _selectedItem;
		//		}
		//		
		//		public function set selectedIndex(value:int):void {
		//			selectedItem = _items[value];
		//		}
		//		
		//		public function get selectedIndex():int {
		//			return _items.indexOf(_selectedItem);
		//		}
		//		
		//		public function set selectedValue(value:Object):void {
		//			var item:IListItem;
		//			var l:int = _items.length;
		//			for (var i:int = 0; i < l; i++) {
		//				item = _items[i];
		//				if (item.data == value) {
		//					selectedItem = item;
		//					break;
		//				}
		//			}
		//		}
		//		
		//		public function get selectedValue():Object {
		//			return _selectedItem.data;
		//		}
		
		protected function itemClickHandler(item:IListItem):void {
			selectedItem = item;
			if (_changeCallback != null) {
				_changeCallback.applyWith([selectedValue]);
			}
			sendEvent(UIEvent.CHANGE);
		}
		
		public function set changeCallback(value:Method):void {
			if (_changeCallback != value) {
				_changeCallback = value;
			}
		}
		
		public function get changeCallback():Method {
			return _changeCallback;
		}
		
		public function forEach(func:Function, value:Object = null):void {
			var iListItem:IListItem;
			for (var i:int = 0; i < _items.length; i++) {
				iListItem = _items[i];
				func.apply(null, [iListItem, value]);
			}
		}
	}
}