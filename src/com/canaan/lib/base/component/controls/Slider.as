package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Direction;
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.component.UIComponent;
	import com.canaan.lib.base.events.UIEvent;
	import com.canaan.lib.base.managers.StageManager;
	
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
	[Event(name="change", type="com.canaan.lib.base.events.UIEvent")]
	
	public class Slider extends UIComponent
	{
		private static const BUTTON_SKIN_SUFFIX:String = "$bar";
		
		protected var _skin:String;
		protected var _minValue:Number = 0;
		protected var _maxValue:Number = 100;
		protected var _value:Number = 0;
		protected var _tick:Number = 1;
		protected var _direction:String = Direction.HORIZONTAL;
		protected var _showLabel:Boolean;
		protected var _button:Button;
		
		protected var background:Image;
		protected var label:Label;
		
		public function Slider(skin:String = null)
		{
			this.skin = skin;
		}
		
		override protected function preinitialize():void {
			mouseChildren = true;
		}
		
		override protected function createChildren():void {
			background = new Image();
			addChild(background);
			_button = new Button();
			addChild(_button);
			label = new Label();
			addChild(label);
		}
		
		override protected function initialize():void {
			super.initialize();
			background.scale9 = Styles.sliderBackgroundScale9Grid;
			background.addEventListener(MouseEvent.MOUSE_DOWN, onBackgroundMouseDown);
			_button.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
		}
		
		protected function onBackgroundMouseDown(event:MouseEvent):void {
			if (_direction == Direction.HORIZONTAL) {
				value = background.mouseX / (background.width - _button.width) * (_maxValue - _minValue) + _minValue;
			} else {
				value = background.mouseY / (background.height - _button.height) * (_maxValue - _minValue) + _minValue;
			}
		}
		
		protected function onButtonMouseDown(event:MouseEvent):void {
			StageManager.getInstance().registerHandler(MouseEvent.MOUSE_UP, onStageMouseUp);
			StageManager.getInstance().registerHandler(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			if (_direction == Direction.HORIZONTAL) {
				_button.startDrag(false, new Rectangle(0, _button.y, background.width - _button.width, 0));
			} else {
				_button.startDrag(false, new Rectangle(_button.x, 0, 0, background.height - _button.height));
			}
			updateValue();
		}
		
		protected function onStageMouseUp():void {
			StageManager.getInstance().deleteHandler(MouseEvent.MOUSE_UP, onStageMouseUp);
			StageManager.getInstance().deleteHandler(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			_button.stopDrag();
			hideValueText();
		}
		
		protected function onStageMouseMove():void {
			var lastValue:Number = _value;
			if (_direction == Direction.HORIZONTAL) {
				_value = _button.realX / (background.width - _button.width) * (_maxValue - _minValue) + _minValue;
			} else {
				_value = _button.realY / (background.height - _button.height) * (_maxValue - _minValue) + _minValue;
			}
			_value = Math.round(_value / _tick) * _tick;
			if (_value != lastValue) {
				updateValue();
				sendEvent(UIEvent.CHANGE);
			}
		}
		
		protected function updateValue():void {
			if (_showLabel) {
				label.text = _value.toString();
				if (_direction == Direction.HORIZONTAL) {
					label.x = (_button.width - label.width) * 0.5 + _button.realX;
					label.y = _button.y - 20;
				} else {
					label.x = _button.x + 20;
					label.y = (_button.height - label.height) * 0.5 + _button.realY;
				}
			}
		}
		
		protected function hideValueText():void {
			label.text = "";
		}
		
		override protected function changeSize():void {
			super.changeSize();
			background.width = _width;
			background.height = _height;
			resetButtonPosition();
			changeValue();
		}
		
		private function resetButtonPosition():void {
			if (_direction == Direction.HORIZONTAL) {
				_button.y = (background.height - _button.height) * 0.5;
			} else {
				_button.x = (background.width - _button.width) * 0.5;
			}
		}
		
		private function changeValue():void {
			_value = Math.min(_maxValue, Math.max(_minValue, _value));
			if (_direction == Direction.HORIZONTAL) {
				_button.x = (_value - _minValue) / (_maxValue - _minValue) * (background.width - _button.width);
			} else {
				_button.y = (_value - _minValue) / (_maxValue - _minValue) * (background.height - _button.height);
			}
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				background.url = _skin;
				_button.skin = _skin + BUTTON_SKIN_SUFFIX;
				_button.validateNow();
				_width = _width || background.width;
				_height = _height || background.height;
				resetButtonPosition();
			}
		}
		
		public function get skin():String {
			return _skin;
		}
		
		public function set value(num:Number):void {
			num = Math.round(num / _tick) * _tick;
			num = Math.min(_maxValue, Math.max(_minValue, num));
			if (_value != num) {
				_value = num;
				changeValue();
				sendEvent(UIEvent.CHANGE);
			}
		}
		
		public function get value():Number {
			return _value;
		}
		
		public function set minValue(value:Number):void {
			if (_minValue != value) {
				_minValue = value;
				callLater(changeValue);
			}
		}
		
		public function get minValue():Number {
			return _minValue;
		}
		
		public function set maxValue(value:Number):void {
			if (_maxValue != value) {
				_maxValue = value;
				callLater(changeValue);
			}
		}
		
		public function get maxValue():Number {
			return _maxValue;
		}
		
		public function set tick(value:Number):void {
			_tick = value;
			callLater(changeValue);
		}
		
		public function get tick():Number {
			return _tick;
		}

		public function set direction(value:String):void {
			_direction = value;
		}
		
		public function get direction():String {
			return _direction;
		}
		
		public function setSlider(minValue:Number, maxValue:Number, value:Number):void {
			_minValue = minValue;
			_maxValue = maxValue;
			this.value = value;
		}
		
		public function set scale9(value:String):void {
			background.scale9 = value;
		}
		
		public function get scale9():String {
			return background.scale9;
		}
		
		public function set showLabel(value:Boolean):void {
			if (_showLabel != value) {
				_showLabel = value;
			}
		}
		
		public function get showLabel():Boolean {
			return _showLabel;
		}
		
		public function get button():Button {
			return _button;
		}
		
		override public function dispose():void {
			super.dispose();
			background.removeEventListener(MouseEvent.MOUSE_DOWN, onBackgroundMouseDown);
			_button.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			StageManager.getInstance().stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			StageManager.getInstance().stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
		}
	}
}