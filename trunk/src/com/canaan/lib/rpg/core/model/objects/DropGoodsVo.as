package com.canaan.lib.rpg.core.model.objects
{
	import com.canaan.lib.rpg.core.constants.ObjectCategory;

	public class DropGoodsVo extends AbstractObjectVo
	{
		public function DropGoodsVo()
		{
			super();
			category = ObjectCategory.GROP_GOODS;
		}
	}
}