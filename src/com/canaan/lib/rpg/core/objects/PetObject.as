package com.canaan.lib.rpg.core.objects
{
	import com.canaan.lib.rpg.core.CommonResources;
	import com.canaan.lib.rpg.core.model.objects.PetVo;
	
	public class PetObject extends RoleObject
	{
		public function PetObject(vo:PetVo)
		{
			super(vo);
		}
		
		protected function initializeView():void {
			super.initializeView();
			_view.setDefaultSkin(CommonResources.petDefaultSkin);
		}
	}
}