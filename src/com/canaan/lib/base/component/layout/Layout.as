package com.canaan.lib.base.component.layout
{
	import com.canaan.lib.base.component.UIComponent;
	
	import flash.display.DisplayObjectContainer;

	public class Layout
	{
		protected var _layout:String;
		protected var _target:UIComponent;
		
		protected var _top:Number;
		protected var _bottom:Number;
		protected var _left:Number;
		protected var _right:Number;
		
		public function Layout()
		{
		}

		public function set target(value:UIComponent):void {
			if (_target != value) {
				dispose();
				_target = value;
			}
		}
		
		public function get target():UIComponent {
			return _target;
		}
		
		protected function callLater(func:Function, args:Array = null):void {
			_target.callLater(func, args);
		}
		
		public function dispose():void {
			if (_target != null) {
				_target = null;
			}
		}
		
		public function set top(value:Number):void {
			_top = value;
			callLater(updatePosition);
		}
		
		public function get top():Number {
			return _top;
		}
		
		public function set bottom(value:Number):void {
			_bottom = value;
			callLater(updatePosition);
		}
		
		public function get bottom():Number {
			return _bottom;
		}
		
		public function set left(value:Number):void {
			_left = value;
			callLater(updatePosition);
		}
		
		public function get left():Number {
			return _left;
		}
		
		public function set right(value:Number):void {
			_right = value;
			callLater(updatePosition);
		}
		
		public function get right():Number {
			return _right;
		}
		
		protected function updatePosition():void {
			var _targetParent:DisplayObjectContainer = _target.parent;
			if (_targetParent != null) {
				if (!isNaN(_left)) {
					_target.x = _left;
					if (!isNaN(_right)) {
						_target.width = _targetParent.width - _left - _right;
					}
				} else if (!isNaN(_right)) {
					_target.x = _targetParent.width - _target.width - _right;
				}
				if (!isNaN(_top)) {
					_target.y = _top;
					if (!isNaN(_bottom)) {
						_target.height = _targetParent.height - _top - _bottom;
					}
				} else if (!isNaN(_bottom)) {
					_target.y = _targetParent.height - _target.height - _bottom;
				}
			}
		}
	}
}