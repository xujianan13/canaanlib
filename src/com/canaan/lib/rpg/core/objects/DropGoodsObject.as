package com.canaan.lib.rpg.core.objects
{
	import com.canaan.lib.rpg.core.CommonResources;
	
	public class DropGoodsObject extends AbstractObject
	{
		public function DropGoodsObject()
		{
			super();
		}
		
		protected function initializeView():void {
			super.initializeView();
			_view.setDefaultSkin(CommonResources.dropGoodsDefaultSkin);
		}
	}
}