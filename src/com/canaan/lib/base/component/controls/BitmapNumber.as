package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Layouts;

	public class BitmapNumber extends Container
	{
		private static var clipPool:Vector.<Clip> = new Vector.<Clip>();
		
		protected var _url:String;
		protected var _value:uint;
		protected var clips:Vector.<Clip> = new Vector.<Clip>();
		
		public function BitmapNumber(url:String = "")
		{
			super();
			this.url = url;
		}
		
		protected function reset():void {
			removeAllChildren();
			for each (var clip:Clip in clips) {
				toPool(clip);
			}
			clips.length = 0;
		}
		
		override protected function initialize():void {
			super.initialize();
			layout = Layouts.HORIZONTAL;
		}
		
		public function get url():String {
			return _url;
		}
		
		public function set url(value:String):void {
			if (_url != value) {
				_url = value;
				callLater(changeClips);
			}
		}
		
		public function get value():uint {
			return _value;
		}
		
		public function set value(num:uint):void {
			if (_value != num) {
				_value = num;
				callLater(changeClips);
			}
		}
		
		protected function changeClips():void {
			reset();
			var clip:Clip;
			var num:uint = _value;
			var index:uint;
			do {
				index = num % 10;
				num /= 10;
				clip = fromPool(_url, index);
				addChildAt(clip, 0);
				clips.unshift(clip);
			} while (num != 0);
		}
		
		override public function dispose():void {
			super.dispose();
			reset();
			clips = null;
		}
		
		protected function fromPool(url:String, index):Clip {
			var clip:Clip;
			if (clipPool.length == 0) {
				clip = new Clip();
				clip.tileX = 10;
				clip.tileY = 1;
				clip.autoPlay = false;
			} else {
				clip = clipPool.pop();
			}
			clip.url = url;
			clip.gotoAndStop(index);
			return clip;
		}
		
		protected function toPool(clip:Clip):void {
			clip.stop();
			clip.remove();
			clipPool.push(clip);
		}
	}
}