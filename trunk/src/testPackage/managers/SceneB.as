package testPackage.managers
{
	import com.canaan.lib.base.abstract.AbstractScene;
	
	public class SceneB extends AbstractScene
	{
		private var moduleB:ModuleB;
		
		public function SceneB(sceneName:String)
		{
			super(sceneName);
		}
		
		override public function enterScene():void {
			if (!moduleB) {
				moduleB = new ModuleB();
			}
			moduleB.addedToScene(sceneName);
			super.enterScene();
		}
	}
}