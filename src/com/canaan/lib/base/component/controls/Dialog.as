package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.managers.DialogManager;

	public class Dialog extends View
	{
		public function Dialog()
		{
			super();
		}
		
		public function show(modal:Boolean = false):void {
			DialogManager.getInstance().show(this, modal);
		}
		
		public function popup(modal:Boolean = false):void {
			DialogManager.getInstance().popup(this, modal);
		}

		public function close():void {
			DialogManager.getInstance().close(this);
		}
	}
}