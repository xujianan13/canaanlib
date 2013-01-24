package com.canaan.lib.rpg.core.objects
{
	import com.canaan.lib.rpg.core.CommonResources;
	import com.canaan.lib.rpg.core.model.objects.NpcVo;
	
	public class NpcObject extends AbstractObject
	{
		public function NpcObject(vo:NpcVo)
		{
			super(vo);
		}
		
		protected function initializeView():void {
			super.initializeView();
			_view.setDefaultSkin(CommonResources.npcDefaultSkin);
		}
	}
}