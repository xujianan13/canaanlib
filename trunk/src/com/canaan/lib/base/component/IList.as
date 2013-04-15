package com.canaan.lib.base.component
{
	public interface IList
	{
		function get items():Vector.<IListItem>;
		function set selectedItem(value:IListItem):void;
		function get selectedItem():IListItem;
		function set selectedIndex(value:int):void;
		function get selectedIndex():int;
		function set selectedValue(value:Object):void;
		function get selectedValue():Object;
	}
}