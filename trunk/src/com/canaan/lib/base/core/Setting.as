package com.canaan.lib.base.core
{
	import com.canaan.lib.base.utils.XMLUtil;
	
	/**
	 * 此类为游戏数据设置
	 * 
	 */
	public class Setting
	{
		public static var root:XMLList;
		public static var settingDict:Object;
		
		public static function initialize(xmlList:XMLList):void {
			root = xmlList;
			settingDict = XMLUtil.XMLToObject(xmlList);
		}
		
		public static function getSettingByName(name:String):Object {
			return settingDict[name];
		}
	}
}