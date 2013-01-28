package com.canaan.lib.base.core
{
	public class ResourceItem
	{
		public var url:String;
		public var name:String;
		public var completeHandler:Method;
		public var progressHandler:Method;
		
		public function ResourceItem(url:String, name:String = "", completeHandler:Method = null, progressHandler:Method = null)
		{
			this.url = url;
			this.name = name;
			this.completeHandler = completeHandler;
			this.progressHandler = progressHandler;
		}
	}
}