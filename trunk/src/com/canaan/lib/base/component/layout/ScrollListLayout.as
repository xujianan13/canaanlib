package com.canaan.lib.base.component.layout
{
	import com.canaan.lib.base.component.controls.ScrollList;

	public class ScrollListLayout extends ListLayout
	{
		public function ScrollListLayout()
		{
			super();
		}
		
		override public function updateDisplayList():void {
			super.updateDisplayList();
			scrollList.resetSrollBarPosition();
		}
		
		protected function get scrollList():ScrollList {
			return _target as ScrollList;
		}
	}
}