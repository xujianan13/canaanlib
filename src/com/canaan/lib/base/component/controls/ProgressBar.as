package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.Styles;
	import com.canaan.lib.base.component.UIComponent;
	
	import flash.text.TextFormatAlign;
	
	public class ProgressBar extends UIComponent
	{
		private static const BAR_SKIN_SUFFIX:String = "$bar";
		
		protected var background:Image;
		protected var bar:Image;
		
		protected var _skin:String;
		protected var _value:Number = 0;
		protected var _barLabel:Label;
		
		public function ProgressBar(skin:String = null)
		{
			this.skin = skin;
		}
		
		override protected function createChildren():void {
			background = new Image();
			addChild(background);
			bar = new Image();
			addChild(bar);
			_barLabel = new Label();
			_barLabel.width = 100;
			_barLabel.height = 18;
			_barLabel.align = TextFormatAlign.CENTER;
			_barLabel.color = Styles.progressBarLabelColor;
			_barLabel.stroke = Styles.progressBarLabelStroke;
			addChild(_barLabel);
		}
		
		override public function set width(value:Number):void {
			super.width = value;
			background.width = _width;
			_barLabel.x = (_width - _barLabel.width) * 0.5;
			callLater(changeValue);
		}
		
		override public function set height(value:Number):void {
			super.height = value;
			background.height = _height;
			bar.height = _height;
			_barLabel.y = (_height - _barLabel.height) * 0.5;
		}
		
		public function set skin(value:String):void {
			if (_skin != value) {
				_skin = value;
				callLater(changeSkin);
			}
		}
		
		public function get skin():String {
			return _skin;
		}
		
		protected function changeSkin():void {
			background.url = _skin;
			bar.url = _skin + BAR_SKIN_SUFFIX;
			width = _width || background.width;
			height = _height || background.height;
		}
		
		public function set value(value:Number):void {
			value = Math.min(1, Math.max(0.0000001, value));
			if (_value != value) {
				_value = value;
				callLater(changeValue);
			}
		}
		
		public function get value():Number {
			return _value;
		}
		
		protected function changeValue():void {
			bar.width = _width * _value;
		}
		
		public function set label(value:String):void {
			_barLabel.text = value;
		}
		
		public function get label():String {
			return _barLabel.text;
		}
		
		public function set langId(value:String):void {
			_barLabel.langId = value;
		}
		
		public function get langId():String {
			return _barLabel.langId;
		}
		
		public function set langArgs(value:Array):void {
			_barLabel.langArgs = value;
		}
		
		public function get langArgs():Array {
			return _barLabel.langArgs;
		}
		
		public function get barLabel():Label {
			return _barLabel;
		}
		
		public function set scale9(value:String):void {
			background.scale9 = bar.scale9 = value;
		}
		
		public function get scale9():String {
			return background.scale9;
		}
	}
}