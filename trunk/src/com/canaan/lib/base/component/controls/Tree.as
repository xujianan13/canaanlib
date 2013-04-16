package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.IListItem;
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.component.ViewCreater;
	import com.canaan.lib.base.component.layout.TreeLayout;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.events.UIEvent;
	import com.canaan.lib.base.utils.ArrayUtil;

	public class Tree extends ListBase
	{
		protected var _skin:String;
		protected var _maxLevel:int;
		protected var _itemPaddingLeft:int;
		
		protected var allItems:Vector.<TreeListItem> = new Vector.<TreeListItem>();
		
		public function Tree(skin:String)
		{
			this.skin = skin;
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			_itemPaddingLeft = Styles.treeItemPaddingLeft;
		}
		
		override protected function initialize():void {
			layoutObject = new TreeLayout();
			layoutObject.target = this;
		}
		
		protected function get treeLayout():TreeLayout {
			return layoutObject as TreeLayout;
		}
		
		override public function set selectedItem(value:IListItem):void {
			if (_data == null) {
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
				if (_changeCallback != null) {
					_changeCallback.applyWith([_selectedValue]);
				}
				sendEvent(UIEvent.CHANGE);
			}
		}
		
		override public function get selectedItem():IListItem {
			for each (var item:TreeListItem in allItems) {
				if (item.data == _selectedValue) {
					return item;
				}
			}
			return null;
		}
		
		override public function set selectedIndex(value:int):void {
			throw new Error("can not set selectedIndex");
		}
		
		override public function get selectedIndex():int {
			throw new Error("can not get selectedIndex");
			return -1;
		}
		
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				callLater(refresh);
			}
		}
		
		override public function set data(value:Object):void {
			if (_data != value) {
				_data = value;
				callLater(refresh);
			}
		}
		
		public function get itemPaddingLeft():int {
			return _itemPaddingLeft;
		}
		
		public function set itemPaddingLeft(value:int):void {
			_itemPaddingLeft = value;
			for each (var item:TreeListItem in allItems) {
				item.paddingLeft = _itemPaddingLeft;
			}
		}
		
		/**
		 * 打开全部
		 * 
		 */		
		public function expandAll():void {
			callLater(delayExpandAll);
		}
		
		protected function delayExpandAll():void {
			for each (var item:TreeListItem in allItems) {
				item.open();
			}
			updateLayout();
		}
		
		/**
		 * 打开或关闭分之项目
		 * @param itemData
		 * @param open
		 * 
		 */		
		public function expandItem(itemData:Object, open:Boolean):void {
			var item:TreeListItem = ArrayUtil.find(allItems, "data", itemData);
			if (item != null) {
				do {
					if (open) {
						item.open();
					} else {
						item.close();
					}
					item = item.parent;
				} while (item != null);
			}
			updateLayout();
		}
		
		/**
		 * 分支项目是否打开
		 * @param itemData
		 * @return 
		 * 
		 */		
		public function isItemOpen(itemData:Object):Boolean {
			var item:TreeListItem = ArrayUtil.find(allItems, "data", itemData);
			if (item != null) {
				return item.opend;
			}
			return false;
		}
		
		/**
		 * 所有打开的项目
		 * @return 
		 * 
		 */		
		public function get openItems():Array {
			var result:Array = [];
			for each (var item:TreeListItem in allItems) {
				if (item.opend) {
					result.push(item);
				}
			}
			return result;
		}
		
		public function set openItems(value:Array):void {
			for each (var item:TreeListItem in allItems) {
				if (value.indexOf(item.data) != -1) {
					item.open();
				} else {
					item.close();
				}
			}
		}
		
		public function refresh():void {
			if (_data != null) {
				if (_data.length == 0) {
					_selectedValue = null;
				}
				clearItems();
				createItems();
			}
		}
		
		protected function clearItems():void {
			removeAllChildren(true);
			_items.length = 0;
			allItems.length = 0;
		}
		
		protected function createItems():void {
			if (_data != null) {
				var item:TreeListItem;
				for each (var itemData:Object in _data) {
					item = generateItem(itemData);
					_items.push(item);
					addChild(item);
				}
			}
		}
		
		protected function generateItem(itemData:Object, level:int = 0, parentItem:TreeListItem = null):TreeListItem {
			var item:TreeListItem = ViewCreater.getConponentInstance(_skin) as TreeListItem;
			if (item == null) {
				throw new Error(_skin + " must extends TreeListItem");
			}
			item.mouseClickHandler = new Method(itemClickHandler);
			item.level = level;
			item.data = itemData;
			item.paddingLeft = _itemPaddingLeft;
			if (parentItem != null) {
				item.parentItem = parentItem;
			}
			if (itemData.hasOwnProperty("children")) {
				level++;
				_maxLevel = level;
				var childItems:Vector.<TreeListItem> = new Vector.<TreeListItem>();
				for each (var childItemData:Object in itemData.children) {
					childItems.push(generateItem(childItemData, level, item));
				}
				item.childItems = childItems;
			}
			allItems.push(item);
			return item;
		}
		
		override protected function itemClickHandler(item:IListItem):void {
			super.itemClickHandler(item);
			updateLayout();
		}
		
		protected function updateLayout():void {
			callLater(treeLayout.updateDisplayList);
		}
	}
}