package com.canaan.lib.rpg.core.objects
{
	import com.canaan.lib.rpg.core.CommonResources;
	
	public class NpcObject extends AbstractObject
	{
		public function NpcObject()
		{
			super();
		}
		
		protected function initializeView():void {
			super.initializeView();
			_view.setDefaultSkin(CommonResources.npcDefaultSkin);
		}
	}
}