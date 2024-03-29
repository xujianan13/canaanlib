package com.canaan.lib.rpg.core.model.map
{
	import com.canaan.lib.base.abstract.AbstractVo;
	import com.canaan.lib.base.core.Resources;

	public class MapVo extends AbstractVo
	{
		public var id:String;
		public var mapWidth:Number;
		public var mapHeight:Number;
		public var tileWidth:Number;
		public var tileHeight:Number;
		public var maxWidth:Number;
		public var maxHeight:Number;
		
		public function MapVo() {
			
		}
		
		override public function reinitialize():void {
			id = null;
			mapWidth = NaN;
			mapHeight = NaN;
			tileWidth = NaN;
			tileHeight = NaN;
			maxWidth = NaN;
			maxHeight = NaN;
		}
		
		public function get maxTileX():int {
			return Math.ceil(maxWidth / tileWidth);
		}
		
		public function get maxTileY():int {
			return Math.ceil(maxHeight / tileHeight);
		}
		
		public function get thumbnailPath():String {
			var fileName:String = id + ".jpg";
			return Resources.dirRpg + "map/thumbnails/" + fileName; 
		}
		
		public function getTileKey(tileX:int, tileY:int):String {
			return id + "_" + tileY + "_" + tileX;
		}
		
		public function getTilePath(tileX:int, tileY:int):String {
			var fileName:String = tileY + "_" + tileX + ".jpg";
			return Resources.dirRpg + "map/tiles/" + id + "/" + fileName;
		}
	}
}