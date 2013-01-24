package testPackage.display
{
	import com.canaan.lib.base.display.BitmapDataEx;
	import com.canaan.lib.base.display.BitmapMovieClip;
	import com.canaan.lib.base.utils.BitmapExUtil;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	public class TestBitmapMovieClip extends Sprite
	{
		private var loader:Loader;
		
		public function TestBitmapMovieClip()
		{
			super();
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.load(new URLRequest("assets/clip_num.png"));
		}
		
		private function onComplete(event:Event):void {
			var bitmapData:BitmapData = Bitmap(loader.content).bitmapData;
			var bitmapDatas:Vector.<BitmapDataEx> = BitmapExUtil.createSequence2(bitmapData, 10, 1);
			var bitmapMovieClip:BitmapMovieClip = new BitmapMovieClip();
			addChild(bitmapMovieClip);
			bitmapMovieClip.interval = 500;
			bitmapMovieClip.play();
			bitmapMovieClip.bitmapDatas = bitmapDatas;
			bitmapMovieClip.fromTo(0, 5, true);
		}
	}
}