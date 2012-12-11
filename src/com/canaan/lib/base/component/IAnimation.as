package com.canaan.lib.base.component
{
	import com.canaan.lib.base.core.MethodElement;

	public interface IAnimation
	{
		function play():void;
		function stop():void;
		function gotoAndStop(value:int):void;
		function gotoAndPlay(value:int):void;
		function prevFrame():void;
		function nextFrame():void;
		function fromTo(from:Object = null, to:Object = null, onComplete:MethodElement = null, loop:Boolean = false):void
		function set autoRemoved(value:Boolean):void;
		function get autoRemoved():Boolean;
		function set interval(value:int):void;
		function get interval():int;
		function get isPlaying():Boolean;
		function get index():int;
		function get maxIndex():int;
	}
}