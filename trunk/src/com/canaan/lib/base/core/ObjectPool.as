package com.canaan.lib.base.core
{
	import com.canaan.lib.base.interfaces.IRecyclable;
	import com.canaan.lib.base.utils.ClassUtil;
	
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
		public static var DEFAULT_MAX_POOL_SIZE:int = 5;
		public static var DEFAULT_GROWTH_VALUE:int = 5;
		
		private static var pools:Dictionary = new Dictionary();
		
		public function ObjectPool()
		{
		}

		/**
		 * 初始化对象池
		 */
		public static function initialize(maxPoolSize:uint, growthValue:uint, clazz:Class):void {
			var newPool:PoolItem = new PoolItem(maxPoolSize, growthValue, clazz);
			var i:uint = maxPoolSize;
			while (--i > -1) {
				newPool.pool[i] = ClassUtil.createNewInstance(clazz) as IRecyclable;
			}
			
			var className:String = getQualifiedClassName(clazz);
			pools[className] = newPool;
		}
		
		/**
		 * 根据类名获取对象
		 */
		public static function getObject(clazz:Class):IRecyclable {
			var className:String = getQualifiedClassName(clazz);
			if (!pools[className]) {
				initialize(DEFAULT_MAX_POOL_SIZE, DEFAULT_GROWTH_VALUE, clazz);
			}
			
			var poolItem:PoolItem = pools[className];
			if (poolItem.counter > 0) {
				return poolItem.pool[--poolItem.counter];
			}
			
			var i:uint = poolItem.growthValue;
			while (--i > -1) {
				poolItem.pool.unshift(ClassUtil.createNewInstance(clazz));
			}
			poolItem.counter = poolItem.growthValue;
			return getObject(clazz);
		}
		
		/**
		 * 回收对象
		 */
		public static function disposeObject(disposedObject:IRecyclable):void {
			disposedObject.reinitialize();
			var className:String = getQualifiedClassName(disposedObject);
			var poolItem:PoolItem = pools[className];
			poolItem.pool[poolItem.counter++] = disposedObject;
		}
	}
}

import com.canaan.lib.base.interfaces.IRecyclable;

class PoolItem
{
	public var counter:uint;
	public var growthValue:uint;
	public var clazz:Class;
	public var pool:Vector.<IRecyclable>;
	
	public function PoolItem(maxPoolSize:uint, growthValue:uint, clazz:Class)
	{
		this.counter = maxPoolSize;
		this.growthValue = growthValue;
		this.clazz = clazz;
		pool = new Vector.<IRecyclable>(counter);
	}
}