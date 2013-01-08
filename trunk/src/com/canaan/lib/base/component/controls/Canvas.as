package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Direction;
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.events.UIEvent;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.events.MouseEvent;

	public class Canvas extends Container
	{
		protected var _content:Container;
		protected var _scrollBar:ScrollBar;
		protected var _mask:Bitmap;
		
		public function Canvas()
		{
			super();
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			width = Styles.canvasWidth;
			height = Styles.canvasHeight;
		}
		
		override protected function createChildren():void {
			super.createChildren();
			_content = new Container();
			super.addChild(_content);
			_scrollBar = new ScrollBar();
			super.addChild(_scrollBar);
			_mask = new Bitmap(new BitmapData(1, 1, false, 0x000000));
			super.addChild(_mask);
		}
		
		override protected function initialize():void {
			super.initialize();
			_content.mask = _mask;
			_scrollBar.dispatcher.addEventListener(UIEvent.CHANGE, onScrollBarChange);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
			direction = Direction.VERTICAL;
		}
		
		protected function onScrollBarChange(event:UIEvent):void {
			refresh();
		}
		
		/**
		 * 根据容器大小和当前Panel设置的大小重新设置可视区域
		 * 
		 */
		public function refresh():void {
			var percent:Number = _scrollBar.value / _scrollBar.maxValue;
			var scrollSize:Number;
			if (_scrollBar.direction == Direction.VERTICAL) {
				scrollSize = Math.max(0, _content.height - height);
				_content.y = -scrollSize * percent;
			} else {
				scrollSize = Math.max(0, _content.width - width);
				_content.x = -scrollSize * percent;
			}
		}
		
		protected function onMouseWheel(event:MouseEvent):void {
			_scrollBar.value -= event.delta;
		}
		
		override public function addChild(child:DisplayObject):DisplayObject {
			return _content.addChild(child);
		}
		
		override public function removeChild(child:DisplayObject):DisplayObject {
			return _content.removeChild(child);
		}
		
		override public function removeAllChildren():void {
			_content.removeAllChildren();
		}
		
		override protected function changeSize():void {
			_mask.width = _width;
			_mask.height = _height;
			if (_scrollBar.direction == Direction.VERTICAL) {
				_scrollBar.x = _width;
				_scrollBar.y = 0;
				_scrollBar.height = _height;
			} else {
				_scrollBar.x = 0;
				_scrollBar.y = _height;
				_scrollBar.width = _width;
			}
			super.changeSize();
		}
		
		override public function dispose():void {
			super.dispose();
			_scrollBar.dispatcher.removeEventListener(UIEvent.CHANGE, onScrollBarChange);
			addEventListener(MouseEvent.MOUSE_WHEEL, onMouseWheel);
		}
		
		public function get content():Container {
			return _content;
		}
		
		public function get scrollBar():ScrollBar {
			return _scrollBar;
		}
		
		public function get scrollBarSkin():String {
			return _scrollBar.skin;
		}
		
		public function set scrollBarSkin(value:String):void {
			_scrollBar.skin = value;
		}
		
		public function get direction():String {
			return _scrollBar.direction;
		}
		
		public function set direction(value:String):void {
			_scrollBar.direction = value;
		}
	}
}