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
		protected var slider:Slider;
		
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
			slider = new Slider();
			addChild(slider);
		}
		
		override protected function initialize():void {
			super.initialize();
			upButton.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			downButton.addEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			slider.showLabel = false;
			slider.dispatcher.addEventListener(UIEvent.CHANGE, onSliderChange);
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
			if (slider.direction == Direction.HORIZONTAL) {
				slider.width = width - upButton.width - downButton.width;
			} else {
				slider.height = height - upButton.height - downButton.height;
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
				slider.skin = _skin;
				upButton.skin = _skin + UP_BUTTON_SKIN_SUFFIX;
				downButton.skin = _skin + DOWN_BUTTON_SKIN_SUFFIX;
				callLater(changeScrollBar);
			}
		}
		
		public function get skin():String {
			return _skin;
		}
		
		protected function changeScrollBar():void {
			if (slider.direction == Direction.HORIZONTAL) {
				slider.x = upButton.width;
			} else {
				slider.y = upButton.height;
			}
			resetButtonPosition();
		}
		
		protected function resetButtonPosition():void {
			if (slider.direction == Direction.HORIZONTAL) {
				downButton.x = slider.x + slider.width;
			} else {
				downButton.y = slider.y + slider.height;
			}
		}
		
		public function setScroll(minValue:Number, maxValue:Number, value:Number):void {
			slider.setSlider(minValue, maxValue, value);
			upButton.enabled = maxValue > 0;
			downButton.enabled = maxValue > 0;
			slider.button.visible = maxValue > 0;
		}
		
		public function set value(num:Number):void {
			slider.value = num;
		}
		
		public function get value():Number {
			return slider.value;
		}
		
		public function set maxValue(value:Number):void {
			slider.maxValue = value;
		}
		
		public function get maxValue():Number {
			return slider.maxValue;
		}
		
		public function set minValue(value:Number):void {
			slider.minValue = value;
		}
		
		public function get minValue():Number {
			return slider.minValue;
		}
		
		public function set scrollSize(value:Number):void {
			_scrollSize = value;
		}
		
		public function get scrollSize():Number {
			return _scrollSize;
		}
		
		public function set scale9(value:String):void {
			slider.scale9 = value;
		}
		
		public function get scale9():String {
			return slider.scale9;
		}
		
		public function set direction(value:String):void {
			slider.direction = value;
		}
		
		public function get direction():String {
			return slider.direction;
		}
		
		override public function dispose():void {
			super.dispose();
			upButton.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			downButton.removeEventListener(MouseEvent.MOUSE_DOWN, onButtonMouseDown);
			slider.dispatcher.removeEventListener(UIEvent.CHANGE, onSliderChange);
			onStageMouseUp();
		}
	}
}