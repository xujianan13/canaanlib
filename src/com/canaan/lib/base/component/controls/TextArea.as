package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.events.UIEvent;
	
	import flash.events.Event;

	public class TextArea extends TextInput
	{
		protected var scrollBar:VScrollBar;
		
		public function TextArea(text:String = null)
		{
			super(text);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			width = Styles.textAreaWidth;
			height = Styles.textAreaHeight;
		}
		
		override protected function createChildren():void {
			super.createChildren();
			scrollBar = new VScrollBar();
			addChild(scrollBar);
		}
		
		override protected function initialize():void {
			super.initialize();
			wordWrap = true;
			multiline = true;
			_textField.addEventListener(Event.SCROLL, onTextFieldScroll);
			scrollBar.addEventListener(UIEvent.CHANGE, onScrollBarChange);
		}
		
		protected function onTextFieldScroll(event:Event):void {
			scrollBar.setScroll(1, _textField.maxScrollV, _textField.scrollV);
		}
		
		protected function onScrollBarChange(event:UIEvent):void {
			_textField.scrollV = Math.round(scrollBar.value);
		}
		
		override protected function changeSize():void {
			_textField.width = _width - scrollBar.width - Styles.textAreaTextOffsetX;
			_textField.height = _height;
			scrollBar.height = _height;
			scrollBar.x = _width - scrollBar.width;
		}
		
		public function set scrollBarSkin(value:String):void {
			scrollBar.skin = value;
		}
		
		public function get scrollBarSkin():String {
			return scrollBar.skin;
		}
		
		override public function dispose():void {
			super.dispose();
			_textField.removeEventListener(Event.SCROLL, onTextFieldScroll);
			scrollBar.removeEventListener(UIEvent.CHANGE, onScrollBarChange);
		}
	}
}