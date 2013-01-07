package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.core.Method;

	public class Tab extends ListBase
	{
		protected var _skin:String;
		protected var _labels:String;
		
		public function Tab(labels:String = null, skin:String = null)
		{
			this.labels = labels;
			this.skin = skin;
		}
		
		override public function initialItems():void {
			_data = [];
			var item:Button;
			for (var i:int = 0; i < numChildren; i++) {
				item = getChildAt(i) as Button;
				if (item != null) {
					_data.push(item.label);
					item.data = item.label;
					item.selected = false;
					item.mouseClickHandler = new Method(itemClickHandler, [item]);
					_items.push(item);
				}
			}
			if (_data.length > 0) {
				selectedValue = _data[0];
			}
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				callLater(changeLabels);
			}
		}
		
		public function get skin():String {
			return _skin;
		}
		
		public function set labels(value:String):void {
			if (_labels != value) {
				_labels = value;
				_data = _labels.split(",");
				callLater(changeLabels);
			}
		}
		
		public function get labels():String {
			return _labels;
		}
		
		protected function changeLabels():void {
			removeAllChildren();
			_items.length = 0;
			var item:Button;
			var l:int = _data.length;
			for (var i:int = 0; i < l; i++) {
				item = _skin ? new Button(_skin, _data[i]) : new LinkButton(_data[i]);
				item.data = _data[i];
				item.selected = false;
				item.mouseClickHandler = new Method(itemClickHandler, [item]);
				_items[i] = addChild(item);
			}
			if (_data.length > 0) {
				selectedValue = _selectedValue || _data[0];
			} else {
				selectedValue = null;
			}
		}
	}
}