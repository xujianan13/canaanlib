package test.component
{
	import com.canaan.lib.base.component.controls.TextArea;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.MethodElement;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestTextArea extends Sprite
	{
		private var textArea:TextArea;
		
		public function TestTextArea()
		{
			Application.initialize(this);
			
			textArea = new TextArea();
			textArea.text = "圣达菲圣达菲第三方第三方第三方圣达菲第三方速度佛挡杀佛第三方圣达菲都是" +
				"圣达菲圣达菲第三方第三方第三方圣达菲第三方速度佛挡杀佛第三方圣达菲都是" +
				"圣达菲圣达菲第三方第三方第三方圣达菲第三方速度佛挡杀佛第三方圣达菲都是" + 
				"圣达菲圣达菲第三方第三方第三方圣达菲第三方速度佛挡杀佛第三方圣达菲都是" +
				"圣达菲圣达菲第三方第三方第三方圣达菲第三方速度佛挡杀佛第三方圣达菲都是" +
				"圣达菲圣达菲第三方第三方第三方圣达菲第三方速度佛挡杀佛第三方圣达菲都是";
			addChild(textArea);
			
			ResourceManager.getInstance().add("assets/comp.swf", new MethodElement(complete));
			ResourceManager.getInstance().load();
		}
		
		private function complete(content:*):void {
			textArea.scrollBarSkin = "png.comp.vscroll";
//			textArea.stroke = null;
			textArea.width = 200;
			textArea.height = 200;
		}
	}
}