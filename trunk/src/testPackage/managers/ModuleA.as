package testPackage.managers
{
	import com.canaan.lib.base.abstract.AbstractModule;
	
	public class ModuleA extends AbstractModule
	{
		public function ModuleA()
		{
			super();
		}
		
		override public function addedToScene(sceneName:String):void {
			ModuleDialog.getIns().setText("ModuleA");
			ModuleDialog.getIns().show(true);
			super.addedToScene(sceneName);
		}
	}
}