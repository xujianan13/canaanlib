package com.canaan.lib.base.abstract
{
	import com.canaan.lib.base.events.CEventDispatcher;
	import com.canaan.lib.base.events.SceneEvent;
	import com.canaan.lib.base.interfaces.IModule;
	import com.canaan.lib.base.interfaces.IScene;
	import com.canaan.lib.base.managers.SceneManager;
	
	public class AbstractScene extends CEventDispatcher implements IScene
	{
		protected var _sceneName:String;
		
		public function AbstractScene(sceneName:String)
		{
			_sceneName = sceneName;
			registerScene();
		}
		
		public function enterScene():void {
			dispatch(SceneEvent.ENTER_SCENE);
		}
		
		public function exitScene():void {
			dispatch(SceneEvent.EXIT_SCENE);
		}
		
		private function dispatch(type:String):void {
			var event:SceneEvent = SceneEvent.fromPool(type);
			dispatchEvent(event);
			SceneEvent.toPool(event);
		}
		
		public function registerScene():void {
			SceneManager.getInstance().registerScene(this);
		}
		
		public function deleteScene():void {
			SceneManager.getInstance().deleteScene(this);
		}

		public function get sceneName():String {
			return _sceneName;
		}
		
		public function set sceneName(value:String):void {
			_sceneName = value;
		}
		
		public function showModule(module:IModule):void {
			module.addedToScene(_sceneName);
		}
		
		public function removeModule(module:IModule):void {
			module.removeFromScene();
		}
	}
}