package com.canaan.lib.base.component
{
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.display.BaseSprite;
	import com.canaan.lib.base.events.UIEvent;
	import com.canaan.lib.base.interfaces.IDispose;
	import com.canaan.lib.base.utils.ArrayUtil;
	
	import flash.display.Shape;
	import flash.events.Event;

	public class UIComponent extends BaseSprite implements IDispose
	{
		protected var _data:Object;
		protected var _x:Number = 0;
		protected var _y:Number = 0;
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		protected var _disabled:Boolean;
		
		protected var methods:Array = [];
		
		public function UIComponent()
		{
			tabEnabled = false;
			tabChildren = false;
			mouseChildren = false;
			preinitialize();
			createChildren();
			initialize();
		}
		
		protected function preinitialize():void {
			
		}
		
		protected function createChildren():void {
			
		}
		
		protected function initialize():void {
			
		}
		
		
		public function set data(value:Object):void {
			_data = value;
		}
		
		public function get data():Object {
			return _data;
		}
		
		public function set disabled(value:Boolean):void {
			if (_disabled != value) {
				_disabled = value;
				mouseEnabled = !disabled;
			}
		}
		
		public function get disabled():Boolean {
			return _disabled;
		}
		
		override public function set x(value:Number):void {
			if (_x != value) {
				_x = value;
				super.x = _x;
			}
		}
		
		override public function get x():Number {
			return _x;
		}
		
		override public function set y(value:Number):void {
			if (_y != value) {
				_y = value;
				super.y = _y;
			}
		}
		
		override public function get y():Number {
			return _y;
		}
		
		protected function changeSize():void {
			sendEvent(UIEvent.RESIZE);
		}
		
		override public function set width(value:Number):void {
			if (_width != value) {
				_width = value;
				callLater(changeSize);
			}
		}
		
		override public function get width():Number {
			if (_width == 0) {
				validateNow();
				return super.width;
			} else {
				return _width;
			}
		}
		
		override public function set height(value:Number):void {
			if (_height != value) {
				_height = value;
				callLater(changeSize);
			}
		}
		
		override public function get height():Number {
			if (_height == 0) {
				validateNow();
				return super.height;
			} else {
				return _height;
			}
		}
		
		public function get realX():Number {
			return super.x;
		}
		
		public function get realY():Number {
			return super.y;
		}
		
		public function get realWidth():Number {
			return super.width;
		}
		
		public function get realHeight():Number {
			return super.height;
		}
		
		public function callLater(func:Function, args:Array = null):void {
			var methodElement:MethodElement = ArrayUtil.find(methods, "func", func) as MethodElement;
			if (methodElement != null) {
				methodElement.args = args;
			} else {
				methods.push(new MethodElement(func, args));
			}
			invalidate();
		}
		
		protected function invalidate():void {
			addEventListener(Event.RENDER, onValidate);
			addEventListener(Event.ENTER_FRAME, onValidate);
			if (Application.stage != null) {
				Application.stage.invalidate();
			}
		}
		
		protected function onValidate(event:Event):void {
			removeEventListener(Event.RENDER, onValidate);
			removeEventListener(Event.ENTER_FRAME, onValidate);
			excuteMethods();
			sendEvent(UIEvent.RENDER_COMPLETE);
		}
		
		public function validateNow():void {
			if (methods.length > 0) {
				onValidate(null);
			}
			validateChildren();
		}
		
		protected function validateChildren():void {
			var child:UIComponent;
			for (var i:int = 0; i < numChildren; i++) {
				child = getChildAt(i) as UIComponent;
				if (child != null) {
					child.validateNow();
				}
			}
		}
		
		protected function excuteMethods():void {
			if (methods != null) {
				while (methods.length > 0) {
					excute(methods.shift());
				}
			}
		}
		
		protected function excute(methodElement:MethodElement):void {
			methodElement.apply();
		}
		
		public function sendEvent(type:String, data:Object = null):void {
			if (hasEventListener(type)) {
				dispatchEvent(new UIEvent(type, data));
			}
		}
		
		override public function dispose():void {
			super.dispose();
			methods.length = 0;
			methods = null;
		}
		
		public function showBorder(color:uint = 0xff0000):void {
			if (getChildByName("border") == null) {
				var border:Shape = new Shape();
				border.name = "border";
				border.graphics.lineStyle(1, color);
				border.graphics.drawRect(0, 0, width, height);
				addChild(border);
			}
		}
	}
}