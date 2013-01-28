package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Direction;
	import com.canaan.lib.base.component.Layouts;
	import com.canaan.lib.base.component.layout.ScrollListLayout;
	import com.canaan.lib.base.events.UIEvent;
	
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;

	public class ScrollList extends List
	{
		protected var _currentPage:int;
		protected var _container:Container;
		protected var _scrollBar:ScrollBar;
		
		public function ScrollList(skin:String=null, scrollBarSkin:String = null, row:int=0, column:int=0)
		{
			super(skin, row, column);
			this.scrollBarSkin = scrollBarSkin;
		}
		
		override protected function createChildren():void {
			_container = new Container();
			super.addChild(_container);
			_scrollBar = new ScrollBar();
			super.addChild(_scrollBar);
		}
		
		override protected function initialize():void {
			_items = [];
			layoutObject = new ScrollListLayout();
			layoutObject.target = this;
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_scrollBar.dispatcher.addEventListener(UIEvent.CHANGE, onSrollBarChange);
			resetScrollBarDirection();
			_scrollBar.visible = false;
		}
		
		override public function set layout(value:String):void {
			super.layout = value;
			resetScrollBarDirection();
			resetScrollBarSize();
		}

		override protected function refresh():void {
			if (_data != null) {
				var itemIndex:int;
				var l:int = size;
				var item:ListItem;
				for (var i:int = 0; i < l; i++) {
					item = _items[i];
					itemIndex = (layout == Layouts.HORIZONTAL ? _column : _row) * _currentPage + i;
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
				_scrollBar.visible = _data.length > size;
				_scrollBar.value = _currentPage;
			}
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			return _container.addChild(child);
		}
		
		public function set scrollBarSkin(value:String):void {
			_scrollBar.skin = value;
		}
		
		public function get scrollBarSkin():String {
			return _scrollBar.skin;
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
			return _scrollBar.maxValue;
		}
		
		override public function set data(value:Object):void {
			super.data = value;
			resetScrollBarSize();
		}
		
		override public function set row(value:int):void {
			super.row = value;
			resetScrollBarSize();
		}
		
		override public function set column(value:int):void {
			super.column = value;
			resetScrollBarSize();
		}
		
		override public function set horizontalGap(value:Number):void {
			super.horizontalGap = value;
			resetScrollBarSize();
		}
		
		override public function set verticalGap(value:Number):void {
			super.verticalGap = value;
			resetScrollBarSize();
		}
		
		protected function onMouseWheel(event:MouseEvent):void {
			if (scrollBarVisible) {
				_scrollBar.value -= event.delta;
			}
		}
		
		protected function onSrollBarChange(event:UIEvent):void {
			currentPage = _scrollBar.value;
		}
		
		protected function resetScrollBarDirection():void {
			_scrollBar.direction = layout == Layouts.HORIZONTAL ? Direction.VERTICAL : Direction.HORIZONTAL;
		}
		
		protected function resetScrollBarSize():void {
			if (_data == null || _data.length <= size) {
				return;
			}
			var num:int = _data.length - size;
			if (_scrollBar.direction == Direction.HORIZONTAL) {
				_scrollBar.maxValue = Math.ceil(num / _row);
			} else {
				_scrollBar.maxValue = Math.ceil(num / _column);
			}
		}
		
		public function resetSrollBarPosition():void {
			if (layout == Layouts.HORIZONTAL) {
				_scrollBar.x = _container.width;
				_scrollBar.y = 0;
				_scrollBar.height = height;
			} else {
				_scrollBar.x = 0;
				_scrollBar.y = _container.height;
				_scrollBar.width = width;
			}
		}
		
		public function get scrollBar():ScrollBar {
			return _scrollBar;
		}

		override public function dispose():void {
			super.dispose();
			removeEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			_scrollBar.dispatcher.removeEventListener(UIEvent.CHANGE, onSrollBarChange);
		}
		
		public function get scrollBarVisible():Boolean {
			if (_data == null) {
				return false;
			}
			return _data.length > size;
		}
	}
}