package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.managers.DragManager;
	import com.canaan.lib.base.utils.ArrayUtil;
	
	import flash.events.MouseEvent;

	public class DragDialog extends Dialog
	{
		protected var _dragArea:Array;
		
		public function DragDialog()
		{
			super();
		}
		
		override protected function initialize():void {
			super.initialize();
			_dragArea = Styles.dragDialogDragArea;
			addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
		}
		
		protected function mouseDownHandler(event:MouseEvent):void {
			if (event.target != this) {
				return;
			}
			if (validateDrag()) {
				DragManager.getInstance().doDrag(this);
			}
		}
		
		private function validateDrag():Boolean {
			var leftTopX:int = int(_dragArea[0]);
			var leftTopY:int = int(_dragArea[1]);
			var rightTopX:int = realWidth - leftTopX - int(_dragArea[2]);
			var rightTopY:int = int(_dragArea[1]) + int(_dragArea[3]);
			return mouseX >= leftTopX && mouseX <= rightTopX &&
				mouseY >= leftTopX && mouseY <= rightTopY;
		}
		
		public function get dragArea():String {
			return _dragArea.toString();
		}
		
		public function set dragArea(value:String):void {
			_dragArea = ArrayUtil.copyAndFill(_dragArea, value);
		}
	}
}