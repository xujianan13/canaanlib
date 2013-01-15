package com.canaan.lib.base.managers
{
	import com.canaan.lib.base.events.DragEvent;
	import com.canaan.lib.base.interfaces.IDropObject;
	import com.canaan.lib.base.utils.DisplayUtil;
	
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;

	public class DragManager extends Sprite
	{
		private static var canInstantiate:Boolean;
        private static var instance:DragManager;
        
        private var dragInitiator:DisplayObject;
        private var data:Object;
        private var dragImage:Sprite;
		
		public function DragManager()
		{
			if (!canInstantiate) {
				throw new Error("Can not instantiate, use getInstance() instead.");
			}
		}
		
		public static function getInstance():DragManager {
            if (instance == null) {
            	canInstantiate = true;
                instance = new DragManager();
                canInstantiate = false;
            }
            return instance;
        }
        
        public function doDrag(dragInitiator:DisplayObject, dragImage:Sprite, data:Object = null):void {
        	this.dragInitiator = dragInitiator;
        	this.data = data;
        	this.dragImage = dragImage;
			if (dragInitiator != dragImage) {
	        	var globalPoint:Point = dragInitiator.parent.localToGlobal(new Point(dragInitiator.x, dragInitiator.y));
	        	dragImage.x = globalPoint.x;
	        	dragImage.y = globalPoint.y;
				addChild(dragImage);
			}
        	dragImage.startDrag();
        	StageManager.getInstance().registerHandler(MouseEvent.MOUSE_UP, mouseUpHandler);
        	dragInitiator.dispatchEvent(new DragEvent(DragEvent.DRAG_START, dragInitiator, data));
        }

        private function mouseUpHandler():void {
        	dragImage.stopDrag();
        	var dropTarget:IDropObject = getDropTarget(dragImage.dropTarget);
        	if (dropTarget != null) {
        		dropTarget.dispatchEvent(new DragEvent(DragEvent.DRAG_DROP, dragInitiator, data));
        	}
        	dragInitiator.dispatchEvent(new DragEvent(DragEvent.DRAG_COMPLETE, dragInitiator, data));
			if (dragInitiator != dragImage) {
        		DisplayUtil.removeChild(dragImage.parent, dragImage);
			}
			StageManager.getInstance().deleteHandler(MouseEvent.MOUSE_UP, mouseUpHandler);
        	dragInitiator = null;
        	data = null;
        	dragImage = null;
        }
        
        private function getDropTarget(value:DisplayObject):IDropObject {
			while (value) {
				if (value is IDropObject) {
					return value as IDropObject;
				}
				value = value.parent;
			}
			return null;
        }
	}
}