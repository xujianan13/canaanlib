package testPackage.managers
{
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.events.SocketEvent;
	import com.canaan.lib.base.managers.SocketManager;
	import com.canaan.lib.base.net.ServerRequest;
	
	import flash.display.Sprite;
	
	public class TestSocketMananger extends Sprite
	{
		public function TestSocketMananger()
		{
			super();
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			SocketManager.getInstance().addEventListener(SocketEvent.CONNECT, onConnect);
			SocketManager.getInstance().addEventListener(SocketEvent.IO_ERROR, onIoError);
			SocketManager.getInstance().addEventListener(SocketEvent.SECURITY_ERROR, onSecurityError);
			SocketManager.getInstance().addEventListener(SocketEvent.CONNECT, onConnect);
			SocketManager.getInstance().connect("127.0.0.1", 8080);
		}
		
		private function onConnect():void {
			trace("onConnect");
			SocketManager.getInstance().registerHandler(1, testFunc);
			
			SocketManager.getInstance().send(1, "test");
		}
		
		private function testFunc(result:ServerRequest):void {
			trace(result.data);
		}
		
		private function onIoError():void {
			trace("onIoError");
		}
		
		private function onSecurityError():void {
			trace("onSecurityError");
		}
	}
}