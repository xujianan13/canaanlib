package
{
	import com.canaan.lib.base.component.Direction;
	import com.canaan.lib.base.component.controls.Image;
	import com.canaan.lib.base.component.controls.Canvas;
	import com.canaan.lib.base.component.controls.VScrollBar;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	public class TestPanel extends Sprite
	{
		private var panel:Canvas;
		private var image:Image;
		
		public function TestPanel()
		{
			super();
			
			Application.initialize(this);
			ResourceManager.getInstance().add("assets/comp.swf", new MethodElement(complete));
			ResourceManager.getInstance().load();
		}
		
		private function complete(content:*):void {
			panel = new Canvas();
			panel.scrollBarSkin = "png.comp.vscroll";
			addChild(panel);
			
			image = new Image("png.comp.btn_blue");
			image.addEventListener(MouseEvent.CLICK, onClick);
			panel.addChild(image);
			panel.direction = Direction.HORIZONTAL;
			
			var vScrollBar:VScrollBar = new VScrollBar();
			vScrollBar.x = 100;
			addChild(vScrollBar);
			vScrollBar.skin = "png.comp.vscroll";
		}
		
		private function onClick(event:MouseEvent):void {
			image.width = Math.random() * 400;
			image.height = Math.random() * 400;
			panel.refresh();
		}
	}
}