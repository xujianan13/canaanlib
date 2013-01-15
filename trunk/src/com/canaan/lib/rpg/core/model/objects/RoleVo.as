package com.canaan.lib.rpg.core.model.objects
{
	public class RoleVo extends AbstractObjectVO
	{
		public var level:int;
		public var hp:int;
		public var equips:Vector.<String> = new Vector.<String>();
		
		public function RoleVo()
		{
			super();
		}
		
		override public function reinitialize():void {
			super.reinitialize();
			level = 0;
			hp = 0;
			equips.length = 0;
		}
	}
}