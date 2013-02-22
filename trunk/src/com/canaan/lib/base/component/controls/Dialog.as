package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.managers.DialogManager;
	import com.canaan.lib.base.managers.DragManager;
	import com.canaan.lib.base.utils.ArrayUtil;
	
	import flash.events.MouseEvent;

	public class Dialog extends View
	{
		protected var _draggable:Boolean;
		protected var _dragArea:Array;
		protected var _isPopup:Boolean;
		
		public function Dialog()
		{
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			_dragArea = Styles.dialogDragArea;
		}
		
		public function get isPopup():Boolean {
			return _isPopup;
		}
		
		public function set isPopup(value:Boolean):void {
			_isPopup = value;
		}
		
		public function get draggable():Boolean {
			return _draggable;
		}
		
		public function set draggable(value:Boolean):void {
			if (_draggable != value) {
				_draggable = value;
				if (value) {
					addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				} else {
					removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				}
			}
		}
		
		protected function mouseDownHandler(event:MouseEvent):void {
			bringToFrong();
			if (validateDrag()) {
				DragManager.getInstance().doDrag(this);
			}
		}
		
		protected function validateDrag():Boolean {
			var leftTopX:int = int(_dragArea[0]);
			var leftTopY:int = int(_dragArea[1]);
			var rightBottomX:int = width - leftTopX - int(_dragArea[2]);
			var rightBottomY:int = int(_dragArea[1]) + int(_dragArea[3]);
			return mouseX >= leftTopX && mouseX <= rightBottomX &&
				mouseY >= leftTopX && mouseY <= rightBottomY;
		}
		
		public function get dragArea():String {
			return _dragArea.toString();
		}
		
		public function set dragArea(value:String):void {
			_dragArea = ArrayUtil.copyAndFill(_dragArea, value);
		}
		
		public function show(modal:Boolean = false):void {
			DialogManager.getInstance().show(this, modal);
		}
		
		public function popup(modal:Boolean = false):void {
			DialogManager.getInstance().popup(this, modal);
		}
		
		public function bringToFrong():void {
			DialogManager.getInstance().bringToFront(this);
		}

		public function close():void {
			DialogManager.getInstance().close(this);
		}
		
		public function doDrag():void {
			DragManager.getInstance().doDrag(this);
		}
		
		override public function dispose():void {
			super.dispose();
			removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
	}
}