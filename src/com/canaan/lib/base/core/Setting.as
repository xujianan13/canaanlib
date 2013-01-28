package com.canaan.lib.base.core
{
	/**
	 * 此类为属性设置类
	 * 使用前需要赋值
	 * 建议将所有资源路径配置为文本文件(json, xml等)
	 * 加载解析后赋值给当前类
	 */
	public class Setting
	{
		public static var root:XMLList;
		public static var fps:int;
		public static var debugMode:Boolean;
		
		public static function initialize(xmlList:XMLList):void {
			root = xmlList;
			fps = root.@fps;
			debugMode = root.@debugMode;
		}
	}
}