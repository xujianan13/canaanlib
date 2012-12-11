package com.canaan.lib.base.core
{
	public class ResourceItem
	{
		public var url:String;
		public var completeHandler:MethodElement;
		public var progressHandler:MethodElement;
		
		public function ResourceItem(url:String, completeHandler:MethodElement = null, progressHandler:MethodElement = null) {
			this.url = url;
			this.completeHandler = completeHandler;
			this.progressHandler = progressHandler;
		}
	}
}