package testPackage.core
{
	import com.canaan.lib.base.core.BytesLoader;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.ResourceManager;
	import com.canaan.lib.rpg.core.model.action.ActionVo;
	
	import flash.display.Sprite;
	import flash.utils.ByteArray;
	
	public class TestBytesLoader extends Sprite
	{
		public function TestBytesLoader()
		{
			super();
			ResourceManager.getInstance().add("assets/test.byte", "", "", new Method(onComplete));
			ResourceManager.getInstance().load();
		}
		
		private function onComplete(content:*):void {
			var bytes:ByteArray = content;
			var lengthHeadData:int = bytes.readInt();
			var lengthSWF:int = bytes.readInt();
			var bytesHeadData:ByteArray = new ByteArray();
			var bytesSWF:ByteArray = new ByteArray();
			bytes.readBytes(bytesHeadData, 0, lengthHeadData);
			bytes.readBytes(bytesSWF, 0, lengthSWF);
			var headData:Object = bytesHeadData.readObject();
			var bytesLoader:BytesLoader = new BytesLoader();
			bytesLoader.load(bytesSWF, new Method(onBytesComplete));
		}
		
		private function onBytesComplete():void {
//			var bitmapData:BitmapData = ResourceManager.getInstance().getBitmapData("chitu_1_1_0000");
//			addChild(new Bitmap(bitmapData));
			
			var headData:Object = {
				id:"chitu",
				actions:{
					1:{
						1:{
							1:{
								x:5,
								y:5,
								delay:1
							},
							2:{
								x:5,
								y:5,
								delay:1
							}
						},
						2:{
							1:{
								x:5,
								y:5,
								delay:1
							},
							2:{
								x:5,
								y:5,
								delay:1
							}
						}
					}
				}
			};
			
			var actionVo:ActionVo = new ActionVo();
			actionVo.setHeadData(headData);
		}
	}
}