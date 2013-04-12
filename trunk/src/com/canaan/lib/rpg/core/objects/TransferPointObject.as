package com.canaan.lib.rpg.core.objects
{
	import com.canaan.lib.rpg.core.CommonResources;

	public class TransferPointObject extends AbstractObject
	{
		public function TransferPointObject()
		{
			super();
		}
		
		protected function initializeView():void {
			super.initializeView();
			_view.setDefaultSkin(CommonResources.transferPointDefaultSkin);
		}
	}
}