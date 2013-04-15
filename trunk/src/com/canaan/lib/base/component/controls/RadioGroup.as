package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.IListItem;
	import com.canaan.lib.base.component.Layouts;
	import com.canaan.lib.base.core.Method;
	
	public class RadioGroup extends ListBase
	{
		protected var _skin:String;
		protected var _labels:String;
		protected var _labelColors:String;
		protected var _labelStroke:String;
		protected var _labelSize:Object;
		protected var _labelBold:Object;
		protected var _labelField:String;
		
		public function RadioGroup(labels:String = null, skin:String = null)
		{
			this.labels = labels;
			this.skin = skin;
		}
		
		override protected function initialize():void {
			super.initialize();
			layout = Layouts.HORIZONTAL;
		}
		
		override public function initialItems():void {
			_data = [];
			if (numChildren != 0) {
				layout = Layouts.ABSOLUTE;
				var item:RadioButton;
				for (var i:int = 0; i < numChildren; i++) {
					item = getChildAt(i) as RadioButton;
					if (item != null) {
						_data.push(item.data);
						item.data = item.data;
						item.selected = false;
						item.mouseClickHandler = new Method(itemClickHandler, [item]);
						_items.push(item);
					}
				}
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
		
		override public function set data(value:Object):void {
			if (_data != value) {
				_data = value;
				callLater(changeLabels);
			}
		}
		
		public function set labels(value:String):void {
			if (_labels != value) {
				_labels = value;
				_data = value.split(",");
				callLater(changeLabels);
			}
		}
		
		public function get labels():String {
			return _labels;
		}
		
		protected function changeLabels():void {
			if (_data == null) {
				return;
			}
			removeAllChildren();
			_items.length = 0;
			var item:RadioButton;
			var l:int = _data.length;
			var label:String;
			for (var i:int = 0; i < l; i++) {
				label = _labelField ? _data[i][_labelField].toString() : _data[i].toString();
				item = new RadioButton(_skin, label);
				item.data = _data[i];
				item.selected = false;
				item.mouseClickHandler = new Method(itemClickHandler, [item]);
				_items[i] = addChild(item) as IListItem;
				if (_labelColors) {
					item.labelColors = _labelColors;
				}
				if (_labelStroke) {
					item.labelStroke = _labelStroke;
				}
				if (_labelSize) {
					item.labelSize = _labelSize;
				}
				if (_labelBold) {
					item.labelBold = _labelBold;
				}
			}
			if (_data.length > 0) {
				selectedValue = _selectedValue || _data[0];
				selectedItem.selected = true;
			} else {
				selectedValue = null;
			}
		}
		
		public function get labelColors():String {
			return _labelColors;
		}
		
		public function set labelColors(value:String):void {
			if (_labelColors != value) {
				_labelColors = value;
				callLater(changeLabels);
			}
		}
		
		public function get labelStroke():String {
			return _labelStroke;
		}
		
		public function set labelStroke(value:String):void {
			if (_labelStroke != value) {
				_labelStroke = value;
				callLater(changeLabels);
			}
		}
		
		public function get labelSize():Object {
			return _labelSize;
		}
		
		public function set labelSize(value:Object):void {
			if (_labelSize != value) {
				_labelSize = value;
				callLater(changeLabels);
			}
		}
		
		public function get labelBold():Object {
			return _labelBold;
		}
		
		public function set labelBold(value:Object):void {
			if (_labelBold != value) {
				_labelBold = value;
				callLater(changeLabels);
			}
		}
		
		public function get labelField():String {
			return _labelField;
		}
		
		public function set labelField(value:String):void {
			if (_labelField != value) {
				_labelField = value;
				callLater(changeLabels);
			}
		}
	}
}