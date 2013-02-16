package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.IListItem;
	import com.canaan.lib.base.component.Position;
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.base.events.UIEvent;
	import com.canaan.lib.base.managers.StageManager;
	import com.canaan.lib.base.utils.ArrayUtil;
	
	import flash.events.MouseEvent;
	
	[Event(name="change", type="com.canaan.lib.base.events.UIEvent")]
	
	/**
	 * 该类暂时存在一些问题：动态修改宽度后下拉框的子项无法动态修改宽度
	 * 若想要改变宽度，应在初始化帧里设置宽度，避免在运行中动态修改宽度
	 * 
	 */
	public class ComboBox extends Container
	{
		protected var _labels:String;
		protected var _button:Button;
		protected var _list:ScrollList;
		protected var _labelField:String;
		protected var _isOpen:Boolean;
		protected var _listColors:Array;
		protected var _maxRows:int;
		protected var _position:String;				// Position枚举，BELOW为下方 ，ABOVE为上方，LEFT为左方，RIGHT为右方
		protected var _defaultText:String;
		protected var _changeCallback:Method;
		
		public function ComboBox(skin:String = null, labels:String = null)
		{
			this.skin = skin;
			this.labels = labels;
		}
		
		override protected function preinitialize():void {
			super.preinitialize();
			_maxRows = Styles.comboBoxMaxRows;
			_listColors = Styles.comboBoxListColors;
			_position = Position.BELOW;
		}
		
		override protected function createChildren():void {
			super.createChildren();
			_button = new Button();
			addChild(_button);
			_list = new ScrollList("ComboBoxItem", null, _maxRows, 1);
		}
		
		override protected function initialize():void {
			super.initialize();
			_button.btnLabel.align = Styles.comboBoxLabelAlign;
			_button.labelMargin = Styles.comboBoxLabelMargin;
			_button.toggle = true;
			_button.addEventListener(MouseEvent.CLICK, onButtonClick);
			
			_list.changeCallback = new Method(onListChange);
			_list.scrollBar.addEventListener(MouseEvent.CLICK, onScrollBarClick);
			_list.callLater(changeListWidth);
		}
		
		protected function onScrollBarClick(event:MouseEvent):void {
			event.stopPropagation();
		}
		
		protected function onButtonClick(event:MouseEvent):void {
			if (!_isOpen) {
				callLater(changeOpen);
			}
		}
		
		protected function onListChange(value:Object):void {
			changeLabel();
			sendEvent(UIEvent.CHANGE);
			if (_changeCallback != null) {
				_changeCallback.apply();
			}
		}
		
		protected function changeOpen():void {
			isOpen = !_isOpen;
		}
		
		protected function changeLabel():void {
			_button.label = _labelField ? _list.selectedValue[_labelField] : _list.selectedValue as String;
		}
		
		protected function changeListWidth():void {
			_list.forEach(function(iListItem:IListItem, v:Object = null):void {
				ComboBoxItem(iListItem).label.width = _list.scrollBarVisible ? _width - _list.scrollBar.width : _width;
			});
			_list.resetSrollBarPosition();
			_list.graphics.clear();
			_list.graphics.lineStyle(1, _listColors[0]);
			_list.graphics.beginFill(_listColors[1]);
			_list.graphics.drawRect(0, 0, _width - 1, _list.row * Styles.comboBoxItemHeight);
			_list.graphics.endFill();
		}
		
		override public function set width(value:Number):void {
			if (_width != value) {
				_width = _button.width = value;
				_list.callLater(changeListWidth);
			}
		}
		
		override public function set height(value:Number):void {
			if (_height != value) {
				_height = _button.height = value;
			}
		}
		
		public function get button():Button {
			return _button;
		}
		
		public function get list():ScrollList {
			return _list;
		}
		
		public function get isOpen():Boolean {
			return _isOpen;
		}
		
		public function set isOpen(value:Boolean):void {
			if (_isOpen != value) {
				_isOpen = value;
				_button.selected = _isOpen;
				if (_isOpen) {
					var xx:Number = 0;
					var yy:Number = 0;
					switch (_position) {
						case Position.ABOVE:
							yy = -_list.height;
							break;
						case Position.LEFT:
							xx = -_list.width;
							break;
						case Position.RIGHT:
							xx = _width;
							break;
						default:
							yy = _height;
							break;
					}
					_list.moveTo(xx, yy);
					addChild(_list);
					StageManager.getInstance().registerHandler(MouseEvent.CLICK, removeList);
				} else {
					removeList();
				}
			}
		}
		
		protected function removeList():void {
			_isOpen = false;
			_button.selected = false;
			_list.remove();
			StageManager.getInstance().deleteHandler(MouseEvent.CLICK, removeList);
		}
		
		public function get skin():String {
			return _button.skin;
		}
		
		public function set skin(value:String):void {
			if (_button.skin != value) {
				_button.skin = value;
				width = _width || _button.width;
				height = _height || _button.height;
			}
		}
		
		public function get labels():String {
			return _labels;
		}
		
		public function set labels(value:String):void {
			if (_labels != value) {
				_labels = value;
				_list.data = _labels.split(",");
				maxRows = _list.data.length;
			}
		}
		
		public function get labelField():String {
			return _labelField;
		}
		
		public function set labelField(value:String):void {
			if (_labelField != value) {
				_labelField = value;
				callLater(changeLabel);
			}
		}
		
		public function get scrollBarSkin():String {
			return _list.scrollBarSkin;
		}
		
		public function set scrollBarSkin(value:String):void {
			_list.scrollBarSkin = value;
			_list.callLater(changeListWidth);
		}
		
		public function get seletedIndex():int {
			return _list.selectedIndex;
		}
		
		public function set selectedIndex(value:int):void {
			_list.selectedIndex = value;
		}
		
		public function get selectedValue():Object {
			return _list.selectedValue;
		}
		
		public function set selectedValue(value:Object):void {
			_list.selectedValue = value;
		}
		
		public function get scale9():String {
			return _button.scale9;
		}
		
		public function set scale9(value:String):void {
			_button.scale9 = value;
		}
		
		public function get position():String {
			return _position;
		}
		
		public function set position(value:String):void {
			_position = value;
		}
		
		public function get listColors():String {
			return _listColors.toString();
		}
		
		public function set listColors(value:String):void {
			_listColors = ArrayUtil.copyAndFill(_listColors, value);
		}
		
		public function set itemColors(value:String):void {
			_list.forEach(function(iListItem:IListItem, v:Object = null):void {
				ComboBoxItem(iListItem).itemColors = value;
			});
		}
		
		public function get maxRows():int {
			return _maxRows;
		}
		
		public function set maxRows(value:int):void {
			if (_maxRows != value) {
				_maxRows = value;
				_list.row = Math.min(_list.data.length, _maxRows);
				_list.callLater(changeListWidth);
			}
		}
		
		public function get defaultText():String {
			return _defaultText;
		}
		
		public function set defaultText(value:String):void {
			if (_defaultText != value) {
				_defaultText = value;
				if (_button.label == "") {
					_button.label = _defaultText;
				}
			}
		}
		
		public function set changeCallback(value:Method):void {
			if (_changeCallback != value) {
				_changeCallback = value;
			}
		}
		
		public function get changeCallback():Method {
			return _changeCallback;
		}
		
		override public function dispose():void {
			super.dispose();
			_button.removeEventListener(MouseEvent.CLICK, onButtonClick);
			_list.scrollBar.removeEventListener(MouseEvent.CLICK, onScrollBarClick);
			StageManager.getInstance().stage.removeEventListener(MouseEvent.CLICK, removeList);
		}
	}
}