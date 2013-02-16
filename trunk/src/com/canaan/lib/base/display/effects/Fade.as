package com.canaan.lib.base.display.effects
{
	import com.canaan.lib.base.animation.Tween;
	
	import flash.display.DisplayObject;

	/**
	 * 淡入淡出特效
	 * 
	 */	
	public class Fade
	{
		private var mTarget:DisplayObject;
		private var mTween:Tween;
		
		public function Fade()
		{
		}
		
		public function start(target:DisplayObject, time:Number, startAlpha:Number = 0, endAlpha:Number = 1):void {
			stop();
			mTarget = target;
			fade(time, startAlpha, endAlpha);
		}
		
		public function stop():void {
			if (mTarget) {
				mTarget = null;
			}
			if (mTween) {
				Tween.toPool(mTween);
				mTween = null;
			}
		}
		
		private function fade(time:Number, startAlpha:Number = 0, endAlpha:Number = 1):void {
			mTarget.alpha = startAlpha;
			mTween = Tween.fromPool(mTarget, time);
			mTween.fadeTo(endAlpha);
			mTween.onComplete = stop;
			mTween.start();
		}
	}
}