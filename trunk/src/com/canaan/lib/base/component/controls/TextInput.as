package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Styles;
	
	import flash.events.Event;
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
			_textField.addEventListener(Event.CHANGE, onTextChanged);
		}
		
		protected function onTextChanged(event:Event):void {
			_text = _textField.text;
		}
		
		public function set maxChars(value:int):void {
			_textField.maxChars = value;
		}
		
		public function get maxChars():int {
			return _textField.maxChars;
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