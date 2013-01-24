package com.canaan.lib.rpg.core.model.objects
{
	import com.canaan.lib.rpg.core.constants.ObjectCategory;

	public class NpcVo extends AbstractObjectVo
	{
		public function NpcVo()
		{
			super();
			category = ObjectCategory.NPC;
		}
	}
}