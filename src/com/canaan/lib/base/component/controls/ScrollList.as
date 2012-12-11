package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Direction;
	import com.canaan.lib.base.component.Layouts;
	import com.canaan.lib.base.component.layout.ScrollListLayout;
	import com.canaan.lib.base.events.UIEvent;

	public class ScrollList extends List
	{
		protected var _currentPage:int;
		protected var scrollBar:ScrollBar;
		
		public function ScrollList(skin:String=null, scrollSkin:String = null, row:int=0, column:int=0)
		{
			super(skin, row, column);
			this.scrollSkin = scrollSkin;
		}
		
		override protected function createChildren():void {
			scrollBar = new ScrollBar();
			addChild(scrollBar);
		}
		
		override protected function initialize():void {
			_items = [];
			layoutObject = new ScrollListLayout();
			layoutObject.target = this;
			scrollBar.addEventListener(UIEvent.CHANGE, onSrollBarChange);
			resetScrollBarDirection();
			scrollBar.visible = false;
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
				scrollBar.visible = _data.length > size;
				scrollBar.value = _currentPage;
			}
		}
		
		public function set scrollSkin(value:String):void {
			scrollBar.skin = value;
		}
		
		public function get scrollSkin():String {
			return scrollBar.skin;
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
			return scrollBar.maxValue;
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
		
		protected function onSrollBarChange(event:UIEvent):void {
			currentPage = scrollBar.value;
		}
		
		protected function resetScrollBarDirection():void {
			scrollBar.direction = layout == Layouts.HORIZONTAL ? Direction.VERTICAL : Direction.HORIZONTAL;
		}
		
		protected function resetScrollBarSize():void {
			if (_data == null || _data.length <= size) {
				return;
			}
			var num:int = _data.length - size;
			if (scrollBar.direction == Direction.HORIZONTAL) {
				scrollBar.maxValue = Math.ceil(num / _row);
			} else {
				scrollBar.maxValue = Math.ceil(num / _column);
			}
		}
		
		public function resetSrollBarPosition():void {
			if (layout == Layouts.HORIZONTAL) {
				scrollBar.x = realWidth;
				scrollBar.y = 0;
				scrollBar.height = realHeight;
			} else {
				scrollBar.x = 0;
				scrollBar.y = realHeight;
				scrollBar.width = realWidth;
			}
		}

		override public function dispose():void {
			super.dispose();
			scrollBar.removeEventListener(UIEvent.CHANGE, onSrollBarChange);
		}
	}
}