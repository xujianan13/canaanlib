package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Styles;
	
	import flash.events.MouseEvent;

	public class TreeListItem extends ListItem
	{
		protected var _level:int;
		protected var _parentItem:TreeListItem;
		protected var _childItems:Vector.<TreeListItem>;
		protected var _opend:Boolean;
		protected var _paddingLeft:int;
		
		protected var containerChildren:Container;
		
		public function TreeListItem()
		{
			super();
		}
		
		override protected function createChildren():void {
			super.createChildren();
			containerChildren = new Container();
		}
		
		override protected function onMouseClick(event:MouseEvent):void {
			if (!_enabled) {
				return;
			}
			if (!opend) {
				open();
			} else {
				close();
			}
			if (_mouseClickHandler != null) {
				_mouseClickHandler.applyWith([this]);
			}
			event.stopPropagation();
		}
		
		public function open():void {
			if (!opend) {
				_opend = true;
				containerChildren.y = height;
				addChild(containerChildren);
				updateChildItems();
			}
		}
		
		public function close():void {
			if (hasChildrenItems && _opend) {
				_opend = false;
				removeChild(containerChildren);
				updateChildItems();
			}
		}
		
		protected function updateChildItems():void {
			if (hasChildrenItems) {
				var yy:int;
				for each (var item:TreeListItem in _childItems) {
					item.y = yy;
					yy += item.height;
				}
			}
		}
		
		public function get level():int {
			return _level;
		}
		
		public function set level(value:int):void {
			_level = value;
			callLater(updatePaddingLeft);
		}
		
		public function get paddingLeft():int {
			return _paddingLeft;
		}
		
		public function set paddingLeft(value:int):void {
			_paddingLeft = value;
			callLater(updatePaddingLeft);
		}
		
		protected function updatePaddingLeft():void {
			if (_level != 0) {
				x = _paddingLeft;
			}
		}
		
		public function get parentItem():TreeListItem {
			return _parentItem;
		}
		
		public function set parentItem(value:TreeListItem):void {
			_parentItem = value;
		}
		
		public function get childItems():Vector.<TreeListItem> {
			return _childItems;
		}
		
		public function set childItems(value:Vector.<TreeListItem>) {
			_childItems = value;
			for each (var item:TreeListItem in _childItems) {
				containerChildren.addChild(item);
			}
		}
		
		public function get hasChildrenItems():Boolean {
			return _childItems != null && _childItems.length > 0;
		}
		
		public function get opend():Boolean {
			return hasChildrenItems && _opend;
		}
	}
}