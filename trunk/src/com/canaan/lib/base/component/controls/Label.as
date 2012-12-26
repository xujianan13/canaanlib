package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.component.UIComponent;
	import com.canaan.lib.base.events.UIEvent;
	import com.canaan.lib.base.managers.ResourceManager;
	import com.canaan.lib.base.utils.ArrayUtil;
	import com.canaan.lib.base.utils.DisplayUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	[Event(name="change", type="com.canaan.lib.base.events.UIEvent")]
	
	public class Label extends UIComponent
	{
		protected var _skin:String;
		protected var _bitmap:Bitmap
		protected var _textField:TextField;
		protected var _text:String;
		protected var _format:TextFormat;
		protected var _htmlMode:Boolean;
		protected var _stroke:String;
		protected var _scale9:Array;
		
		public function Label(text:String = "", skin:String = null)
		{
			this.text = text;
			this.skin = skin;
		}
		
		override protected function preinitialize():void {
			mouseChildren = false;
			_format = new TextFormat(Styles.fontName, Styles.fontSize, Styles.labelColor);
			_scale9 = Styles.labelScale9Grid;
		}
		
		override protected function createChildren():void {
			_bitmap = new Bitmap();
			addChild(_bitmap);
			_textField = new TextField();
			addChild(_textField);
		}
		
		override protected function initialize():void {
			super.initialize();
			_textField.selectable = false;
			_textField.autoSize = TextFieldAutoSize.LEFT;
			stroke = Styles.labelStroke.toString();
		}
		
		protected function changeText():void {
			_textField.defaultTextFormat = _format;
			_htmlMode ? _textField.htmlText = _text : _textField.text = _text;
		}
		
		public function get text():String {
			return _text;
		}
		
		public function set text(value:String):void {
			if (_text != value) {
				_text = value || "";
				callLater(changeText);
				sendEvent(UIEvent.CHANGE);
			}
		}
		
		public function get skin():String {
			return _skin;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				callLater(changeBitmap);
			}
		}
		
		protected function changeBitmap():void {
			if (_skin && ResourceManager.getInstance().hasClass(_skin)) {
				var bmd:BitmapData = ResourceManager.getInstance().getBitmapData(_skin);
				_width = _width || bmd.width;
				_height = _height || bmd.height;
				_bitmap.bitmapData = DisplayUtil.scale9Bmd(bmd, _scale9, _width, _height);
			}
		}
		
		public function get scale9():String {
			return _scale9.toString();
		}
		
		public function set scale9(value:String):void {
			_scale9 = ArrayUtil.copyAndFill(_scale9, value);
			callLater(changeBitmap);
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			callLater(changeBitmap);
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			callLater(changeBitmap);
		}
		
		public function get htmlMode():Boolean {
			return _htmlMode;
		}
		
		public function set htmlMode(value:Boolean):void {
			if (_htmlMode != value) {
				_htmlMode = value;
				callLater(changeText);
			}
		}
		
		override protected function changeSize():void {
			if (_width != 0) {
				_textField.autoSize = TextFieldAutoSize.NONE;
				_textField.width = _width;
				_textField.height = _height == 0 ? Styles.labelHeight : _height;
			} else {
				_width = _height = 0;
				_textField.autoSize = TextFieldAutoSize.LEFT;
			}
			super.changeSize();
		}
		
		public function get stroke():String {
			return _stroke;
		}
		
		public function set stroke(value:String):void {
			if (_stroke != value) {
				_stroke = value;
				DisplayUtil.removeFilter(_textField, GlowFilter);
				if (_stroke != null) {
					var args:Array = ArrayUtil.copyAndFill(Styles.labelStroke, _stroke);
					DisplayUtil.addFilter(_textField, new GlowFilter(args[0], args[1], args[2], args[3], args[4], args[5]));
				}
			}
		}
		
		public function appendText(newText:String):void {
			_text += newText;
			callLater(changeText);
		}
		
		// TextField proxy
		public function get textField():TextField {
			return _textField;
		}
		
		public function get selectable():Boolean {
			return _textField.selectable;
		}
		
		public function set selectable(value:Boolean):void {
			_textField.selectable = value;
			mouseChildren = value;
//			mouseEnabled = value;
		}
		
		public function get multiline():Boolean {
			return _textField.multiline;
		}
		
		public function set multiline(value:Boolean):void {
			_textField.multiline = value;
		}
		
		public function get wordWrap():Boolean {
			return _textField.wordWrap;
		}
		
		public function set wordWrap(value:Boolean):void {
			_textField.wordWrap = value;
		}
		
		public function get autoSize():String {
			return _textField.autoSize;
		}
		
		public function set autoSize(value:String):void {
			_textField.autoSize = value;
		}
		
		public function get displayAsPassword():Boolean {
			return _textField.displayAsPassword;
		}
		
		public function set displayAsPassword(value:Boolean):void {
			_textField.displayAsPassword = value;
		}
		
		public function get color():Object {
			return _format.color;
		}
		
		public function set color(value:Object):void {
			if (int(_format.color) != int(value)) {
				_format.color = value;
				callLater(changeText);
			}
		}
		
		public function get font():String {
			return _format.font;
		}
		
		public function set font(value:String):void {
			if (_format.font != value) {
				_format.font = value;
				callLater(changeText);
			}
		}
		
		public function get size():Object {
			return _format.size;
		}
		
		public function set size(value:Object):void {
			if (int(_format.size) != int(value)) {
				_format.size = value;
				callLater(changeText);
			}
		}
		
		public function get align():String {
			return _format.align;
		}
		
		public function set align(value:String):void {
			if (_format.align != value) {
				_format.align = value;
				callLater(changeText);
			}
		}
		
		public function get bold():Object {
			return _format.bold;
		}
		
		public function set bold(value:Object):void {
			if (Boolean(_format.bold) != Boolean(value)) {
				_format.bold = value;
				callLater(changeText);
			}
		}
		
		public function get leading():Object {
			return _format.leading;
		}
		
		public function set leading(value:Object):void {
			if (int(_format.leading) != int(value)) {
				_format.leading = value;
				callLater(changeText);
			}
		}
		
		public function get indent():Object {
			return _format.indent;
		}
		
		public function set indent(value:Object):void {
			if (int(_format.indent) != int(value)) {
				_format.indent = value;
				callLater(changeText);
			}
		}
		
		public function get underline():Object {
			return _format.underline;
		}
		
		public function set underline(value:Object):void {
			if (Boolean(_format.underline) != Boolean(value)) {
				_format.underline = value;
				callLater(changeText);
			}
		}
		
		public function get leftMargin():Object {
			return _format.leftMargin;
		}
		
		public function set leftMargin(value:Object):void {
			if (int(_format.leftMargin) != int(value)) {
				_format.leftMargin = value;
				callLater(changeText);
			}
		}
		
		public function get rightMargin():Object {
			return _format.rightMargin;
		}
		
		public function set rightMargin(value:Object):void {
			if (int(_format.rightMargin) != int(value)) {
				_format.rightMargin = value;
				callLater(changeText);
			}
		}
		
		public function get format():TextFormat {
			return _format;
		}
		
		public function set format(value:TextFormat):void {
			_format = value;
			callLater(changeText);
		}
	}
}