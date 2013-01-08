package com.canaan.lib.base.managers
{
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.component.controls.Dialog;
	import com.canaan.lib.base.utils.ArrayUtil;
	import com.canaan.lib.base.utils.DisplayUtil;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class DialogManager extends Sprite
	{
		private static var canInstantiate:Boolean;
		private static var instance:DialogManager;
		
		private var modalMask:Sprite;
		private var dialogs:Vector.<Dialog> = new Vector.<Dialog>();
		private var modals:Vector.<Dialog> = new Vector.<Dialog>();
		
		public function DialogManager()
		{
			if (!canInstantiate) {
				throw new Error("Can not instantiate, use getInstance() instead.");
			}
			modalMask = new Sprite();
			modalMask.graphics.beginFill(Styles.dialogModalColor, Styles.dialogModalAlpha);
			modalMask.graphics.drawRect(0, 0, 1, 1);
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
			StageManager.getInstance().resizeMethods.register(onResize);
			onResize();
		}
		
		private function onResize():void {
			modalMask.width = StageManager.getInstance().stage.stageWidth;
			modalMask.height = StageManager.getInstance().stage.stageHeight;
			var dialog:Dialog;
			for each (dialog in dialogs) {
				dialog.center();
			}
		}
		
		public function show(dialog:Dialog, modal:Boolean = false, x:Number = NaN, y:Number = NaN):void {
			closeAll();
			popup(dialog, modal, x, y);
		}
		
		public function popup(dialog:Dialog, modal:Boolean = false, x:Number = NaN, y:Number = NaN):void {
			if (modal) {
				addChild(modalMask);
				ArrayUtil.addElements(modals, dialog);
			}
			ArrayUtil.removeElements(dialogs, dialog);
			dialogs.push(dialog);
			addChild(dialog);
			dialog.isPopup = true;
			if (isNaN(x) && isNaN(y)) {
				dialog.center();
			} else {
				dialog.moveTo(x, y);
			}
		}
		
		public function close(dialog:Dialog):void {
			dialog.remove();
			dialog.isPopup = false;
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