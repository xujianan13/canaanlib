package testPackage.component
{
	import com.canaan.lib.base.component.controls.LinkButton;
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	
	import flash.display.Sprite;
	
	public class TestLinkButton extends Sprite
	{
		public function TestLinkButton()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			var linkButton:LinkButton = new LinkButton("linkButton");
			addChild(linkButton);
		}
	}
}