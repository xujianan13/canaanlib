package testPackage.managers
{
	import com.canaan.lib.base.abstract.AbstractModule;
	
	public class ModuleB extends AbstractModule
	{
		public function ModuleB()
		{
			super();
		}
		
		override public function addedToScene(sceneName:String):void {
			ModuleDialog.getIns().setText("ModuleB");
			ModuleDialog.getIns().show();
			super.addedToScene(sceneName);
		}
	}
}