package com.canaan.lib.base.component.layout
{
	import com.canaan.lib.base.component.controls.Tree;
	import com.canaan.lib.base.component.controls.TreeListItem;
	import com.canaan.lib.base.events.UIEvent;

	public class TreeLayout extends Layout
	{
		public function TreeLayout()
		{
			super();
		}
		
		public function updateDisplayList():void {
			var yy:int;
			for each (var item:TreeListItem in tree.items) {
				item.y = yy;
				yy += item.height;
			}
			tree.sendEvent(UIEvent.RESIZE);
		}
		
		protected function get tree():Tree {
			return _target as Tree;
		}
	}
}