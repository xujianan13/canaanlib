package com.canaan.lib.rpg.core.model.objects
{
	import com.canaan.lib.rpg.core.constants.ObjectCategory;

	public class TransferPointVo extends AbstractObjectVo
	{
		public function TransferPointVo()
		{
			super();
			category = ObjectCategory.TRANSFER_POINT;
		}
	}
}