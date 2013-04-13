package com.canaan.lib.rpg.core.view
{
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.rpg.core.model.action.ActionVo;

	public class PlayerView extends RoleView
	{
		protected var _weapon:RolePart;
		protected var _wing:RolePart;
		protected var _mount:RolePart;
		
		public function PlayerView()
		{
			super();
		}
		
		override protected function initialize():void {
			// 坐骑
			_mount = new RolePart();
			addChild(_mount);
			super.initialize();
			// 武器
			_weapon = new RolePart();
			addChild(_weapon);
			// 翅膀
			_wing = new RolePart();
			addChild(_wing);
		}
		
		override public function reinitialize():void {
			super.reinitialize();
			_mount.reinitialize();
			_weapon.reinitialize();
			_wing.reinitialize();
		}
		
		override public function dispose():void {
			super.dispose();
			_mount.dispose();
			_weapon.dispose();
			_wing.dispose();
		}
		
		override public function playAction(action:int, direction:int=-1, loop:Boolean=true, onComplete:Method=null):void {
			if (_mount.actionVo) {
				_mount.playAction(action, direction, loop, onComplete);
			}
			super.playAction(action, direction, loop, onComplete);
			if (_weapon.actionVo) {
				_weapon.playAction(action, direction, loop, onComplete);
			}
			if (_wing.actionVo) {
				_wing.playAction(action, direction, loop, onComplete);
			}
		}
		
		public function updateMount(actionVo:ActionVo):void {
			_mount.actionVo = actionVo;
		}
		
		public function updateWeapon(actionVo:ActionVo):void {
			_weapon.actionVo = actionVo;
		}
		
		public function updateWing(actionVo:ActionVo):void {
			_wing.actionVo = actionVo;
		}
	}
}