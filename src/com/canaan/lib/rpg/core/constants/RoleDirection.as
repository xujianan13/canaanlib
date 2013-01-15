package com.canaan.lib.rpg.core.constants
{
	public class RoleDirection
	{
		public static const UP:int = 1;
		public static const RIGHT_UP:int = 2;
		public static const RIGHT:int = 3;
		public static const RIGHT_DOWN:int = 4;
		public static const DOWN:int = 5;
		public static const LEFT_DOWN:int = 6;
		public static const LEFT:int = 7;
		public static const LEFT_UP:int = 8;
		
		public static function getOppsiteDirection(direction:int):int {
			var oppsiteDirection:int = direction + 4;
			if (oppsiteDirection > LEFT_UP) {
				oppsiteDirection -= LEFT_UP;
			}
			return oppsiteDirection;
		}
	}
}