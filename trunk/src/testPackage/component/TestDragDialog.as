package testPackage.component
{
	import com.canaan.lib.base.component.controls.DragDialog;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	
	import flash.display.Sprite;
	
	public class TestDragDialog extends Sprite
	{
		public function TestDragDialog()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			var dragDialog:DragDialog = new DragDialog();
			dragDialog.graphics.beginFill(0xFFFFFF * Math.random(), Math.random());
			dragDialog.graphics.drawRect(0, 0, 600 * Math.random(), 400 * Math.random());
			dragDialog.graphics.endFill();
			addChild(dragDialog);
		}
	}
}