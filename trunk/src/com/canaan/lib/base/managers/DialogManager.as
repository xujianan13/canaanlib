package com.canaan.lib.base.managers
{
	import com.canaan.lib.base.component.controls.Dialog;
	import com.canaan.lib.base.utils.DisplayUtil;
	
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class DialogManager extends Sprite
	{
		private static var canInstantiate:Boolean;
		private static var instance:DialogManager;
		
		private var modalMask:Bitmap;
		private var dialogs:Array = [];
		private var modals:Array = [];
		
		public function DialogManager()
		{
			if (!canInstantiate) {
				throw new Error("Can not instantiate, use getInstance() instead.");
			}
			modalMask = DisplayUtil.createBitmap(1, 1, 0x000000, 0.3);
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		public static function getInstance():DialogManager {
			if (instance == null) {
				canInstantiate = true;
				instance = new DialogManager();
				canInstantiate = false;
			}
			return instance;
		}
		
		private function onAddedToStage(event:Event):void {
			removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			stage.addEventListener(Event.RESIZE, onResize);
			onResize(null);
		}
		
		private function onResize(event:Event):void {
			var dialog:Dialog;
			for each (dialog in dialogs) {
				dialog.center();
			}
			modalMask.width = stage.stageWidth;
			modalMask.height = stage.stageHeight;
		}
		
		public function show(dialog:Dialog, modal:Boolean = false, x:Number = NaN, y:Number = NaN):void {
			closeAll();
			popup(dialog, modal, x, y);
		}
		
		public function popup(dialog:Dialog, modal:Boolean = false, x:Number = NaN, y:Number = NaN):void {
			if (modal) {
				addChild(modalMask);
				modals.push(dialog);
			}
			dialogs.push(addChild(dialog));
			if (isNaN(x) && isNaN(y)) {
				dialog.center();
			} else {
				dialog.moveTo(x, y);
			}
		}
		
		public function close(dialog:Dialog):void {
			dialog.remove();
			var modalIndex:int = modals.indexOf(dialog);
			if (modalIndex != -1) {
				modals.splice(modalIndex, 1);
				if (modals.length == 0) {
					removeChild(modalMask);
				} else {
					modalIndex = getChildIndex(modals[modals.length - 1]);
					setChildIndex(modalMask, modalIndex);
				}
			}
		}
		
		public function closeAll():void {
			DisplayUtil.removeAllChildren(this);
			dialogs.length = 0;
			modals.length = 0;
		}
	}
}