package com.canaan.lib.rpg.utils
{
	import com.canaan.lib.base.utils.MathUtil;
	import com.canaan.lib.rpg.core.constants.RoleDirection;

	public class DirectionUtil
	{
		private static const SEGMENT_337_5:Number = 337.5;
		private static const SEGMENT_22_5:Number = 22.5;
		private static const SEGMENT_67_5:Number = 67.5;
		private static const SEGMENT_112_5:Number = 112.5;
		private static const SEGMENT_157_5:Number = 157.5;
		private static const SEGMENT_202_5:Number = 202.5;
		private static const SEGMENT_247_5:Number = 247.5;
		private static const SEGMENT_292_5:Number = 292.5;
		
		public static function getDirection(x1:Number, y1:Number, x2:Number, y2:Number):int {
			if (x1 == x2) {
				if (y2 > y1) {
					return RoleDirection.DOWN;
				}
				return RoleDirection.UP;
			} else if (y1 == y2) {
				if (x2 > x1) {
					return RoleDirection.RIGHT;
				}
				return RoleDirection.LEFT;
			} else {
				var angle:Number = MathUtil.getUAngle(x2 - x1, y2 - y1);
				if (angle <= SEGMENT_22_5 || angle >= SEGMENT_337_5) {
					return RoleDirection.RIGHT;
				} else if (angle >= SEGMENT_22_5 && angle <= SEGMENT_67_5) {
					return RoleDirection.RIGHT_DOWN;
				} else if (angle >= SEGMENT_67_5 && angle <= SEGMENT_112_5) {
					return RoleDirection.DOWN;
				} else if (angle >= SEGMENT_112_5 && angle <= SEGMENT_157_5) {
					return RoleDirection.LEFT_DOWN;
				} else if (angle >= SEGMENT_157_5 && angle <= SEGMENT_202_5) {
					return RoleDirection.LEFT;
				} else if (angle >= SEGMENT_202_5 && angle <= SEGMENT_247_5) {
					return RoleDirection.LEFT_UP;
				} else if (angle >= SEGMENT_247_5 && angle <= SEGMENT_292_5) {
					return RoleDirection.UP;
				} else if (angle >= SEGMENT_292_5 && angle <= SEGMENT_337_5) {
					return RoleDirection.RIGHT_UP;
				}
				return -1;
			}
		}
		
		public static function getDirectionDegree(roleDirection:int):int {
			switch (roleDirection) {
				case RoleDirection.RIGHT:
					return 0;
				case RoleDirection.RIGHT_DOWN:
					return 45;
				case RoleDirection.DOWN:
					return 90;
				case RoleDirection.LEFT_DOWN:
					return 135;
				case RoleDirection.LEFT:
					return 180;
				case RoleDirection.LEFT_UP:
					return 225;
				case RoleDirection.UP:
					return 270;
				case RoleDirection.RIGHT_UP:
					return 315;
			}
			return 0;
		}
	}
}