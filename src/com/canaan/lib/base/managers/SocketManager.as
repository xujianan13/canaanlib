package com.canaan.lib.base.managers
{
	import com.canaan.lib.base.core.Methods;
	import com.canaan.lib.base.debug.Log;
	import com.canaan.lib.base.events.CEventDispatcher;
	import com.canaan.lib.base.events.SocketEvent;
	import com.canaan.lib.base.net.SocketClient;
	import com.canaan.lib.base.net.SocketRequest;
	import com.canaan.lib.base.net.SocketResult;
	import com.canaan.lib.base.utils.ObjectUtil;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * 因为程序中可能存在多个socket连接
	 * 所以避免直接使用SocketMananger，最好进行二次封装
	 * 例如存在服务器socket和聊天socket，避免直接使用send()方法
	 * 为服务器socket和聊天socket抽象出两个send()方法，各自调用互不影响
	 */
	public class SocketManager extends CEventDispatcher
	{
		public static var bufferMaxSize:int = 16440;
		
		private static var canInstantiate:Boolean;
		private static var instance:SocketManager;
		
		private var sockets:Dictionary = new Dictionary();
		private var methodsDict:Dictionary = new Dictionary();
		private var socketRequest:SocketRequest;
		private var socketResult:SocketResult;
		
		public function SocketManager()
		{
			if (!canInstantiate) {
				throw new Error("Can not instantiate, use getInstance() instead.");
			}
			socketRequest = new SocketRequest();
			socketResult = new SocketResult();
		}
		
		public static function getInstance():SocketManager {
			if (instance == null) {
				canInstantiate = true;
				instance = new SocketManager();
				canInstantiate = false;
			}
			return instance;
		}
		
		public function connect(socketName:String, host:String, port:int):void {
			var socketItem:SocketItem = sockets[socketName];
			if (!socketItem) {
				socketItem = new SocketItem(socketName);
				sockets[socketName] = socketItem;
				addEvents(socketItem.client);
			}
			socketItem.connect(host, port);
			dispatch(SocketEvent.START_CONNECT, socketName);
		}
		
		public function dispose(socketName:String):void {
			var socketItem:SocketItem = sockets[socketName];
			if (socketItem) {
				delete sockets[socketName];
				removeEvents(socketItem.client);
				socketItem.dispose();
			}
		}
		
		public function send(socketName:String, cmd:int, data:Object = null):void {
			var socketItem:SocketItem = sockets[socketName];
			if (socketItem) {
				// reset socketRequest
				socketRequest.reset(cmd, data);
				
				// serialization the request
				var bytes:ByteArray = ObjectUtil.gBytes;
				bytes = ObjectUtil.objectToBytes(socketRequest, true, bytes);
				
				// get bytes's length
				var length:int = bytes.length;
				
				// write data
				var client:SocketClient = socketItem.client;
				client.writeShort(length);
				client.writeBytes(bytes);
				client.flush();
				
				dispatch(SocketEvent.SEND, socketName);
			} else {
				Log.getInstance().error("Socket is not exist. socketName:" + socketName);
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
		
		public function handler(data:Object):void {
			socketResult.setData(data);
			var methods:Methods = methodsDict[socketResult.cmd];
			if (methods) {
				methods.applyWith([socketResult]);
			}
		}
		
		private function addEvents(client:SocketClient):void {
			client.addEventListener(Event.CONNECT, onConnect);
			client.addEventListener(Event.CLOSE, onClose);
			client.addEventListener(IOErrorEvent.IO_ERROR, onIoError);
			client.addEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			client.addEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
		}
		
		private function removeEvents(client:SocketClient):void {
			client.removeEventListener(Event.CONNECT, onConnect);
			client.removeEventListener(Event.CLOSE, onClose);
			client.removeEventListener(IOErrorEvent.IO_ERROR, onIoError);
			client.removeEventListener(SecurityErrorEvent.SECURITY_ERROR, onSecurityError);
			client.removeEventListener(ProgressEvent.SOCKET_DATA, onSocketData);
		}
		
		private function onConnect(event:Event):void {
			var client:SocketClient = event.target as SocketClient;
			dispatch(SocketEvent.CONNECT, client.socketName);
			Log.getInstance().info("Socket connect. name:" + client.socketName + 
				", host:" + client.host + ", port:" + client.port);
		}
		
		private function onClose(event:Event):void {
			var client:SocketClient = event.target as SocketClient;
			dispatch(SocketEvent.CLOSE, client.socketName);
			Log.getInstance().info("Socket close. name:" + client.socketName + 
				", host:" + client.host + ", port:" + client.port);
		}
		
		private function onIoError(event:IOErrorEvent):void {
			var client:SocketClient = event.target as SocketClient;
			dispatch(SocketEvent.IO_ERROR, client.socketName);
			Log.getInstance().error("Socket IoError. name:" + client.socketName + 
				", host:" + client.host + ", port:" + client.port);
		}
		
		private function onSecurityError(event:SecurityErrorEvent):void {
			var client:SocketClient = event.target as SocketClient;
			dispatch(SocketEvent.SECURITY_ERROR, client.socketName);
			Log.getInstance().error("Socket SecurityError. name:" + client.socketName + 
				", host:" + client.host + ", port:" + client.port);
		}
		
		private function onSocketData(event:ProgressEvent):void {
			var client:SocketClient = event.target as SocketClient;
			var socketName:String = client.socketName;
			dispatch(SocketEvent.RECEIVED, socketName);
			
			// read buffer
			var socketItem:SocketItem = sockets[socketName];
			socketItem.readBuffer();
			socketItem.validateData();
		}

		private function dispatch(type:String, data:Object):void {
			var event:SocketEvent = SocketEvent.fromPool(type, data);
			dispatchEvent(event);
			SocketEvent.toPool(event);
		}
	}
}

import com.canaan.lib.base.managers.SocketManager;
import com.canaan.lib.base.net.SocketClient;
import com.canaan.lib.base.utils.ObjectUtil;

import flash.utils.ByteArray;

class SocketItem
{
	public var client:SocketClient;
	public var buffer:ByteArray;
	
	public function SocketItem(socketName:String)
	{
		client = new SocketClient(socketName);
		buffer = new ByteArray();
	}
	
	public function connect(host:String, port:int):void {
		client.connect(host, port);
	}
	
	public function readBuffer():void {
		client.readBytes(buffer, buffer.length, client.bytesAvailable);
	}
	
	public function validateData():void {
		var short:int = buffer.readShort();
		if (buffer.bytesAvailable >= short) {
			// write data
			var bytes:ByteArray = ObjectUtil.gBytes;
			bytes.clear();
			buffer.readBytes(bytes, 0, short);
			
			// handle data
			var data:Object = bytes.readObject();
			SocketManager.getInstance().handler(data);
			validateData();
		}
		
		validateBuffer();
	}
	
	public function validateBuffer():void {
		if (buffer.position >= SocketManager.bufferMaxSize) {
			buffer.clear();
		}
	}
	
	public function dispose():void {
		client.close();
		client = null;
		buffer.clear();
		buffer = null;
	}
}