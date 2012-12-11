package com.canaan.lib.base.component.layout
{
	import com.canaan.lib.base.component.Layouts;
	import com.canaan.lib.base.component.UIComponent;
	
	import flash.display.DisplayObjectContainer;
	
	public class ContainerLayout extends Layout
	{
		protected var _gap:Number = 0;
		protected var _top:Number;
		protected var _bottom:Number;
		protected var _left:Number;
		protected var _right:Number;
		
		public function ContainerLayout()
		{
			super();
			_layout = Layouts.ABSOLUTE;
		}
		
		public function set gap(value:Number):void {
			if (_gap != value) {
				_gap = value;
				callLater(updateDisplayList);
			}
		}
		
		public function get gap():Number {
			return _gap;
		}
		
		override public function updateDisplayList():void {
			if (_layout == Layouts.ABSOLUTE) {
				return;
			} else {
				var child:UIComponent;
				var num:int;
				for (var i:int = 0; i < _target.numChildren; i++) {
					child = _target.getChildAt(i) as UIComponent;
					if (child != null) {
						if (_layout == Layouts.HORIZONTAL) {
							child.x = num;
							child.y = 0;
							num += child.width + _gap;
						} else if (_layout == Layouts.VERTICAL) {
							child.x = 0;
							child.y = num;
							num += child.height + _gap;
						}
					}
				}
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