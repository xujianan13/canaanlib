package com.canaan.lib.base.interfaces
{
	public interface IScene extends ICEventDispatcher
	{
		function enterScene():void;
		function exitScene():void;
		function registerScene():void;
		function deleteScene():void;
		function get sceneName():String;
		function set sceneName(value:String):void;
	}
}