package com.canaan.lib.base.managers
{
	import com.canaan.lib.base.debug.Log;
	import com.canaan.lib.base.utils.ObjectUtil;
	
	import flash.events.NetStatusEvent;
	import flash.net.SharedObject;
	import flash.utils.ByteArray;

	public class SharedObjectManager
	{
		private static const LOCAL_PATH:String = "/";
		private static const PUBLIC_SO:String = "canaanlib/public_so";
		private static const PRIVATE_SO:String = "canaanlib/private_so";
		private static const SIZE:int = 536870912;								// 512MB
		private static const REG:RegExp = /[ ~%&\\;:"',<>?#|*]/g;				// special chars
		
		private static var canInstantiate:Boolean;
		private static var instance:SharedObjectManager;
		
		public static var privateSign:String = "";
		
		private var publicSO:SharedObject;
		private var privateSO:SharedObject;
		
		public function SharedObjectManager()
		{
			if (!canInstantiate) {
				throw new Error("Can not instantiate, use getInstance() instead.");
			}
			try {
				publicSO = SharedObject.getLocal(PUBLIC_SO, LOCAL_PATH);
				publicSO.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
				privateSign = filter(privateSign);
				privateSO = SharedObject.getLocal(PRIVATE_SO + "/" + privateSign, LOCAL_PATH);
				privateSO.addEventListener(NetStatusEvent.NET_STATUS, onNetStatus);
			} catch (error:Error) {
				Log.getInstance().error("SharedObjectManager could not create the SharedObject: " + error.message);
			}
		}
		
		public static function getInstance():SharedObjectManager {
			if (instance == null) {
				canInstantiate = true;
				instance = new SharedObjectManager();
				canInstantiate = false;
			}
			return instance;
		}
		
		private function onNetStatus(event:NetStatusEvent):void {
			var info:Object = event.info;
			Log.getInstance().info("SharedObjectManager onNetStatus. code: " + info.code + ". level: " + info.level);
		}
		
		/**
		 * 预分配占用的磁盘空间 
		 * 
		 */		
		public function preAllocated():void {
			try {
				publicSO.flush(SIZE);
			} catch (error:Error) {
				Log.getInstance().info("SharedObjectManager could not preAllocated: " + error.message);
			}
		}
		
		public function flush():void {
			try {
				publicSO.flush();
				privateSO.flush();
			} catch (error:Error) {
				Log.getInstance().info("SharedObjectManager could not flush: " + error.message);
			}
		}
		
		private function filter(name:String):String {
			return name.replace(REG);
		}
		
		private function compress(value:Object):ByteArray {
			if (value) {
				return ObjectUtil.objectToBytes(value, true);
			}
			return null;
		}
		
		private function uncompress(value:ByteArray):Object {
			if (value) {
				return ObjectUtil.bytesToObject(value, true);
			}
			return null;
		}
		
		public function putPublic(name:String, value:Object):void {
			publicSO.data[name] = compress(value);
		}
		
		public function putPrivate(name:String, value:Object):void {
			privateSO.data[name] = compress(value);
		}
		
		public function getPublic(name:String):Object {
			return uncompress(publicSO.data[name]);
		}
		
		public function getPrivate(name:String):Object {
			return uncompress(privateSO.data[name]);
		}
		
		public function removePublic(name:String):void {
			delete publicSO.data[name];
		}
		
		public function removePrivate(name:String):void {
			delete privateSO.data[name];
		}
		
		public function hasPublic(name:String):Boolean {
			return publicSO.data.hasOwnProperty(name);
		}
		
		public function hasPrivate(name:String):Boolean {
			return privateSO.data.hasOwnProperty(name);
		}
	}
}