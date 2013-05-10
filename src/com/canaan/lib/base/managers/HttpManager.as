package com.canaan.lib.base.managers
{
	import com.canaan.lib.base.core.DURLLoader;
	import com.canaan.lib.base.core.Methods;
	import com.canaan.lib.base.debug.Log;
	import com.canaan.lib.base.events.CEventDispatcher;
	import com.canaan.lib.base.events.HttpEvent;
	import com.canaan.lib.base.net.ServerRequest;
	import com.canaan.lib.base.net.ServerResult;
	import com.canaan.lib.base.utils.ObjectUtil;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.utils.Dictionary;

	/**
	 * Http协议管理器
	 * @author xujianan
	 * 
	 */	
	public class HttpManager extends CEventDispatcher
	{
		private static var canInstantiate:Boolean;
		private static var instance:HttpManager;
		
		private var hosts:Dictionary = new Dictionary();
		private var methodsDict:Dictionary = new Dictionary();
		private var request:ServerRequest;
		private var result:ServerResult;
		
		public function HttpManager()
		{
			if (!canInstantiate) {
				throw new Error("Can not instantiate, use getInstance() instead.");
			}
			request = new ServerRequest();
			result = new ServerResult();
		}
		
		public static function getInstance():HttpManager {
			if (instance == null) {
				canInstantiate = true;
				instance = new HttpManager();
				canInstantiate = false;
			}
			return instance;
		}
		
		public function connect(host:String, hostType:String, hostName:String = "default"):void {
			var hostItem:HostItem = hosts[hostName];
			if (!hostItem) {
				hostItem = new HostItem(host, hostType, hostName);
				hosts[hostName] = hostItem;
			}
		}
		
		public function dispose(hostName:String):void {
			var hostItem:HostItem = hosts[hostName];
			if (hostItem) {
				delete hosts[hostName];
			}
		}
		
		public function send(cmd:int, data:Object = null, hostName:String = "default"):void {
			var hostItem:HostItem = hosts[hostName];
			if (hostItem) {
				// reset serverRequest
				request.reset(cmd, data);
				
				var urlRequest:URLRequest = new URLRequest(hostItem.getFormatUrl(cmd));
				var urlVaribles:URLVariables = new URLVariables();
				ObjectUtil.merge(urlVaribles, data);
				urlRequest.data = urlVaribles;
				var urlLoader:DURLLoader = DURLLoader.fromPool();
				urlLoader.loaderData = hostItem;
				urlLoader.addEventListener(Event.COMPLETE, onComplete);
				urlLoader.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
				urlLoader.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
				urlLoader.load(urlRequest);
			}
		}
		
		public function registerHandler(cmd:int, func:Function, args:Array = null):void {
			var methods:Methods = methodsDict[cmd];
			if (!methods) {
				methods = new Methods();
				methodsDict[cmd] = methods;
			}
			methods.register(func, args);
		}
		
		public function deleteHandler(cmd:int, func:Function):void {
			var methods:Methods = methodsDict[cmd];
			if (methods) {
				methods.del(func);
				if (methodsDict.length == 0) {
					delete methodsDict[cmd];
				}
			}
		}
		
		private function onComplete(event:Event):void {
			var urlLoader:DURLLoader = event.target as DURLLoader;
			result.setData(JSON.parse(urlLoader.data));
			if (!result.success) {
				dispatch(HttpEvent.SERVER_ERROR, result);
				return;
			}
			var methods:Methods = methodsDict[result.cmd];
			if (methods) {
				methods.applyWith([result]);
			}
			dispatch(HttpEvent.COMPLETE, result);
		}
		
		private function onIoError(event:IOErrorEvent):void {
			var urlLoader:DURLLoader = event.target as DURLLoader;
			var hostItem:HostItem = urlLoader.loaderData as HostItem;
			dispatch(HttpEvent.IO_ERROR, hostItem.hostName);
			Log.getInstance().error("Http IoError. name:" + hostItem.hostName + 
				", error:" + event.text);
		}
		
		private function onSecurityError(event:SecurityErrorEvent):void {
			var urlLoader:DURLLoader = event.target as DURLLoader;
			var hostItem:HostItem = urlLoader.loaderData as HostItem;
			dispatch(HttpEvent.SECURITY_ERROR, hostItem.hostName);
			Log.getInstance().error("Http SecurityError. name:" + hostItem.hostName + 
				", error:" + event.text);
		}
		
		private function dispatch(type:String, data:Object):void {
			var event:HttpEvent = HttpEvent.fromPool(type, data);
			dispatchEvent(event);
			HttpEvent.toPool(event);
		}
	}
}

class HostItem
{
	public var host:String;
	public var hostType:String;
	public var hostName:String;
	
	public function HostItem(host:String, hostType:String, hostName:String)
	{
		this.host = host;
		this.hostType = hostType;
		this.hostName = hostName;
	}
	
	public function getFormatUrl(cmd:int):String {
		return host + cmd + "." + hostType;
	}
}