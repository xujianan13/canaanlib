package testPackage.component
{
	import com.canaan.lib.base.component.controls.LinkButton;
	import com.canaan.lib.base.core.Application;
	
	import flash.display.Sprite;
	
	public class TestLinkButton extends Sprite
	{
		public function TestLinkButton()
		{
			Application.initialize(this);
			
			var linkButton:LinkButton = new LinkButton("linkButton");
			addChild(linkButton);
		}
	}
}