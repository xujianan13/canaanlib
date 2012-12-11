package com.canaan.lib.base.utils
{
	public class DateUtil
	{
		public function DateUtil()
		{
		}

		public static function addZero(value:int):String {
			return (value < 10 ? "0" : "") + value;
		}
		
		public static function formatDate(date:Date, short:Boolean = false, dateSeparator:String = "-", timeSeparator:String = ":"):String {
			var yy:String = addZero(date.getFullYear());
			var mm:String = addZero(date.getMonth() + 1);
			var dd:String = addZero(date.getDate());
			var h:String = addZero(date.getHours());
			var m:String = addZero(date.getMinutes());
			var s:String = addZero(date.getSeconds());
			
			var result:String = "";
			result += yy + dateSeparator + mm + dateSeparator + dd;
			
			if (!short) {
				result += " " + h + timeSeparator + m + timeSeparator + s;
			}
			
			return result;
		}
		
		public static function formateDateFromSeconds(value:Number, short:Boolean = false, dateSeparator:String = "-", timeSeparator:String = ":"):String {
			return formatDate(new Date(value * 1000), short, dateSeparator, timeSeparator);
		}
		
		public static function formatTime(time:Number, separator:String = ":"):String {
			var h:String = addZero(int(time / 3600));
            time %= 3600;
            var m:String = addZero(int(time / 60));
            time %= 60;
            var s:String = addZero(time);
			return h + separator + m + separator + s;
		}
		
		public static function getZeroTime(value:Number):Number {
        	var serverDate:Date = new Date(value * 1000);
			var targetTime:Number = (new Date(serverDate.fullYear, serverDate.month, serverDate.date).time) / 1000;
			return targetTime;
        }
	}
}