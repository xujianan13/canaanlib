package com.canaan.lib.base.display.effects
{
	import com.canaan.lib.base.animation.Tween;
	
	import flash.display.DisplayObject;

	/**
	 * 震屏特效
	 * 
	 */	
	public class EarthQuake
	{
		private var mTarget:DisplayObject;
		private var mStartY:Number = 0;
		private var mTween:Tween;
		private var mOnComplete:Function;
		private var mOnCompleteArgs:Array;
		
		public function EarthQuake()
		{
		}
		
		/**
		 * 开始震屏
		 * 
		 * @param target			震屏对象
		 * @param time				震屏时间
		 * @param dist				震屏程度(像素)
		 * @param onComplete		回调函数
		 * @param onCompleteArgs	回调函数参数
		 * 
		 */		
		public function start(target:DisplayObject, time:Number, dist:Number,
							  onComplete:Function = null, onCompleteArgs:Array = null):void {
			stop();
			mTarget = target;
			mOnComplete = onComplete;
			mOnCompleteArgs = onCompleteArgs;
			mStartY = mTarget.y;
			quake(time / 2, dist, quake, [time / 2, dist / 2, stop]);
		}
		
		public function stop():void {
			if (mTarget) {
				mTarget.y = mStartY;
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
			mStartY = 0;
		}
		
		private function quake(time:Number, dist:Number, onComplete:Function = null, onCompleteArgs:Array = null):void {
			mTween = Tween.fromPool(mTarget, time);
			mTween.animate("y", dist);
			mTween.repeatCount = 2;
			mTween.reverse = true;
			mTween.start();
			mTween.onComplete = onComplete;
			mTween.onCompleteArgs = onCompleteArgs;
		}
	}
}