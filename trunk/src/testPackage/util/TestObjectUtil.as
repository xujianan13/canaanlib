package testPackage.util
{
	import com.canaan.lib.base.utils.ObjectUtil;
	
	import flash.display.Sprite;
	
	public class TestObjectUtil extends Sprite
	{
		public function TestObjectUtil()
		{
			var a:Object = new Object();
			a.key = {value:1};
			
			var b:Object = ObjectUtil.deapClone(a);
			trace(b.key.value);
		}
	}
}