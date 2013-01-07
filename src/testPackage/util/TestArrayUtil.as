package testPackage.util
{
	import com.canaan.lib.base.utils.ArrayUtil;
	
	import flash.display.Sprite;
	
	public class TestArrayUtil extends Sprite
	{
		public function TestArrayUtil()
		{
			var array:Array = [1, 2, 3, 4, 5];
			ArrayUtil.removeElements(array, 1, 3, 4);
			trace(array);
			ArrayUtil.addElements(array, 6,7,8);
			trace(array);
		}
	}
}