package com.canaan.lib.base.core
{
	import flash.utils.Dictionary;
	
	/**
	 * 此类为资源路径类
	 * 使用前需要赋值
	 * 建议将所有资源路径配置为文本文件(json, xml等)
	 * 加载解析后赋值给当前类
	 */
	public class Resources
	{
		public static var root:XMLList;
		public static var dirImage:String;									// 静态图片目录
		public static var dirAudio:String;									// 音频文件目录
		public static var dirRpg:String;									// rpg资源目录
		public static var dirSlg:String;									// slg资源目录
		public static var dirTable:String;									// 数据表目录
		public static var dirSetting:String;								// 静态配置文件setting
		public static var dirLang:String;									// 语言文件目录
		public static var dirUIXml:String;									// UIXml文件目录
		public static var preLoadFilesList:Vector.<ResourceItem>;			// 预加载文件列表
		public static var preLoadFilesDict:Dictionary;						// 预加载文件字典表
		public static var moduleFilesList:Vector.<ResourceItem>;			// 预加载文件列表
		public static var moduleFilesDict:Dictionary;						// 游戏模块文件字典表
		
		public static function initialize(xmlList:XMLList):void {
			root = xmlList;
			dirImage = root.@dirImages;
			dirAudio = root.@dirAudio;
			dirRpg = root.@dirRpg;
			dirSlg = root.@dirSlg;
			dirTable = root.@dirTable;
			dirSetting = root.@dirSetting;
			dirLang = root.@dirLang;
			dirUIXml = root.@dirUIXml;
			preLoadFilesList = new Vector.<ResourceItem>();
			preLoadFilesDict = new Dictionary();
			moduleFilesList = new Vector.<ResourceItem>();
			moduleFilesDict = new Dictionary();
			
			var fileList:XMLList = root.preLoadFiles;
			var numList:int = fileList.file.length();
			var resourItem:ResourceItem;
			var file:XML;
			var i:int;
			var url:String;
			var id:String;
			var name:String;
			for (i = 0; i < numList; i++) {
				file = fileList.file[i];
				url = file.@url;
				id = file.@id;
				name = file.@name;
				resourItem = new ResourceItem(url, id, name);
				preLoadFilesList.push(resourItem);
				preLoadFilesDict[id] = resourItem;
			}
			
			fileList = root.moduleFiles;
			numList = fileList.file.length();
			for (i = 0; i < numList; i++) {
				file = fileList.file[i];
				url = file.@url;
				id = file.@id;
				name = file.@name;
				resourItem = new ResourceItem(url, id, name);
				resourItem = new ResourceItem(file.@url, file.@id, file.@name);
				moduleFilesList.push(resourItem);
				moduleFilesDict[id] = resourItem;
			}
		}
	}
}