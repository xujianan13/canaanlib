package com.canaan.lib.rpg.core.objects
{
	import com.canaan.lib.rpg.core.CommonResources;
	
	public class PetObject extends RoleObject
	{
		public function PetObject()
		{
			super();
		}
		
		protected function initializeView():void {
			super.initializeView();
			_view.setDefaultSkin(CommonResources.petDefaultSkin);
		}
	}
}