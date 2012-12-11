package com.canaan.lib.base.utils
{
	import flash.net.LocalConnection;
	
	public class GameUtil
	{
//		private static const BEZIER_RATIO_X:Number = 1.25;
//		private static const BEZIER_RATIO_Y:Number = 0.25;
//		private static const TWEEN_DURATION:Number = 2;
		
		public function GameUtil()
		{
		}

		/**
		 * 垃圾回收
		 */
		public static function gc():void {
			try {
				new LocalConnection().connect("gc");
				new LocalConnection().connect("gc");
			} catch (error:Error) {
				
			}
		}
		
//		public static function tweenObject(tweenObject:Sprite, parent:DisplayObjectContainer, startPoint:Point, targetPoint:Point, callback:Function = null, args:Array = null):void {
//			if (tweenObject == null || parent == null) {
//				return;
//			}
//        	tweenObject.mouseChildren = false;
//	    	tweenObject.mouseEnabled = false;
//	    	tweenObject.x = startPoint.x;
//	    	tweenObject.y = startPoint.y;
//			parent.addChild(tweenObject);
//	    	var duration:Number = TWEEN_DURATION;
//	    	var middleX:Number = tweenObject.x + (targetPoint.x - tweenObject.x) * BEZIER_RATIO_X;
//	    	var middleY:Number = tweenObject.y + (targetPoint.y - tweenObject.y) * BEZIER_RATIO_Y;
//	    	var tweenMax:TweenMax = TweenMax.to(tweenObject, duration, {x:targetPoint.x, y:targetPoint.y, bezier:[{x:middleX, y:middleY, alpha:0.7}],
//					onComplete:function():void {
//	    				tweenMax.kill();
//	    				tweenMax = null;
//						parent.removeChild(tweenObject);
//	    				if (tweenObject is IDispose) {
//	    					IDispose(tweenObject).dispose();
//	    				}
//	    				tweenObject = null;
//	    				if (callback != null) {
//	    					callback.apply(null, args);
//	    					callback = null;
//	    				}
//	    			}
//	    		}
//	    	);
//	    	var scaleTween:TweenMax = TweenMax.to(tweenObject, duration, {scaleX:0.5, scaleY:0.5, 
//					onComplete:function():void {
//	    				scaleTween.kill();
//	    				scaleTween = null;
//	    			}
//	    		}
//			);
//			var alphaTween:TweenMax = TweenMax.to(tweenObject, duration, {delay:duration * 0.5, alpha:0, 
//	    			onComplete:function():void {
//	    				alphaTween.kill();
//	    				alphaTween = null;
//	    			}
//	    		}
//			);
//        }
	}
}