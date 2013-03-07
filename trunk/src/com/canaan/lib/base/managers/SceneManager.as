package com.canaan.lib.base.managers
{
	import com.canaan.lib.base.debug.Log;
	import com.canaan.lib.base.events.SceneEvent;
	import com.canaan.lib.base.interfaces.IScene;
	
	import flash.utils.Dictionary;

	public class SceneManager
	{
		private static var canInstantiate:Boolean;
		private static var instance:SceneManager;
		
		private var dictionary:Dictionary = new Dictionary();
		private var currentScene:IScene;
		private var nextScene:IScene;
		
		public function SceneManager()
		{
			if (!canInstantiate) {
				throw new Error("Can not instantiate, use getInstance() instead.");
			}
		}
		
		public static function getInstance():SceneManager {
			if (instance == null) {
				canInstantiate = true;
				instance = new SceneManager();
				canInstantiate = false;
			}
			return instance;
		}
		
		public function registerScene(scene:IScene):void {
			var sceneName:String = scene.sceneName;
			if (dictionary[sceneName]) {
				Log.getInstance().error("SceneManager.registerScene \"" + sceneName + "\" has already registered!");
				return;
			}
			dictionary[sceneName] = scene;
		}
		
		public function deleteScene(scene:IScene):void {
			delete dictionary[scene.sceneName];
		}
		
		public function enterScene(scene:IScene):void {
			var sceneName:String = scene.sceneName;
			nextScene = dictionary[sceneName];
			if (!nextScene) {
				Log.getInstance().error("SceneManager.enterScene \"" + sceneName + "\" has not registered!");
				return;
			}
			if (!exitCurrentScene()) {
				enterNextScene();
			}
		}
		
		private function exitCurrentScene():Boolean {
			if (!currentScene) {
				return false;
			}
			ModuleManager.getInstance().removeModules(currentScene.sceneName);
			currentScene.addEventListener(SceneEvent.EXIT_SCENE, onExitScene);
			currentScene.exitScene();
			return true;
		}
		
		private function onExitScene(event:SceneEvent):void {
			currentScene.removeEventListener(SceneEvent.EXIT_SCENE, onExitScene);
			enterNextScene();
		}
		
		private function enterNextScene():void {
			nextScene.enterScene();
			currentScene = nextScene;
			nextScene = null
		}
	}
}