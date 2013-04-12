package com.canaan.lib.base.component.layout
{
	import com.canaan.lib.base.component.Layouts;
	import com.canaan.lib.base.component.UIComponent;
	
	import flash.display.DisplayObject;
	import flash.events.Event;
	
	public class ContainerLayout extends Layout
	{
		protected var _gap:Number = 0;
		
		public function ContainerLayout()
		{
			super();
			_layout = Layouts.ABSOLUTE;
		}
		
		override public function set target(value:UIComponent):void {
			if (_target != value) {
				super.target = value;
				_target.addEventListener(Event.ADDED, onAdded);
				_target.addEventListener(Event.REMOVED, onRemoved);
			}
		}
		
		override public function dispose():void {
			if (_target != null) {
				_target.removeEventListener(Event.ADDED, onAdded);
				_target.removeEventListener(Event.REMOVED, onRemoved);
				super.dispose();
			}
		}
		
		public function set layout(value:String):void {
			if (_layout != value) {
				_layout = value;
				callLater(updateDisplayList);
			}
		}
		
		public function get layout():String {
			return _layout;
		}

		protected function onAdded(event:Event):void {
			if (event.currentTarget == event.target.parent) {
				callLater(updateDisplayList);
			}
		}
		
		protected function onRemoved(event:Event):void {
			if (event.currentTarget == event.target.parent) {
				callLater(updateDisplayList);
			}
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
		
		public function updateDisplayList():void {
			if (_layout == Layouts.ABSOLUTE) {
				return;
			} else {
				var child:DisplayObject;
				var num:int;
				for (var i:int = 0; i < _target.numChildren; i++) {
					child = _target.getChildAt(i) as DisplayObject;
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
	}
}