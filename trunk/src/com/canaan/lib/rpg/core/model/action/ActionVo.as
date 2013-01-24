package com.canaan.lib.rpg.core.model.action
{
	import com.canaan.lib.base.abstract.AbstractVo;
	import com.canaan.lib.base.display.BitmapDataEx;
	
	import flash.utils.Dictionary;

	public class ActionVo extends AbstractVo
	{
		public var interval:int;
		public var data:Dictionary = new Dictionary();
		
		public function ActionVo()
		{
		}
		
		override public function reinitialize():void {
			super.reinitialize();
			interval = 0;
			data = new Dictionary();
		}
		
		public function getVectorByAction(action:int):Vector.<BitmapDataEx> {
			return data[action];
		}
	}
}