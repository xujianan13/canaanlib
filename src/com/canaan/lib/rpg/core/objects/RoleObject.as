package com.canaan.lib.rpg.core.objects
{
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.rpg.core.model.action.ActionVo;
	import com.canaan.lib.rpg.core.model.objects.RoleVo;
	import com.canaan.lib.rpg.core.view.RoleView;
	
	public class RoleObject extends AbstractObject
	{
		protected var _action:int = -1;
		protected var _direction:int = -1;
		
		public function RoleObject(vo:RoleVo)
		{
			super(vo);
		}
		
		override public function reinitialize():void {
			super.reinitialize();
			_action = -1;
			_direction = -1;
		}
		
		protected function initializeView():void {
			_view = new RoleView();
		}
		
		protected function get roleView():RoleView {
			return _view as RoleView;
		}
		
		public function updateSkin(actionVo:ActionVo):void {
			roleView.updateSkin(actionVo);
		}
		
		public function play(action:int, direction:int = -1, loop:Boolean = true, onComplete:Method = null):void {
			if (direction == -1) {
				direction = _direction;
			}
			_action = action;
			_direction = direction;
			roleView.play(_action, _direction, loop, onComplete);
		}
	}
}