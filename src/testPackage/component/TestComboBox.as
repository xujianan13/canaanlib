package testPackage.component
{
	import com.canaan.lib.base.component.Position;
	import com.canaan.lib.base.component.controls.ComboBox;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.events.UIEvent;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.display.Sprite;
	
	public class TestComboBox extends Sprite
	{
		private var comboBox:ComboBox;
		
		public function TestComboBox()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			ResourceManager.getInstance().add("assets/comp.swf");
			ResourceManager.getInstance().load(new Method(complete));
			ResourceManager.getInstance().add("assets/bear.swf");
			ResourceManager.getInstance().load(new Method(complete2));
		}
		
		private function complete2():void {
			trace("complete2");
			ResourceManager.getInstance();
		}
		
		private function complete():void {
			trace("complete")
			comboBox = new ComboBox("png.comp.combobox", "类可使用表示,位带符号整数的数据,这意味着无需对象,不需要使用构造函数,这意味着需要对象才能,不需要浮点数,如果您正在处理超过,无需使用构造函数");
			comboBox.width = 150;
			comboBox.maxRows = 7;
//			comboBox.scrollBarSkin = "png.comp.vscroll";
			comboBox.x = 100;
			comboBox.y = 100;
			comboBox.position = Position.RIGHT;
			addChild(comboBox);
			
			comboBox.dispatcher.addEventListener(UIEvent.CHANGE, onChange);
		}
		
		private function onChange(event:UIEvent):void {
//			comboBox.width = 150;
//			comboBox.maxRows = 7;
		}
	}
}