package com.canaan.lib.rpg.core.objects
{
	import com.canaan.lib.rpg.core.CommonResources;
	import com.canaan.lib.rpg.core.model.action.ActionVo;
	import com.canaan.lib.rpg.core.view.PlayerView;
	
	public class PlayerObject extends RoleObject
	{
		public function PlayerObject()
		{
			super();
		}
		
		override protected function initializeView():void {
			_view = new PlayerView();
			_view.setDefaultSkin(CommonResources.playerDefaultSkin);
		}
		
		protected function get playerView():PlayerView {
			return _view as PlayerView();
		}

		public function updateMount(actionVo:ActionVo):void {
			playerView.updateMount(actionVo);
		}
		
		public function updateWeapon(actionVo:ActionVo):void {
			playerView.updateWeapon(actionVo);
		}
		
		public function updateWing(actionVo:ActionVo):void {
			playerView.updateWing(actionVo);
		}
	}
}