package testPackage.managers
{
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.DialogManager;
	import com.canaan.lib.base.managers.SceneManager;
	import com.canaan.lib.base.managers.TimerManager;
	
	import flash.display.Sprite;
	
	public class TestSceneManager extends Sprite
	{
		private var sceneA:SceneA;
		private var sceneB:SceneB;

		public function TestSceneManager()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			addChild(DialogManager.getInstance());
			
			sceneA = new SceneA("sceneA");
			sceneB = new SceneB("sceneB");
			
			SceneManager.getInstance().enterScene(sceneA);
			
			TimerManager.getInstance().doOnce(1000, changeScene);
		}
		
		private function changeScene():void {
			SceneManager.getInstance().enterScene(sceneB);
		}
	}
}