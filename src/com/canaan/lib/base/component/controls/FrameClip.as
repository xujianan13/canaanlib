package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.IAnimation;
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.component.UIComponent;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.events.UIEvent;
	import com.canaan.lib.base.managers.ResourceManager;
	import com.canaan.lib.base.managers.TimerManager;
	import com.canaan.lib.base.utils.DisplayUtil;
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	public class FrameClip extends UIComponent implements IAnimation
	{
		protected var _skin:String;
		protected var _mc:MovieClip;
		protected var _index:int;
		protected var _interval:int;
		protected var _isPlaying:Boolean;
		protected var _autoPlay:Boolean = true;
		protected var _autoRemoved:Boolean;
		
		protected var from:int;
		protected var to:int;
		protected var completeCallback:Method;
		protected var loop:Boolean;
		
		public function FrameClip(skin:String = null)
		{
			super();
			this.skin = skin;
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			_interval = Styles.clipInterval;
		}
		
		override protected function initialize():void {
			super.initialize();
			addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		protected function onAddedToStage(e:Event):void {
			if (_autoPlay) {
				play();
			}
		}
		
		protected function onRemovedFromStage(event:Event):void {
			stop();
		}
		
		override protected function changeSize():void {
			if (_mc != null) {
				_mc.width = _width;
				_mc.height = _height;
			}
			super.changeSize();
		}
		
		public function play():void {
			_isPlaying = true;
			TimerManager.getInstance().doLoop(_interval, nextFrame);
		}
		
		public function stop():void {
			_isPlaying = false;
			TimerManager.getInstance().clear(nextFrame);
		}
		
		public function gotoAndPlay(value:int):void {
			index = value;
			play();
		}
		
		public function gotoAndStop(value:int):void {
			index = value;
			stop();
		}
		
		public function prevFrame():void {
			index = _index == 0 ? maxIndex : _index - 1;
		}
		
		public function nextFrame():void {
			if (from || to) {
				if (_index == to) {
					if (loop) {
						gotoAndPlay(from);
					} else {
						from = 0;
						to = 0;
						stop();
						animationComplete();
						animationFinished();
					}
					return;
				}
			}
			if (_index == maxIndex) {
				index = 0;
				animationFinished();
			} else {
				index = _index + 1;
			}
		}
		
		protected function animationComplete():void {
			if (completeCallback != null) {
				var method:Method = completeCallback;
				completeCallback = null;
				method.apply();
			}
		}
		
		protected function animationFinished():void {
			sendEvent(UIEvent.ANIMATION_COMPLETE);
			if (_autoRemoved) {
				stop();
				DisplayUtil.removeChild(parent, this);
			}
		}
		
		public function fromTo(from:Object = null, to:Object = null, loop:Boolean = false, onComplete:Method = null):void {
			this.from = Math.max(0, int(from) || 0);
			this.to = Math.min(maxIndex, int(to) || maxIndex);
			this.loop = loop;
			completeCallback = onComplete;
			gotoAndPlay(this.from);
		}
		
		public function get isPlaying():Boolean {
			return _isPlaying;
		}
		
		public function set autoRemoved(value:Boolean):void {
			_autoRemoved = value;
		}
		
		public function get autoRemoved():Boolean {
			return _autoRemoved;
		}
		
		public function set index(value:int):void {
			value = Math.min(maxIndex, Math.max(0, value));
			if (_index != value) {
				_index = value;
				if (_mc != null) {
					_mc.gotoAndStop(_index);
					_width = _mc.width;
					_height = _mc.height;
				}
			}
		}
		
		public function get index():int {
			return _index;
		}
		
		public function get maxIndex():int {
			if (_mc != null) {
				return _mc.totalFrames - 1;
			}
			return 0;
		}
		
		public function get autoPlay():Boolean {
			return _autoPlay;
		}
		
		public function set autoPlay(value:Boolean):void {
			if (_autoPlay != value) {
				_autoPlay = value;
				_autoPlay ? play() : stop();
			}
		}
		
		public function set interval(value:int):void {
			if (_interval != value) {
				_interval = value;
				if (_isPlaying) {
					callLater(play);
				}
			}
		}
		
		public function get interval():int {
			return _interval;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				mc = ResourceManager.getInstance().getNewInstance(_skin);
			}
		}
		
		public function get skin():String {
			return _skin;
		}
		
		public function set mc(value:MovieClip):void {
			if (_mc != value) {
				if (_mc != null && _mc.parent != null) {
					_mc.stop();
					removeChild(_mc);
				}
				_mc = value;
				if (_mc != null) {
					_mc.stop();
					addChild(_mc);
					_width = mc.width;
					_height = mc.height;
				} else {
					stop();
					_width = 0;
					_height = 0;
				}
			}
		}
		
		public function get mc():MovieClip {
			return _mc;
		}
		
		override public function dispose():void {
			super.dispose();
			stop();
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
	}
}