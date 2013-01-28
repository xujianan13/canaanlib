package testPackage.component
{
	import com.canaan.lib.base.component.controls.TextArea;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestTextArea extends Sprite
	{
		private var textArea:TextArea;
		
		public function TestTextArea()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			ResourceManager.getInstance().add("assets/comp.swf");
			ResourceManager.getInstance().load(new Method(complete));
		}
		
		private function complete():void {
			textArea = new TextArea();
			addChild(textArea);
			textArea.scrollBarSkin = "png.comp.vscroll";
			textArea.text = "圣达菲圣达菲第三方第三方第三方圣达菲第三方速度佛挡杀佛第三方圣达菲都是" +
				"圣达菲圣达菲第三方第三方第三方圣达菲第三方速度佛挡杀佛第三方圣达菲都是" +
				"圣达菲圣达菲第三方第三方第三方圣达菲第三方速度佛挡杀佛第三方圣达菲都是" + 
				"圣达菲圣达菲第三方第三方第三方圣达菲第三方速度佛挡杀佛第三方圣达菲都是" +
				"圣达菲圣达菲第三方第三方第三方圣达菲第三方速度佛挡杀佛第三方圣达菲都是" +
				"圣达菲圣达菲第三方第三方第三方圣达菲第三方速度佛挡杀佛第三方圣达菲都是";
//			textArea.stroke = null;
			textArea.width = 202;
			textArea.height = 200;
		}
	}
}