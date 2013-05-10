package com.canaan.lib.base.abstract
{
	import com.canaan.lib.base.events.CEventDispatcher;
	import com.canaan.lib.base.events.ModuleEvent;
	import com.canaan.lib.base.interfaces.IModule;
	import com.canaan.lib.base.managers.ModuleManager;
	
	public class AbstractModule extends CEventDispatcher implements IModule
	{
		protected var _sceneName:String;
		protected var _initialized:Boolean;
		
		public function AbstractModule()
		{
			registerModule();
		}
		
		public function addedToScene(sceneName:String):void {
			_sceneName = sceneName;
			if (!_initialized) {
				initialize();
				_initialized = true;
			}
			show();
			dispatch(ModuleEvent.ADDED_TO_SCENE);
		}
		
		public function removeFromScene():void {
			_sceneName = null;
			remove();
			dispatch(ModuleEvent.REMOVE_FROM_SCENE);
		}
		
		protected function initialize():void {
			
		}
		
		protected function show():void {
			
		}
		
		protected function remove():void {
			
		}
		
		private function dispatch(type:String):void {
			var event:ModuleEvent = ModuleEvent.fromPool(type);
			dispatchEvent(event);
			ModuleEvent.toPool(event);
		}
		
		public function registerModule():void {
			ModuleManager.getInstance().registerModule(this);
		}
		
		public function deleteModule():void{
			ModuleManager.getInstance().deleteModule(this);
		}
		
		public function get sceneName():String {
			return _sceneName;
		}
		
		public function get initialized():Boolean {
			return _initialized;
		}
	}
}