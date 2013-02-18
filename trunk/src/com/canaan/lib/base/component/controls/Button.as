package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.IListItem;
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.component.UIComponent;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.ResourceManager;
	import com.canaan.lib.base.utils.ArrayUtil;
	import com.canaan.lib.base.utils.DisplayUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	
	public class Button extends UIComponent implements IListItem
	{
		protected var states:Object = {
			mouseDown:2,
			mouseUp:1,
			rollOver:1,
			rollOut:0,
			selected:2
		};
		protected var bitmap:Bitmap;
		protected var tiles:Vector.<BitmapData>;
		protected var skinW:int = Styles.buttonSkinW;
		protected var skinH:int = Styles.buttonSkinH;
		protected var scale9Mode:Boolean = true;
		
		protected var _skin:String;
		protected var _btnLabel:Label;
		protected var _state:int;
		protected var _toggle:Boolean;
		protected var _labelColors:Array = Styles.buttonLabelColors;
		protected var _labelMargin:Array = Styles.buttonLabelMargin;
		protected var _selected:Boolean;
		protected var _mouseClickHandler:Method;
		protected var _scale9:Array;
		
		public function Button(skin:String = null, label:String = "")
		{
			this.skin = skin;
			this.label = label;
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			_scale9 = Styles.buttonScale9Grid;
		}
		
		override protected function createChildren():void {
			bitmap = new Bitmap();
			addChild(bitmap);
			_btnLabel = new Label();
			addChild(_btnLabel);
		}
		
		override protected function initialize():void {
			super.initialize();
			_btnLabel.align = TextFormatAlign.CENTER;
			addEventListener(MouseEvent.CLICK, mouseHandler);
			addEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			addEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			addEventListener(MouseEvent.ROLL_OVER, mouseHandler);
			addEventListener(MouseEvent.ROLL_OUT, mouseHandler);
		}
		
		override public function dispose():void {
			super.dispose();
			removeEventListener(MouseEvent.CLICK, mouseHandler);
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseHandler);
			removeEventListener(MouseEvent.MOUSE_UP, mouseHandler);
			removeEventListener(MouseEvent.ROLL_OVER, mouseHandler);
			removeEventListener(MouseEvent.ROLL_OUT, mouseHandler);
		}
		
		protected function mouseHandler(event:MouseEvent):void {
			if (!_toggle && _selected || !_enabled) {
				return;
			}
			if (event.type == MouseEvent.CLICK) {
				if (_mouseClickHandler) {
					_mouseClickHandler.apply();
				}
				if (_toggle) {
					selected = !_selected;
				}
				return;
			}
			if (!_selected) {
				state = states[event.type];
			}
		}
		
		protected function set state(value:int):void {
			_state = value;
			callLater(changeState);
		}
		
		protected function changeTiles():void {
			tiles = ResourceManager.getInstance().getTiles(_skin, skinW, skinH, false);
			if (tiles != null && scale9Mode) {
				_width = _width || tiles[0].width;
				_height = _height || tiles[0].height;
				var length:int = tiles.length;
				for (var i:int = 0; i < length; i++) {
					tiles[i] = DisplayUtil.scale9Bmd(tiles[i], _scale9, _width, _height);
				}
			}
		}
		
		protected function changeState():void {
			if (tiles != null) {
				bitmap.bitmapData = tiles[_state];
			}
			_btnLabel.color = _labelColors[_state];
		}
		
		protected function changeLabelSize():void {
			_btnLabel.validateNow();
			_btnLabel.width = bitmap.width - _labelMargin[0] - _labelMargin[2];
			_btnLabel.autoSize = TextFieldAutoSize.LEFT;
			_btnLabel.height = _btnLabel.textField.height;
			_btnLabel.autoSize = TextFieldAutoSize.NONE;
			_btnLabel.x = _labelMargin[0];
			_btnLabel.y = (bitmap.height - _btnLabel.height) * 0.5 + _labelMargin[1] - _labelMargin[3];
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				callLater(changeTiles);
				callLater(changeState);
				callLater(changeLabelSize);
			}
		}
		
		public function get skin():String {
			return _skin;
		}
		
		public function set label(value:String):void {
			if (_btnLabel.text != value) {
				_btnLabel.text = value;
				callLater(changeTiles);
				callLater(changeState);
				callLater(changeLabelSize);
			}
		}
		
		public function get label():String {
			return _btnLabel.text;
		}
		
		public function set toggle(value:Boolean):void {
			if (_toggle != value) {
				_toggle = value;
			}
		}
		
		public function get toggle():Boolean {
			return _toggle;
		}
		
		override public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				super.enabled = value;
				state = states["rollOut"];
				DisplayUtil.gray(this, !_enabled);
			}
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			callLater(changeTiles);
			callLater(changeState);
			callLater(changeLabelSize);
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			callLater(changeTiles);
			callLater(changeState);
			callLater(changeLabelSize);
		}
		
		public function get scale9():String {
			return _scale9.toString();
		}
		
		public function set scale9(value:String):void {
			_scale9 = ArrayUtil.copyAndFill(_scale9, value);
			callLater(changeTiles);
			callLater(changeState);
		}
		
		public function set labelColors(value:String):void {
			_labelColors = ArrayUtil.copyAndFill(_labelColors, value);
			callLater(changeState);
		}
		
		public function get labelColors():String {
			return String(_labelColors);
		}
		
		public function set labelMargin(value:String):void {
			_labelMargin = ArrayUtil.copyAndFill(_labelMargin, value);
			callLater(changeLabelSize);
		}
		
		public function set labelSize(value:Object):void {
			_btnLabel.size = value
			callLater(changeLabelSize);
		}
		
		public function get labelSize():Object {
			return _btnLabel.size;
		}
		
		public function set labelStroke(value:String):void {
			_btnLabel.stroke = value;
		}

		public function get labelStroke():String {
			return _btnLabel.stroke;
		}
		
		public function get labelMargin():String {
			return _labelMargin.toString();
		}
		
		public function set labelBold(value:Object):void {
			_btnLabel.bold = value;
			callLater(changeLabelSize);
		}
		
		public function get labelBold():Object {
			return _btnLabel.bold;
		}
		
		public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
				state = _selected ? states["selected"] : states["rollOut"];
			}
		}
		
		public function get selected():Boolean {
			return _selected;
		}
		
		public function set mouseClickHandler(value:Method):void {
			if (_mouseClickHandler != value) {
				_mouseClickHandler = value;
			}
		}
		
		public function get mouseClickHandler():Method {
			return _mouseClickHandler;
		}
		
		public function get btnLabel():Label {
			return _btnLabel;
		}
	}
}