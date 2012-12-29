package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.IAnimation;
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.events.UIEvent;
	import com.canaan.lib.base.managers.ResourceManager;
	import com.canaan.lib.base.managers.TimerManager;
	import com.canaan.lib.base.utils.DisplayUtil;
	
	import flash.display.BitmapData;
	import flash.events.Event;
	
	[Event(name="complete", type="com.canaan.lib.base.events.UIEvent")]
	[Event(name="animationComplete", type="com.canaan.lib.base.events.UIEvent")]
	
	public class Clip extends Image implements IAnimation
	{
		protected var _tileX:int;
		protected var _tileY:int;
		protected var _index:int;
		protected var _interval:int;
		protected var _isPlaying:Boolean;
		protected var _autoRemoved:Boolean;
		
		protected var tiles:Vector.<BitmapData>;
		protected var from:int;
		protected var to:int;
		protected var completeCallback:MethodElement;
		protected var loop:Boolean;

		public function Clip(url:String = null, tileX:int = 1, tileY:int = 1)
		{
			_tileX = tileX;
			_tileY = tileY;
			super(url);
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			_interval = Styles.clipInterval;
		}
		
		override protected function initialize():void {
			super.initialize();
			addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		
		protected function onRemovedFromStage(event:Event):void {
			stop();
		}
		
		override protected function changeSize():void {
			bitmap.width = _width;
			bitmap.height = _height;
			sendEvent(UIEvent.RESIZE);
		}
		
		override protected function setBitmapData(bmd:BitmapData):void {
			if (bmd != null) {
				changeClip();
			}
			sendEvent(UIEvent.COMPLETE);
		}
		
		protected function changeClip():void {
			var bmd:BitmapData = ResourceManager.getInstance().hasClass(_url) ? ResourceManager.getInstance().getBitmapData(_url) : cache[_url] as BitmapData;
			if (bmd != null) {
				tiles = DisplayUtil.createTiles(bmd, _tileX, _tileY);
				index = _index;
				if (_bitmap.bitmapData != null) {
					_width = _width || _bitmap.bitmapData.width;
					_height = _height || _bitmap.bitmapData.height;
					changeSize();
				}
			}
		}
		
		protected function animationComplete():void {
			sendEvent(UIEvent.ANIMATION_COMPLETE);
			if (_autoRemoved) {
				stop();
				DisplayUtil.removeChild(parent, this);
			}
		}
		
		public function play():void {
			_isPlaying = true;
			TimerManager.getInstance().doLoop(_interval, nextFrame);
		}
		
		public function stop():void {
			_isPlaying = false;
			TimerManager.getInstance().clear(nextFrame);
		}
		
		public function gotoAndStop(value:int):void {
			index = value;
			stop();
		}
		
		public function gotoAndPlay(value:int):void {
			index = value;
			play();
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
						if (completeCallback != null) {
							var methodElement:MethodElement = completeCallback;
							completeCallback = null;
							methodElement.apply();
						}
						animationComplete();
					}
					return;
				}
			}
			index = _index == maxIndex ? 0 : _index + 1;
			if (_index == 0) {
				animationComplete();
			}
		}
		
		public function fromTo(from:Object = null, to:Object = null, onComplete:MethodElement = null, loop:Boolean = false):void {
			this.from = Math.max(0, int(from) || 0);
			this.to = Math.min(maxIndex, int(to) || maxIndex);
			completeCallback = onComplete;
			this.loop = loop;
			gotoAndPlay(this.from);
		}
		
		public function set index(value:int):void {
			_index = value;
			if (tiles != null) {
				_index = Math.min(maxIndex, Math.max(0, _index));
				bitmap.bitmapData = tiles[_index];
			}
		}
		
		public function get index():int {
			return _index;
		}
		
		public function set tileX(value:int):void {
			if (_tileX != value) {
				_tileX = value;
				callLater(changeClip);
			}
		}
		
		public function get tileX():int {
			return _tileX;
		}
		
		public function set tileY(value:int):void {
			if (_tileY != value) {
				_tileY = value;
				callLater(changeClip);
			}
		}
		
		public function get tileY():int {
			return _tileY;
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
		
		public function set autoRemoved(value:Boolean):void {
			if (_autoRemoved != value) {
				_autoRemoved = value;
			}
		}
		
		public function get autoRemoved():Boolean {
			return _autoRemoved;
		}
		
		public function get isPlaying():Boolean {
			return _isPlaying;
		}
		
		public function get maxIndex():int {
			return _tileX * _tileY - 1;
		}
		
		override public function dispose():void {
			super.dispose();
			stop();
			removeEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
	}
}