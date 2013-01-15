package com.canaan.lib.rpg.core.model.objects
{
	import com.canaan.lib.rpg.core.constants.ObjectCategory;

	public class PlayerVo extends RoleVo
	{
		public var name:String;
		public var gender:int;
		public var career:int;
		
		public function PlayerVo()
		{
			super();
			category = ObjectCategory.PLAYER;
		}
		
		override public function reinitialize():void {
			super.reinitialize();
			name = null;
			gender = 0;
			career = 0;
		}
	}
}