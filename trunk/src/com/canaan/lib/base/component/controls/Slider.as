package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Direction;
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.component.UIComponent;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.events.UIEvent;
	
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	
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
		
		protected var background:Image;
		protected var button:Button;
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
			button = new Button();
			addChild(button);
			label = new Label();
			addChild(label);
		}
		
		override protected function initialize():void {
			background.scale9 = Styles.sliderBackgroundScale9Grid;
			background.addEventListener(MouseEvent.MOUSE_DOWN, onBackgroundMouseDown);
			button.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
		}
		
		protected function onBackgroundMouseDown(event:MouseEvent):void {
			if (_direction == Direction.HORIZONTAL) {
				value = background.mouseX / (background.width - button.width) * (_maxValue - _minValue) + _minValue;
			} else {
				value = background.mouseY / (background.height - button.height) * (_maxValue - _minValue) + _minValue;
			}
		}
		
		protected function onButtonMouseDown(event:MouseEvent):void {
			Application.stage.addEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			Application.stage.addEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			if (_direction == Direction.HORIZONTAL) {
				button.startDrag(false, new Rectangle(0, button.y, background.width - button.width, 0));
			} else {
				button.startDrag(false, new Rectangle(button.x, 0, 0, background.height - button.height));
			}
			updateValue();
		}
		
		protected function onStageMouseUp(event:MouseEvent):void {
			Application.stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			Application.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
			button.stopDrag();
			hideValueText();
		}
		
		protected function onStageMouseMove(event:MouseEvent):void {
			var lastValue:Number = _value;
			if (_direction == Direction.HORIZONTAL) {
				_value = button.realX / (background.width - button.width) * (_maxValue - _minValue) + _minValue;
			} else {
				_value = button.realY / (background.height - button.height) * (_maxValue - _minValue) + _minValue;
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
					label.x = (button.width - label.width) * 0.5 + button.realX;
					label.y = button.y - 20;
				} else {
					label.x = button.x + 20;
					label.y = (button.height - label.height) * 0.5 + button.realY;
				}
			}
		}
		
		protected function hideValueText():void {
			label.text = "";
		}
		
		override protected function changeSize():void {
			super.changeSize();
			if (_direction == Direction.HORIZONTAL) {
				background.width = _width;
			} else {
				background.height = _height;
			}
		}
		
		private function changeValue():void {
			_value = Math.min(_maxValue, Math.max(_minValue, _value));
			if (_direction == Direction.HORIZONTAL) {
				button.x = (_value - _minValue) / (_maxValue - _minValue) * (background.width - button.width);
			} else {
				button.y = (_value - _minValue) / (_maxValue - _minValue) * (background.height - button.height);
			}
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				background.url = _skin;
				button.skin = _skin + BUTTON_SKIN_SUFFIX;
				button.validateNow();
				if (_direction == Direction.HORIZONTAL) {
					button.y = (background.height - button.height) * 0.5;
				} else {
					button.x = (background.width - button.width) * 0.5;
				}
				_width = _width || background.width;
				_height = _height || background.height;
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
		
		override public function dispose():void {
			super.dispose();
			background.removeEventListener(MouseEvent.MOUSE_DOWN, onBackgroundMouseDown);
			button.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			Application.stage.removeEventListener(MouseEvent.MOUSE_UP, onStageMouseUp);
			Application.stage.removeEventListener(MouseEvent.MOUSE_MOVE, onStageMouseMove);
		}
	}
}