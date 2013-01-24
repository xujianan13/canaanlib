package com.canaan.lib.rpg.core.view
{
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.rpg.core.model.action.ActionVo;

	public class RoleView extends AbstractView
	{
		public function RoleView()
		{
			super();
		}
		
		override protected function initialize():void {
			_skin = new RolePart();
			addChild(_skin);
		}
		
		protected function get skin():RolePart {
			return _skin as RolePart;
		}
		
		public function updateSkin(actionVo:ActionVo):void {
			skin.actionVo = actionVo;
		}
		
		public function play(action:int, direction:int = -1, loop:Boolean = true, onComplete:Method = null):void {
			if (skin.actionVo) {
				skin.play(action, direction, loop, onComplete);
			}
		}
	}
}