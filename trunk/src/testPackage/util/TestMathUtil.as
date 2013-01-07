package testPackage.util
{
	import com.canaan.lib.base.utils.MathUtil;
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class TestMathUtil extends Sprite
	{
		public function TestMathUtil()
		{
			super();
			
//			trace(MathUtil.sin(90));
//			trace(Math.sin(Math.PI / 2));
			
//			trace(MathUtil.radianToAngle(Math.PI));
			
			trace(MathUtil.toUAngle(-10));
			
			var x1:Number = 0;
			var y1:Number = 0;
			var x2:Number = 100;
			var y2:Number = 100;
			graphics.beginFill(0);
			graphics.lineStyle(1);
			graphics.moveTo(x1, y1);
			graphics.lineTo(x2, y2);
			
			var point:Point = MathUtil.getLinePoint(x2, y2, x1, y1, 20);
			graphics.drawCircle(point.x, point.y, 2);
			
			var point2:Point = MathUtil.getLinePoint2(point.x, point.y, 10, -45);
			graphics.beginFill(0xFF0000);
			graphics.drawCircle(point2.x, point2.y, 2);
		}
	}
}