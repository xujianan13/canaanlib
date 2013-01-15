package testPackage.managers
{
	import com.canaan.lib.base.abstract.AbstractScene;
	
	public class SceneA extends AbstractScene
	{
		private var moduleA:ModuleA;
		
		public function SceneA(sceneName:String)
		{
			super(sceneName);
		}
		
		override public function enterScene():void {
			if (!moduleA) {
				moduleA = new ModuleA();
			}
			moduleA.addedToScene(sceneName);
			super.enterScene();
		}
	}
}