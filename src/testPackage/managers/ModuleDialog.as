package testPackage.managers
{
	import com.canaan.lib.base.component.controls.Dialog;
	import com.canaan.lib.base.component.controls.Label;
	
	public class ModuleDialog extends Dialog
	{
		private static var instance:ModuleDialog;
		private var label:Label;
		
		public function ModuleDialog()
		{
			super();
		}
		
		public static function getIns():ModuleDialog {
			if (!instance) {
				instance = new ModuleDialog();
			}
			return instance;
		}
		
		override protected function createChildren():void {
			super.createChildren();
			label = new Label();
			addChild(label);
		}
		
		public function setText(value:String):void {
			label.text = value;
		}
	}
}