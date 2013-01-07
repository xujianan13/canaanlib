package com.canaan.lib.base.component
{
	import com.canaan.lib.base.core.Method;

	public interface IListItem
	{
		function set data(value:Object):void;
		function get data():Object;
		function set selected(value:Boolean):void;
		function get selected():Boolean;
		function set mouseClickHandler(value:Method):void;
		function get mouseClickHandler():Method;
	}
}