package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.utils.ArrayUtil;
	
	import flash.events.MouseEvent;
	import flash.text.TextFieldAutoSize;

	public class ComboBoxItem extends ListItem
	{
		protected var _label:Label;
		protected var _itemColors:Array;
		
		public function ComboBoxItem()
		{
			super();
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			_itemColors = Styles.comboBoxItemColors;
		}
		
		override protected function createChildren():void {
			super.createChildren();
			_label = new Label();
			_label.width = Styles.comboBoxItemWidth;
			_label.height = Styles.comboBoxItemHeight;
			_label.margin = Styles.comboBoxLabelMargin;
			addChild(_label);
		}
		
		override protected function initialize():void {
			super.initialize();
			_label.autoSize = TextFieldAutoSize.NONE;
		}

		override protected function refresh():void {
			_label.text = _data.toString();
		}
		
		override public function set selected(value:Boolean):void {
			super.selected = value;
			if (_selected) {
				onMouseOver(null);
			} else {
				onMouseOut(null);
			}
		}
		
		override protected function onMouseOver(event:MouseEvent):void {
			_label.background = true;
			_label.backgroundColor = _itemColors[0];
			_label.color = _itemColors[1];
		}
		
		override protected function onMouseOut(event:MouseEvent):void {
			if (!_selected) {
				_label.background = false;
				_label.color = _itemColors[2];
			}
		}
		
		public function get label():Label {
			return _label;
		}
		
		public function get itemColors():String {
			return _itemColors.toString();
		}
		
		public function set itemColors(value:String):void {
			_itemColors = ArrayUtil.copyAndFill(_itemColors, value);
		}
	}
}