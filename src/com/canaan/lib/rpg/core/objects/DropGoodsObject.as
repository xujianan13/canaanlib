package com.canaan.lib.rpg.core.objects
{
	import com.canaan.lib.rpg.core.CommonResources;
	import com.canaan.lib.rpg.core.model.objects.DropGoodsVo;
	
	public class DropGoodsObject extends AbstractObject
	{
		public function DropGoodsObject(vo:DropGoodsVo)
		{
			super(vo);
		}
		
		protected function initializeView():void {
			super.initializeView();
			_view.setDefaultSkin(CommonResources.dropGoodsDefaultSkin);
		}
	}
}