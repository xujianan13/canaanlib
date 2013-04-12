package com.canaan.lib.rpg.core.model.action
{
	import com.canaan.lib.base.abstract.AbstractVo;
	import com.canaan.lib.base.display.BitmapDataEx;
	import com.canaan.lib.base.managers.ResourceManager;
	
	import flash.utils.Dictionary;

	public class ActionVo extends AbstractVo
	{
		public var _id:String;
		
		public var bitmapDatas:Dictionary = new Dictionary();
		
		public function ActionVo()
		{
		}
		
		override public function reinitialize():void {
			super.reinitialize();
			bitmapDatas = new Dictionary();
		}
		
		public function setHeadData(value:Object):void {
			_id = value.id;
			var actions:Object = value.actions;
			var directions:Dictionary;
			var vector:Vector.<BitmapDataEx>;
			var bitmapDataEx:BitmapDataEx;
			var frameIndex:int;
			var skin:String;
			for (var action:String in actions) {
				directions = new Dictionary();
				bitmapDatas[action] = directions;
				for (var direction:String in actions[action]) {
					vector = new Vector.<BitmapDataEx>();
					directions[direction] = vector;
					frameIndex = 0;
					for each (var data:Object in actions[action][direction]) {
						bitmapDataEx = new BitmapDataEx();
						skin = _id + "_" + action + "_" + direction + "_" + frameIndex;
						bitmapDataEx.bitmapData = ResourceManager.getInstance().getBitmapData(skin);
						bitmapDataEx.x = data.x;
						bitmapDataEx.y = data.y;
						bitmapDataEx.delay = data.delay;
						bitmapDataEx.frameIndex = frameIndex;
						vector.push(bitmapDataEx);
						frameIndex++;
					}
				}
			}
		}
		
		public function getVector(action:int, direction:int):Vector.<BitmapDataEx> {
			return bitmapDatas[action][direction];
		}
		
		public function get id():String {
			return _id;
		}
	}
}