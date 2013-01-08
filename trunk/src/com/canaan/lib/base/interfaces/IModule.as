package com.canaan.lib.base.interfaces
{
	public interface IModule extends ICEventDispatcher
	{
		function addedToScene(sceneName:String):void;
		function removeFromScene():Boolean;
		function registerModule():void;
		function deleteModule():void;
		function get sceneName():String;
	}
}