package com.canaan.lib.base.component
{
	import com.canaan.lib.base.component.controls.*;

	public class ViewCreater
	{
		private static const SysClassMap:Object = {
			"Label":Label,
			"TextInput":TextInput,
			"TextArea":TextArea,
			"Button":Button,
			"LinkButton":LinkButton,
			"CheckBox":CheckBox,
			"RadioButton":RadioButton,
			"Slider":Slider,
			"VSlider":VSlider,
			"HSlider":HSlider,
			"ScrollBar":ScrollBar,
			"VScrollBar":VScrollBar,
			"HScrollBar":HScrollBar,
			"ProcessBar":ProgressBar,
			"Image":Image,
			"Clip":Clip,
			"FrameClip":FrameClip,
			"Container":Container,
			"RadioGroup":RadioGroup,
			"Tab":Tab,
			"ViewStack":ViewStack,
			"List":List,
			"PageList":PageList,
			"ScrollList":ScrollList,
			"Canvas":Canvas,
			"ComboBox":ComboBox,
			"ComboBoxItem":ComboBoxItem
		};
		
		private static var UserClassMap:Object = {};
		
		public static function addUserClass(className:String, clazz:Class):void {
			UserClassMap[className] = clazz;
		}
		
		public static function createView(root:UIComponent, xml:XML, isRoot:Boolean = true):UIComponent {
			var comp:UIComponent = isRoot ? root : getConponentInstance(xml.name());
			var attributes:XML;
			for each (attributes in xml.attributes()) {
				var prop:String = attributes.name().toString();
				var value:String = attributes;
				if (comp.hasOwnProperty(prop)) {
					comp[prop] = (value == "true" ? true : (value == "false" ? false : value));
				} else if (prop == "var" && root.hasOwnProperty(value)) {
					root[value] = comp;
				}
			}
			
			var length:int = xml.children().length();
			var child:UIComponent;
			for (var i:int = 0; i < length; i++) {
				child = createView(root, xml.children()[i], false);
				comp.addChild(child);
			}
			if (comp is IInitialItems) {
				IInitialItems(comp).initialItems();
			}
			return comp;
		}
		
		public static function getConponentInstance(className:String):UIComponent {
			var clazz:Class = SysClassMap[className] || UserClassMap[className];
			if (clazz != null) {
				return new clazz();
			}
			return null;
		}
	}
}