package
{
	import com.canaan.lib.base.component.controls.Button;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	import flash.text.TextFormatAlign;
	import flash.utils.setTimeout;
	
	public class TestButton extends Sprite
	{
		private var button:Button;
		
		public function TestButton()
		{
			Application.initialize(this);
			button = new Button();
			button.label = "test";
			addChild(button);
			ResourceManager.getInstance().add("assets/comp.swf", new MethodElement(complete));
			ResourceManager.getInstance().load();
		}
		
		private function complete(content:*):void {
			button.skin = "png.comp.btn_blue";
			button.label = "test1";
			button.mouseClickHandler = new MethodElement(mouseClick);
			setTimeout(o, 500);
//			button.label = "ddddddd";
//			button.selected = true;
//			button.toggle = true;
//			button.disabled = true;
			
//			var tiles:Array = ResourceManager.getInstance().getTiles("png.comp.btn_blue", 1, 3);
//			var bitmap:Bitmap = new Bitmap(tiles[0]);
//			addChild(bitmap);
		}
		
		private function o():void {
			button.btnLabel.showBorder();
			trace(button.btnLabel.align);
			trace(button.btnLabel.width);
		}
		
		private function mouseClick():void {
			button.label = "f";
//			button.btnLabel.width = 100;
			setTimeout(o, 500);
		}
	}
}