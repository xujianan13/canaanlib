package testPackage.core
{
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.BytesLoader;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.ResourceManager;
	import com.canaan.lib.rpg.core.model.action.ActionVo;
	import com.canaan.lib.rpg.core.model.objects.PlayerVo;
	import com.canaan.lib.rpg.core.objects.PlayerObject;
	import com.canaan.lib.rpg.utils.ActionUtil;
	
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	public class TestBytesLoader extends Sprite
	{
		private var headData:Object;
		
		public function TestBytesLoader()
		{
			super();
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			ResourceManager.getInstance().add("assets/test.byte", "", "", new Method(onComplete));
			ResourceManager.getInstance().load();
		}
		
		private function onComplete(content:*):void {
			var bytes:ByteArray = content;
			var obj:Object = ActionUtil.analysis(bytes);
			headData = obj.headData;
			var bytesLoader:BytesLoader = new BytesLoader();
			bytesLoader.load(obj.swfBytes, new Method(onBytesComplete));
		}
		
		private function onBytesComplete(content:*):void {
//			var bitmapData:BitmapData = ResourceManager.getInstance().getBitmapData("chitu_1_1_0000");
//			addChild(new Bitmap(bitmapData));
			
			var actionVo:ActionVo = new ActionVo();
			actionVo.setHeadData(headData);
			
			var vo:PlayerVo = new PlayerVo();
			vo.mapX = 50;
			vo.mapY = 50;
			
			var object:PlayerObject = new PlayerObject();
			object.vo = vo;
			object.updateSkin(actionVo);
			object.view.moveTo(200, 200);
			addChild(object.view);
			
			object.playAction(2, 3);
		}
	}
}