package
{
	import com.canaan.lib.base.utils.CRC32Util;
	
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	public class TestCRCUtil extends Sprite
	{
		public function TestCRCUtil()
		{
			super();
			
			var a:String = "aaaaa";
			var byte:ByteArray = new ByteArray();
			byte.writeMultiByte(a, "utf-8");
			
			trace(CRC32Util.getCRC32(byte));
		}
	}
}