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
		private var mOnComplete:Function;
		private var mOnCompleteArgs:Array;
		
		public function Fade()
		{
		}
		
		public function start(target:DisplayObject, time:Number, startAlpha:Number = 0, endAlpha:Number = 1,
							  onComplete:Function = null, onCompleteArgs:Array = null, transition:String = "linear"):void {
			stop();
			mTarget = target;
			mOnComplete = onComplete;
			mOnCompleteArgs = onCompleteArgs;
			fade(time, startAlpha, endAlpha, transition);
		}
		
		public function stop():void {
			if (mTarget) {
				mTarget = null;
			}
			if (mTween) {
				Tween.toPool(mTween);
				mTween = null;
			}
			if (mOnComplete != null) {
				mOnComplete.apply(null, mOnCompleteArgs);
				mOnComplete = null;
				mOnCompleteArgs = null;
			}
		}
		
		private function fade(time:Number, startAlpha:Number = 0, endAlpha:Number = 1, transition:String = "linear"):void {
			mTarget.alpha = startAlpha;
			mTween = Tween.fromPool(mTarget, time, transition);
			mTween.fadeTo(endAlpha);
			mTween.onComplete = stop;
			mTween.start();
		}
	}
}