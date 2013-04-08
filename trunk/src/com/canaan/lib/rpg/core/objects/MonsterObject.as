package com.canaan.lib.rpg.core.objects
{
	import com.canaan.lib.rpg.core.CommonResources;
	
	public class MonsterObject extends RoleObject
	{
		public function MonsterObject()
		{
			super();
		}
		
		protected function initializeView():void {
			super.initializeView();
			_view.setDefaultSkin(CommonResources.monsterDefaultSkin);
		}
	}
}