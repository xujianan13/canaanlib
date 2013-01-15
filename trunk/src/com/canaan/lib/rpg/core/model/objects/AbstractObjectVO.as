package com.canaan.lib.rpg.core.model.objects
{
	import com.canaan.lib.base.abstract.AbstractVo;

	public class AbstractObjectVO extends AbstractVo
	{
		public var id:String;
		public var basicId:String;
		public var mapX:int;
		public var mapY:int;
		public var category:int;
		
		public function AbstractObjectVO()
		{	
		}
		
		override public function reinitialize():void {
			id = null;
			basicId = null;
			mapX = 0;
			mapY = 0;
		}
	}
}