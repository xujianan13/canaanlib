package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Direction;
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.component.UIComponent;
	import com.canaan.lib.base.events.UIEvent;
	import com.canaan.lib.base.managers.StageManager;
	import com.canaan.lib.base.managers.TimerManager;
	
	import flash.events.MouseEvent;
	
	[Event(name="change", type="com.canaan.lib.base.events.UIEvent")]
	
	public class ScrollBar extends UIComponent
	{
		private static const UP_BUTTON_SKIN_SUFFIX:String = "$up";
		private static const DOWN_BUTTON_SKIN_SUFFIX:String = "$down";
		
		protected var _skin:String;
		protected var _scrollSize:Number = 1;
		
		protected var upButton:Button;
		protected var downButton:Button;
		protected var _slider:Slider;
		
		public function ScrollBar(skin:String = null)
		{
			this.skin = skin;
		}
		
		override protected function preinitialize():void {
			mouseChildren = true;
		}
		
		override protected function createChildren():void {
			upButton = new Button();
			addChild(upButton);
			downButton = new Button();
			addChild(downButton);
			_slider = new Slider();
			addChild(_slider);
		}
		
		override protected function initialize():void {
			super.initialize();
			upButton.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			downButton.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			_slider.showLabel = false;
			_slider.dispatcher.addEventListener(UIEvent.CHANGE, onSliderChange);
		}
		
		protected function onButtonMouseDown(event:MouseEvent):void {
			var isUp:Boolean = event.currentTarget == upButton;
			slide(isUp);
			TimerManager.getInstance().doOnce(Styles.scrollBarDelay, startLoop, [isUp]);
			StageManager.getInstance().registerHandler(MouseEvent.MOUSE_UP, onStageMouseUp);
		}
		
		protected function startLoop(isUp:Boolean):void {
			TimerManager.getInstance().doFrameLoop(1, slide, [isUp]);
		}
		
		protected function onSliderChange(event:UIEvent):void {
			sendEvent(UIEvent.CHANGE);
		}
		
		protected function onStageMouseUp():void {
			StageManager.getInstance().deleteHandler(MouseEvent.MOUSE_UP, onStageMouseUp);
			TimerManager.getInstance().clear(startLoop);
			TimerManager.getInstance().clear(slide);
		}
		
		override protected function changeSize():void {
			super.changeSize();
			if (_slider.direction == Direction.HORIZONTAL) {
				_slider.width = width - upButton.width - downButton.width;
			} else {
				_slider.height = height - upButton.height - downButton.height;
			}
			resetButtonPosition();
		}
		
		protected function slide(isUp:Boolean):void {
			if (isUp) {
				value -= _scrollSize;
			} else {
				value += _scrollSize;
			}
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				_slider.skin = _skin;
				upButton.skin = _skin + UP_BUTTON_SKIN_SUFFIX;
				downButton.skin = _skin + DOWN_BUTTON_SKIN_SUFFIX;
				callLater(changeScrollBar);
			}
		}
		
		public function get skin():String {
			return _skin;
		}
		
		protected function changeScrollBar():void {
			if (_slider.direction == Direction.HORIZONTAL) {
				_slider.x = upButton.width;
			} else {
				_slider.y = upButton.height;
			}
			resetButtonPosition();
		}
		
		protected function resetButtonPosition():void {
			if (_slider.direction == Direction.HORIZONTAL) {
				downButton.x = _slider.x + _slider.width;
			} else {
				downButton.y = _slider.y + _slider.height;
			}
		}
		
		public function setScroll(minValue:Number, maxValue:Number, value:Number):void {
			_slider.setSlider(minValue, maxValue, value);
			upButton.enabled = maxValue > 0;
			downButton.enabled = maxValue > 0;
			_slider.button.visible = maxValue > 0;
		}
		
		public function get sliderVisible():Boolean {
			return _slider.button.visible;
		}
		
		public function set sliderVisible(value:Boolean):void {
			_slider.button.visible = value;
		}
		
		public function set value(num:Number):void {
			_slider.value = num;
		}
		
		public function get value():Number {
			return _slider.value;
		}
		
		public function set maxValue(value:Number):void {
			_slider.maxValue = value;
		}
		
		public function get maxValue():Number {
			return _slider.maxValue;
		}
		
		public function set minValue(value:Number):void {
			_slider.minValue = value;
		}
		
		public function get minValue():Number {
			return _slider.minValue;
		}
		
		public function set scrollSize(value:Number):void {
			_scrollSize = value;
		}
		
		public function get scrollSize():Number {
			return _scrollSize;
		}
		
		public function set scale9(value:String):void {
			_slider.scale9 = value;
		}
		
		public function get scale9():String {
			return _slider.scale9;
		}
		
		public function set direction(value:String):void {
			_slider.direction = value;
		}
		
		public function get direction():String {
			return _slider.direction;
		}
		
		public function get slider():Slider {
			return _slider;
		}
		
		override public function dispose():void {
			super.dispose();
			upButton.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			downButton.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			_slider.dispatcher.removeEventListener(UIEvent.CHANGE, onSliderChange);
			onStageMouseUp();
		}
	}
}