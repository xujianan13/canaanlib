package com.canaan.lib.base.component.layout
{
	import com.canaan.lib.base.component.UIComponent;
	
	import flash.events.Event;

	public class Layout
	{
		protected var _layout:String;
		protected var _target:UIComponent;
		
		public function Layout()
		{
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
		
		public function set target(value:UIComponent):void {
			if (_target != value) {
				dispose();
				_target = value;
				_target.addEventListener(Event.ADDED, onAdded);
				_target.addEventListener(Event.REMOVED, onRemoved);
			}
		}
		
		public function get target():UIComponent {
			return _target;
		}
		
		protected function callLater(func:Function, args:Array = null):void {
			_target.callLater(func, args);
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
		
		public function updateDisplayList():void {
			
		}
		
		public function dispose():void {
			if (_target != null) {
				_target.removeEventListener(Event.ADDED, onAdded);
				_target.removeEventListener(Event.REMOVED, onRemoved);
				_target = null;
			}
		}
	}
}