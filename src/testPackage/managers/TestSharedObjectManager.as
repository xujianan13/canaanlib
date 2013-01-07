package testPackage.managers
{
	import com.canaan.lib.base.managers.SharedObjectManager;
	
	import flash.display.Sprite;
	
	public class TestSharedObjectManager extends Sprite
	{
		public function TestSharedObjectManager()
		{
			SharedObjectManager.privateSign = "test2";
			SharedObjectManager.getInstance().preAllocated();
			
			
			trace(SharedObjectManager.getInstance().hasPrivate("testObj4"));
			SharedObjectManager.getInstance().removePrivate("testObj4");
//			trace(SharedObjectManager.getInstance().getPublic("testPublic"));
//			trace(SharedObjectManager.getInstance().getPrivate("testObj4"));
//			trace(SharedObjectManager.getInstance().getPrivate("testPrivate"));
			
			var obj:Object = new Object();
			obj.a = 1;
//			SharedObjectManager.getInstance().putPrivate("testObj4", obj);
//			SharedObjectManager.getInstance().putPrivate("testPrivate", 5);
//			SharedObjectManager.getInstance().flush();
			
//			SharedObjectManager.getInstance().putPublic("testPublic", obj);
		}
	}
}