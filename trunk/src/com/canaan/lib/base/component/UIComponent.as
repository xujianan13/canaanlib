package com.canaan.lib.base.component
{
	import com.canaan.lib.base.component.layout.Layout;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.display.BaseSprite;
	import com.canaan.lib.base.events.CEventDispatcher;
	import com.canaan.lib.base.events.UIEvent;
	import com.canaan.lib.base.interfaces.IDispose;
	import com.canaan.lib.base.managers.StageManager;
	import com.canaan.lib.base.managers.ToolTipManager;
	import com.canaan.lib.base.utils.ArrayUtil;
	
	import flash.display.Shape;
	import flash.events.Event;
	import flash.geom.Point;

	[Event(name="renderCompleted", type="com.canaan.lib.base.events.UIEvent")]
	[Event(name="resize", type="com.canaan.lib.base.events.UIEvent")]
	[Event(name="toolTipChanged", type="com.canaan.lib.base.events.UIEvent")]
	[Event(name="toolTipStart", type="com.canaan.lib.base.events.UIEvent")]
	[Event(name="toolTipShow", type="com.canaan.lib.base.events.UIEvent")]
	[Event(name="toolTipHide", type="com.canaan.lib.base.events.UIEvent")]
	
	public class UIComponent extends BaseSprite implements IUIComponent, IToolTipManagerClient, IDispose
	{
		private var _dispatcher:CEventDispatcher;
		protected var _data:Object;
		protected var _x:Number = 0;
		protected var _y:Number = 0;
		protected var _width:Number = 0;
		protected var _height:Number = 0;
		protected var _enabled:Boolean = true;
		protected var _toolTip:Object;
		protected var _toolTipClass:Class;
		protected var _toolTipPosition:String;
		protected var _toolTipOffset:Point;
		
		protected var methods:Vector.<Method> = new Vector.<Method>();
		protected var layoutObject:Layout;
		
		public function UIComponent()
		{
			_dispatcher = new CEventDispatcher();
			tabEnabled = false;
			tabChildren = false;
			mouseChildren = false;
			enabled = true;
			preinitialize();
			createChildren();
			initialize();
		}
		
		protected function preinitialize():void {
			
		}
		
		protected function createChildren():void {
			
		}
		
		protected function initialize():void {
			layoutObject = new Layout();
			layoutObject.target = this;
		}
		
		public function get dispatcher():CEventDispatcher {
			return _dispatcher;
		}
		
		public function get data():Object {
			return _data;
		}
		
		public function set data(value:Object):void {
			_data = value;
		}
		
		public function get enabled():Boolean {
			return _enabled;
		}
		
		public function set enabled(value:Boolean):void {
			if (_enabled != value) {
				_enabled = value;
				mouseEnabled = _enabled;
			}
		}
		
		public function setFocus():void {
			if (StageManager.getInstance().stage) {
				StageManager.getInstance().stage.focus = this;
			}
		}
		
		override public function get x():Number {
			return _x;
		}
		
		override public function set x(value:Number):void {
			if (_x != value) {
				_x = value;
				super.x = _x;
			}
		}
		
		override public function get y():Number {
			return _y;
		}
		
		override public function set y(value:Number):void {
			if (_y != value) {
				_y = value;
				super.y = _y;
			}
		}
		
		protected function changeSize():void {
			sendEvent(UIEvent.RESIZE);
		}
		
		override public function get width():Number {
			if (_width == 0) {
				validateNow();
				return super.width;
			} else {
				return _width;
			}
		}
		
		override public function set width(value:Number):void {
			if (_width != value) {
				_width = value;
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
		
		override public function set height(value:Number):void {
			if (_height != value) {
				_height = value;
				callLater(changeSize);
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
			var method:Method = ArrayUtil.find(methods, "func", func) as Method;
			if (method != null) {
				method.args = args;
			} else {
				methods.push(new Method(func, args));
			}
			invalidate();
		}
		
		protected function invalidate():void {
			addEventListener(Event.RENDER, onValidate);
			addEventListener(Event.ENTER_FRAME, onValidate);
			if (StageManager.getInstance().stage != null) {
				StageManager.getInstance().stage.invalidate();
			}
		}
		
		protected function onValidate(event:Event):void {
			removeEventListener(Event.RENDER, onValidate);
			removeEventListener(Event.ENTER_FRAME, onValidate);
			excuteMethods();
			sendEvent(UIEvent.RENDER_COMPLETED);
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
		
		protected function excute(method:Method):void {
			method.apply();
		}
		
		public function sendEvent(type:String, data:Object = null):void {
			if (_dispatcher.hasEventListener(type)) {
				var event:UIEvent = UIEvent.fromPool(type, data);
				_dispatcher.dispatchEvent(event);
				UIEvent.toPool(event);
			}
		}
		
		override public function dispose():void {
			super.dispose();
			methods.length = 0;
			methods = null;
			layoutObject.dispose();
			dispatcher.removeEventListeners();
		}
		
		public function get toolTip():Object {
			return _toolTip;
		}
		
		public function set toolTip(value:Object):void {
			if (_toolTip != value) {
				var oldValue:Object = _toolTip;
				_toolTip = value;
				ToolTipManager.getInstance().registerToolTip(this, oldValue, value);
				sendEvent(UIEvent.TOOL_TIP_CHANGED);
			}
		}
		
		public function get toolTipClass():Class {
			return _toolTipClass;
		}
		
		public function set toolTipClass(value:Class):void {
			_toolTipClass = value;
		}
		
		public function get toolTipPosition():String {
			return _toolTipPosition;
		}
		
		public function set toolTipPosition(value:String):void {
			_toolTipPosition = value;
		}
		
		public function get toolTipOffset():Point {
			return _toolTipOffset;
		}
		
		public function set toolTipOffset(value:Point):void {
			_toolTipOffset = value;
		}
		
		public function get top():Number {
			return layoutObject.top;
		}
		
		public function set top(value:Number):void {
			layoutObject.top = value;
		}
		
		public function get bottom():Number {
			return layoutObject.bottom;
		}
		
		public function set bottom(value:Number):void {
			layoutObject.bottom = value;
		}
		
		public function get left():Number {
			return layoutObject.left;
		}
		
		public function set left(value:Number):void {
			layoutObject.left = value;
		}
		
		public function get right():Number {
			return layoutObject.right;
		}
		
		public function set right(value:Number):void {
			layoutObject.right = value;
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