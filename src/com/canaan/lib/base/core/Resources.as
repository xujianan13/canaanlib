package com.canaan.lib.base.core
{
	/**
	 * 此类为资源路径类
	 * 使用前需要赋值
	 * 建议将所有资源路径配置为文本文件(json, xml等)
	 * 加载解析后赋值给当前类
	 */
	public class Resources
	{
		public static var root:XMLList;
		public static var dirImages:String;									// 静态图片目录
		public static var dirMap:String;									// rpg地图图片目录
		public static var preLoadFiles:Vector.<ResourceItem>;				// 预加载文件
		
		public static function initialize(xmlList:XMLList):void {
			root = xmlList;
			dirImages = root.@dirImages;
			dirMap = root.@dirMap;
			preLoadFiles = new Vector.<ResourceItem>();
			
			var fileList:XMLList = root.preLoadFiles;
			var numList:int = fileList.file.length();
			var resourItem:ResourceItem;
			var file:XML;
			for (var i:int = 0; i < numList; i++) {
				file = fileList.file[i];
				resourItem = new ResourceItem(file.@url, file.@name);
				preLoadFiles.push(resourItem);
			}
		}
	}
}