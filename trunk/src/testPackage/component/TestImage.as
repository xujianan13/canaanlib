package testPackage.component
{
	import com.canaan.lib.base.component.controls.Image;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestImage extends Sprite
	{
		private var image:Image;
		private var image2:Image;
		private var image3:Image;
		
		public function TestImage()
		{
			Application.initialize(this);
			
			image = new Image();
			image.scale9 = "0,0,0,0";
			image.width = 100;
			image.height = 200;
			addChild(image);
			ResourceManager.getInstance().add("assets/comp.swf", new Method(complete));
			ResourceManager.getInstance().load();
		}
		
		private function complete(content:*):void {
			image.url = "assets/btn_blue.png";
			image.url = "assets/Altar.png";
//			image.showBorder();
			image2 = new Image("assets/btn_blue.png");
			image2.scale9 = "5,5,5,5";
			image2.width = 100;
			image2.height = 200;
			addChild(image2);
			image2.x = 200;
			image2.y = 200;
			
//			image.url = "assets/btn_blue.png";
			
//			image2.width = 50;
//			image2.height = 50;
//			image2.showBorder();
//			image2.x = 100;
//			addChild(image2);
//			image3 = new Image("assets/Altar.png");
//			image3.y = 100;
//			image3.showBorder();
//			addChild(image3);
		}
	}
}