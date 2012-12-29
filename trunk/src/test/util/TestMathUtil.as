package test.util
{
	import com.canaan.lib.base.utils.MathUtil;
	
	import flash.display.Sprite;
	
	public class TestMathUtil extends Sprite
	{
		public function TestMathUtil()
		{
			super();
			
//			trace(MathUtil.sin(90));
//			trace(Math.sin(Math.PI / 2));
			
//			trace(MathUtil.radianToAngle(Math.PI));
			
			trace(MathUtil.toUAngle(-10));
		}
	}
}