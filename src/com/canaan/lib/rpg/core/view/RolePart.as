package com.canaan.lib.rpg.core.view
{
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.display.BitmapDataEx;
	import com.canaan.lib.base.display.BitmapMovieClip;
	import com.canaan.lib.base.interfaces.IRecyclable;
	import com.canaan.lib.rpg.core.constants.RoleDirection;
	import com.canaan.lib.rpg.core.model.action.ActionVo;

	public class RolePart extends BitmapMovieClip implements IRecyclable
	{
		protected var _action:int = -1;
		protected var _direction:int = -1;
		protected var _actionVo:ActionVo;
		
		public function RolePart()
		{
			super();
		}

		override public function dispose():void {
			super.dispose();
			_action = -1;
			_direction = -1;
		}
		
		public function set actionVo(value:ActionVo):void {
			if (_actionVo != value) {
				_actionVo = value;
			}
		}
		
		public function get actionVo():ActionVo {
			return _actionVo;
		}
		
		public function playAction(action:int, direction:int = -1, loop:Boolean = true, onComplete:Method = null):void {
			// 如果direction为-1则将direction设置为上次的值
			if (direction == -1) {
				direction = _direction;
			}
			if (_action != action || _direction != direction) {
				_action = action;
				_direction = direction;
				// 如果方向为左侧 则将资源水平翻转
				if (direction > RoleDirection.DOWN) {
					scaleX = -1;
					direction = RoleDirection.getCopyDirection(direction);
				} else {
					scaleX = 1;
				}
				if (_actionVo) {
					var vector:Vector.<BitmapDataEx> = _actionVo.getVector(action, direction);
					if (vector != null) {
						bitmapDatas = vector;
						fromTo(null, null, loop, onComplete);
					}
				}
			}
		}
		
		override protected function animationComplete():void {
			_action = -1;
			super.animationComplete();
		}
	}
}