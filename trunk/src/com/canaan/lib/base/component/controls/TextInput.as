package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Styles;
	
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;

	public class TextInput extends Label
	{
		public function TextInput(text:String = "")
		{
			super(text);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			width = Styles.textInputWidth;
			height = Styles.textInputHeight;
		}
		
		override protected function initialize():void {
			super.initialize();
			selectable = true;
			_textField.type = TextFieldType.INPUT;
			_textField.autoSize = TextFieldAutoSize.NONE;
		}
		
		public function set maxChars(value:int):void {
			_textField.maxChars = value;
		}
		
		public function get maxChars():int {
			return _textField.maxChars;
		}
		
		public function set border(value:Boolean):void {
			if (_textField.border != value) {
				_textField.border = value;
				validateNow();
			}
		}
		
		public function get border():Boolean {
			return _textField.border;
		}
		
		public function set borderColor(value:uint):void {
			_textField.borderColor = value;
		}
		
		public function get borderColor():uint {
			return _textField.borderColor;
		}
		
		public function set background(value:Boolean):void {
			if (_textField.background != value) {
				_textField.background = value;
				validateNow();
			}
		}
		
		public function get background():Boolean {
			return _textField.background;
		}
		
		public function set backgroundColor(value:uint):void {
			_textField.backgroundColor = value;
		}
		
		public function get backgroundColor():uint {
			return _textField.backgroundColor;
		}
		
		public function set restrict(value:String):void {
			_textField.restrict = value;
		}
		
		public function get restrict():String {
			return _textField.restrict;
		}
		
		public function set editable(value:Boolean):void {
			_textField.type = value ? TextFieldType.INPUT : TextFieldType.DYNAMIC;
		}
		
		public function get editable():Boolean {
			return _textField.type == TextFieldType.INPUT;
		}
	}
}