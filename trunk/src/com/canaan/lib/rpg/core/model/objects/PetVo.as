package com.canaan.lib.rpg.core.model.objects
{
	import com.canaan.lib.rpg.core.constants.ObjectCategory;

	public class PetVo extends RoleVo
	{
		public function PetVo()
		{
			super();
			category = ObjectCategory.PET;
		}
	}
}