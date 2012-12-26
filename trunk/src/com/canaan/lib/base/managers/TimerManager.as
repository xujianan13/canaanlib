package com.canaan.lib.base.managers
{
	import flash.display.Shape;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	public class TimerManager
	{
		private static var canInstantiate:Boolean;
		private static var instance:TimerManager;
		
		private var _time:Number;
		private var _count:int;
		
		private var shape:Shape;
		private var handlers:Dictionary;
		private var pool:Vector.<TimerHandler>;
		private var currFrame:int;
		private var currTime:int;
		private var lastTime:int;
		
		public function TimerManager()
		{
			if (!canInstantiate) {
				throw new Error("Can not instantiate, use getInstance() instead.");
			}
			shape = new Shape();
			shape.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			handlers = new Dictionary();
			pool = new Vector.<TimerHandler>();
			currTime = getTimer();
		}
		
		public static function getInstance():TimerManager {
			if (instance == null) {
				canInstantiate = true;
				instance = new TimerManager();
				canInstantiate = false;
			}
			return instance;
		}
		
		private function enterFrameHandler(event:Event):void {
			currFrame++;
			lastTime = currTime;
			currTime = getTimer();
			var handler:TimerHandler;
			var t:int;
			var method:Function;
			var args:Array;
			for each (handler in handlers) {
				t = handler.useFrame ? currFrame : currTime;
				if (t >= handler.exeTime) {
					method = handler.method;
					args = handler.args;
					handler.repeat ? handler.exeTime += handler.delay : clear(method);
					method.apply(null, args);
				}
			}
		}
		
		public function doOnce(delay:int, method:Function, args:Array = null):void {
			create(false, false, delay, method, args);
		}
		
		public function doLoop(delay:int, method:Function, args:Array = null):void {
			create(false, true, delay, method, args);
		}
		
		public function doFrameOnce(delay:int, method:Function, args:Array = null):void {
			create(true, false, delay, method, args);
		}
		
		public function doFrameLoop(delay:int, method:Function, args:Array = null):void {
			create(true, true, delay, method, args);
		}
		
		private function create(useFrame:Boolean, repeat:Boolean, delay:int, method:Function, args:Array = null):void {
			clear(method);
			if (delay < 1) {
				method.apply(null, args);
				return;
			}
			var handler:TimerHandler = pool.length > 0 ? pool.pop() : new TimerHandler();
			handler.useFrame = useFrame;
			handler.repeat = repeat;
			handler.delay = delay;
			handler.method = method;
			handler.args = args;
			handler.exeTime = delay + (useFrame ? currFrame : currTime);
			handlers[method] = handler;
			_count++;
		}
		
		public function clear(method:Function):void {
			var handler:TimerHandler = handlers[method];
			if (handler != null) {
				delete handlers[method];
				handler.clear();
				pool.push(handler);
				_count--;
			}
		}
		
		public function running(method:Function):Boolean {
			return handlers[method];
		}
		
		public function get count():int {
			return _count;
		}
		
		public function set time(value:Number):void {
			_time = value;
			doFrameLoop(1, timeStep);
		}
		
		public function get time():Number {
			return _time;
		}
		
		private function timeStep():void {
			_time += currTime - lastTime;
		}
	}
}

class TimerHandler {
	
	public var delay:int;
	public var repeat:Boolean;
	public var useFrame:Boolean;
	public var exeTime:int;
	public var method:Function;
	public var args:Array;
	
	public function clear():void {
		method = null;
		args = null;
	}
}