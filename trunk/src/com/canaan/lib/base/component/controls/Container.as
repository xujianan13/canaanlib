package com.canaan.lib.base.component.controls
{
	import com.canaan.lib.base.component.UIComponent;
	import com.canaan.lib.base.component.layout.ContainerLayout;
	import com.canaan.lib.base.component.layout.Layout;
	import com.canaan.lib.base.utils.DisplayUtil;
	
	import flash.display.DisplayObject;
	
	public class Container extends UIComponent
	{
		protected var layoutObject:Layout;
		
		public function Container()
		{
			mouseChildren = true;
		}
		
		override protected function initialize():void {
			layoutObject = new ContainerLayout();
			layoutObject.target = this;
		}
		
		protected function get containerLayout():ContainerLayout {
			return layoutObject as ContainerLayout;
		}
		
		override public function set disabled(value:Boolean):void {
			if (_disabled != value) {
				_disabled = value;
				mouseEnabled = !disabled;
				mouseChildren = !disabled;
			}
		}

		public function addElement(element:DisplayObject, x:Number = 0, y:Number = 0):void {
			element.x = x;
			element.y = y;
			addChild(element);
		}
		
		public function addElementAt(element:DisplayObject, index:int, x:Number = 0, y:Number = 0):void {
			element.x = x;
			element.y = y;
			addChildAt(element, index);
		}
		
		public function addElements(elements:Array):void {
			var l:int = elements.length;
			for (var i:int = 0; i < l; i++) {
				addChild(elements[i]);
			}
		}
		
		public function removeElement(element:DisplayObject):void {
			DisplayUtil.removeChild(this, element);
		}
		
		public function set layout(value:String):void {
			containerLayout.layout = value;
		}
		
		public function get layout():String {
			return containerLayout.layout;
		}
		
		public function set gap(value:Number):void {
			containerLayout.gap = value;
		}
		
		public function get gap():Number {
			return containerLayout.gap;
		}
		
		public function set top(value:Number):void {
			containerLayout.top = value;
		}
		
		public function get top():Number {
			return containerLayout.top;
		}
		
		public function set bottom(value:Number):void {
			containerLayout.bottom = value;
		}
		
		public function get bottom():Number {
			return containerLayout.bottom;
		}
		
		public function set left(value:Number):void {
			containerLayout.left = value;
		}
		
		public function get left():Number {
			return containerLayout.left;
		}
		
		public function set right(value:Number):void {
			containerLayout.right = value;
		}
		
		public function get right():Number {
			return containerLayout.right;
		}
		
		override public function dispose():void {
			super.dispose();
			containerLayout.dispose();
		}
	}
}