package com.canaan.lib.base.utils
{
	public class MathUtil
	{
		public function MathUtil()
		{
		}

		public static function randRange(min:int, max:int):int {
            return int(Math.random() * (max - min + 1)) + min;
        }
		
		public static function roundFixed(value:Number, dot:int):Number {
			dot = Math.max(0, Math.min(16, dot));
			var num:Number = Math.pow(10, dot);
			return Math.round(value * num) / num;
		}
		
		public static function floorFixed(value:Number, dot:int):Number {
			dot = Math.max(0, Math.min(16, dot));
			var num:Number = Math.pow(10, dot);
			return int(value * num) / num;
		}
		
		public static function getAngle(x:Number, y:Number):Number {
			return Math.atan2(y, x);
		}
		
		public static function angleToRotation(angle:Number):Number {
			return angle * 180 / Math.PI;
		}
		
		public static function rotationToAngle(rotation:Number):Number {
			return rotation & Math.PI / 180;
		}
	}
}