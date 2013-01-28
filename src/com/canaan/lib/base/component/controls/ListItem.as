package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.IListItem;
	import com.canaan.lib.base.core.Method;
	
	import flash.events.MouseEvent;
	
	public class ListItem extends View implements IListItem
	{
		protected var _selected:Boolean;
		protected var _mouseClickHandler:Method;
		
		public function ListItem()
		{
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			addEventListener(MouseEvent.CLICK, onMouseClick);
			addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			addEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			addEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
		
		override public function dispose():void {
			super.dispose();
			removeEventListener(MouseEvent.CLICK, onMouseClick);
			removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			removeEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			removeEventListener(MouseEvent.MOUSE_MOVE, onMouseUp);
			removeEventListener(MouseEvent.ROLL_OVER, onMouseOver);
			removeEventListener(MouseEvent.ROLL_OUT, onMouseOut);
		}
		
		protected function onMouseClick(event:MouseEvent):void {
			if (_selected || !_enabled) {
				return;
			}
			if (_mouseClickHandler != null) {
				_mouseClickHandler.apply();
			}
		}
		
		protected function onMouseDown(event:MouseEvent):void {
			
		}
		
		protected function onMouseUp(event:MouseEvent):void {
			
		}
		
		protected function onMouseOver(event:MouseEvent):void {
			
		}
		
		protected function onMouseMove(event:MouseEvent):void {
			
		}
		
		protected function onMouseOut(event:MouseEvent):void {
			
		}
		
		override public function set data(value:Object):void {
			super.data = value;
			refresh();
		}
		
		protected function refresh():void {
			
		}
		
		public function set selected(value:Boolean):void {
			if (_selected != value) {
				_selected = value;
			}
		}
		
		public function get selected():Boolean {
			return _selected;
		}
		
		public function set mouseClickHandler(value:Method):void {
			if (_mouseClickHandler != value) {
				_mouseClickHandler = value;
			}
		}
		
		public function get mouseClickHandler():Method {
			return _mouseClickHandler;
		}
	}
}