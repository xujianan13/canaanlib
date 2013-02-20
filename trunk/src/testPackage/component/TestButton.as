package testPackage.component
{
	import com.canaan.lib.base.component.Position;
	import com.canaan.lib.base.component.controls.Button;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.ResourceManager;
	import com.canaan.lib.base.managers.ToolTipManager;
	
	import flash.display.Sprite;
	
	public class TestButton extends Sprite
	{
		private var button:Button;
		
		public function TestButton()
		{
			Application.initialize(this, new Method(onInitializeComplete));
			trace(ResourceManager.getInstance().current.name);
		}
		
		private function onInitializeComplete():void {
			addChild(ToolTipManager.getInstance());
			ToolTipManager.getInstance().hideDelay = 2000;
			ResourceManager.getInstance().add("assets/main.swf");
			ResourceManager.getInstance().load(new Method(complete));
		}
		
		private function complete():void {
//			button = new Button("png.comp.btn_blue", "test1");
			button = new Button();
			button.skin = "png.main.btn_blue";
			button.label = "label1";
			addChild(button);
			button.selected = true;
			button.left = 5;
			button.top = 5;
			button.toolTip = "fucku";
			button.toolTipPosition = Position.BELOW;
			button.mouseClickHandler = new Method(mouseClick);
			
			
//			var label:Label = new Label("test", "png.comp.btn_blue");
//			label.width = 100;
//			label.height = 50;
//			addChild(label);
			
//			var button2:Button = new Button("png.comp.btn_blue", "test2");
//			button2.x = 100;
//			button2.toolTip = "fucj2u";
//			button2.width = 100;
//			button2.height = 50;
//			button2.scale9 = "5,5,5,5";
//			addChild(button2);
//			button2.mouseClickHandler = new Method(mouseClick);
			
//			setTimeout(o, 500);
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
			button.width = Math.random() * 200;
		}
	}
}