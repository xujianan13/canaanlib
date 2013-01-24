package com.canaan.lib.rpg.core.objects
{
	import com.canaan.lib.rpg.core.CommonResources;
	import com.canaan.lib.rpg.core.model.objects.MonsterVo;
	
	public class MonsterObject extends RoleObject
	{
		public function MonsterObject(vo:MonsterVo)
		{
			super(vo);
		}
		
		protected function initializeView():void {
			super.initializeView();
			_view.setDefaultSkin(CommonResources.monsterDefaultSkin);
		}
	}
}