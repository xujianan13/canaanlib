package com.canaan.lib.base.core
{
	/**
	 * 此类为配置类
	 * 使用前需要赋值
	 * 建议将所有资源路径配置为文本文件(json, xml等)
	 * 加载解析后赋值给当前类
	 */
	public class Config
	{
		public static var root:XMLList;
		public static var gameSocketHost:String;					// 主socket host地址
		public static var gameSocketPort:int;						// 主socket port端口
		public static var chatSocketHost:String;					// 聊天socket host地址
		public static var chatSocketPort:int;						// 聊天socket port端口
		public static var resHost:String;							// 游戏资源根目录（包括config, asset）
		public static var locale:String;							// 语言版本
		public static var platform:String;							// 平台
		public static var version:String;							// 版本号
		
		public static function initialize(xmlList:XMLList):void {
			root = xmlList;
			gameSocketHost = root.@gameSocketHost;
			gameSocketPort = root.@gameSocketPort;
			chatSocketHost = root.@chatSocketHost;
			chatSocketPort = root.@chatSocketPort;
			resHost = root.@resHost;
			locale = root.@locale;
			platform = root.@platform;
			version = root.@version;
		}
	}
}