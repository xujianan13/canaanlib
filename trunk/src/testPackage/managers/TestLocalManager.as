package testPackage.managers
{
	import com.canaan.lib.base.managers.LocalManager;
	
	import flash.display.Sprite;
	
	public class TestLocalManager extends Sprite
	{
		public function TestLocalManager()
		{	
			LocalManager.getInstance().loadResources("test = testString", "test");
			trace(LocalManager.getInstance().getString("test", "test"));
			trace(LocalManager.getInstance().getString("test1", "test"));
		}
	}
}