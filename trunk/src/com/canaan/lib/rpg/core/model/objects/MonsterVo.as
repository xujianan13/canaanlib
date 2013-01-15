package com.canaan.lib.rpg.core.model.objects
{
	import com.canaan.lib.rpg.core.constants.ObjectCategory;

	public class MonsterVo extends RoleVo
	{
		public function MonsterVo()
		{
			super();
			category = ObjectCategory.MONSTER;
		}
	}
}