package testPackage.util
{
	import com.canaan.lib.base.utils.CRC32;
	
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
			
			trace(CRC32.getCRC32(byte));
		}
	}
}