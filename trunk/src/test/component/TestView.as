package test.component
{
	import com.canaan.lib.base.component.controls.Button;
	import com.canaan.lib.base.component.controls.Container;
	import com.canaan.lib.base.component.controls.View;
	import com.canaan.lib.base.component.controls.ViewStack;
	
	public class TestView extends View
	{
		public var id:String;
		public var container:Container;
		public var btnClose:Button;
		public var vs:ViewStack;
		
		private var xml:XML = 
			<View id="v">
				<Container var="container" top="5" left="5">
					<RadioGroup var="radioGroup" layout="horizontal" gap="5">
						<RadioButton skin="png.comp.radio" label="fuck"/>
					</RadioGroup>
					<Button skin="png.comp.btn_close" x="365" y="0" var="btnClose" toolTip="close"/>
	 				<ViewStack x="407" y="257" var="vs">
				   		<Label text="view1" y="0"/>
				    	<LinkButton label="view2" x="47" y="0"/>
			 		</ViewStack>
				</Container>
			</View>;
		
		public function TestView()
		{
			super();
			createView(xml);
		}
	}
}