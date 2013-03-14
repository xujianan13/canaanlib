package testPackage.component
{
	import com.canaan.lib.base.component.Layouts;
	import com.canaan.lib.base.component.controls.Button;
	import com.canaan.lib.base.component.controls.CheckBox;
	import com.canaan.lib.base.component.controls.ListItem;
	import com.canaan.lib.base.component.controls.RadioButton;
	
	public class TestListItem extends ListItem
	{
		private var button:Button;
		
		public function TestListItem()
		{
			super();
		}
		
		override protected function createChildren():void {
			super.createChildren();
			button = new Button("png.comp.btn_blue", "oye");
			addChild(button);
			var radio:CheckBox = new CheckBox("png.comp.checkbox", "fuck");
			addChild(radio);
		}
		
		override protected function initialize():void {
			super.initialize();
			layout = Layouts.HORIZONTAL;
		}
		
		override public function refresh():void {
			button.label = _data.toString();
		}
	}
}