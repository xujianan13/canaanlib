package com.canaan.lib.base.display.effects
{
	import com.canaan.lib.base.animation.Tween;
	
	import flash.display.DisplayObject;

	/**
	 * 缓动
	 * 
	 */	
	public class EasingMove
	{
		private var mTarget:DisplayObject;
		private var mTween:Tween;
		private var mOnComplete:Function;
		private var mOnCompleteArgs:Array;
		
		public function EasingMove()
		{
		}
		
		public function start(target:DisplayObject, time:Number, startX:Number, startY:Number,
							  endX:Number, endY:Number, onComplete:Function = null, onCompleteArgs:Array = null,
							  transition:String = "linear"):void {
			stop();
			mTarget = target;
			mOnComplete = onComplete;
			mOnCompleteArgs = onCompleteArgs;
			easingMove(time, startX, startY, endX, endY, transition);
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
		
		private function easingMove(time:Number, startX:Number, startY:Number, endX:Number, endY:Number, transition:String = "linear"):void {
			mTarget.x = startX;
			mTarget.y = startY;
			mTween = Tween.fromPool(mTarget, time);
			mTween.transition = transition;
			mTween.moveTo(endX, endY);
			mTween.onComplete = stop;
			mTween.start();
		}
	}
}