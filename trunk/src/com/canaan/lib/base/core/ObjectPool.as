package com.canaan.lib.base.core
{
	import com.canaan.lib.base.interfaces.IRecyclable;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * 参考flash优化写了一个通用的对象池
	 * 使用此类需要初始化(未初始化会使用默认参数初始化)
	 * 获取对象需要传递对象的类
	 * 所有对象池里的类都需要实现IRecyclable接口以便于回收
	 */
	public class ObjectPool
	{
		private static var DEFAULT_MAX_POOL_SIZE:int = 5;
		private static var DEFAULT_GROWTH_VALUE:int = 5;
		private static var pools:Dictionary = new Dictionary();
		
		public function ObjectPool()
		{
		}

		/**
		 * 初始化对象池
		 */
		public static function initialize(maxPoolSize:uint, growthValue:uint, type:Class):void {
			var newPool:Object = {};
			newPool.growthValue = growthValue;
			newPool.counter = maxPoolSize;
			newPool.pool = new Array(maxPoolSize);
			
			var i:uint = maxPoolSize;
			while (--i > -1) {
				newPool.pool[i] = new type();
			}
			
			var className:String = getQualifiedClassName(type);
			pools[className] = newPool;
		}
		
		/**
		 * 根据类名获取对象
		 */
		public static function getObject(type:Class):IRecyclable {
			var className:String = getQualifiedClassName(type);
			if (!pools[className]) {
				initialize(DEFAULT_MAX_POOL_SIZE, DEFAULT_GROWTH_VALUE, type);
			}
			
			var targetPool:Object = pools[className];
			if (targetPool.counter > 0) {
				return targetPool.pool[--targetPool.counter];
			}
			
			var i:uint = targetPool.growthValue;
			while (--i > -1) {
				targetPool.pool.unshift(new type());
			}
			targetPool.counter = targetPool.growthValue;
			return getObject(type);
		}
		
		/**
		 * 回收对象
		 */
		public static function disposeObject(disposedObject:IRecyclable):void {
			disposedObject.dispose();
			disposedObject.initialize();
			var className:String = getQualifiedClassName(disposedObject);
			var targetPool:Object = pools[className];
			targetPool.pool[targetPool.counter++] = disposedObject;
		}
	}
}