package com.canaan.lib.rpg.core.map
{
	import com.canaan.lib.rpg.core.Resources;

	public class MapData
	{
		public var id:String;
		public var mapWidth:Number;
		public var mapHeight:Number;
		public var tileWidth:Number;
		public var tileHeight:Number;
		public var maxWidth:Number;
		public var maxHeight:Number;
		
		public function MapData(value:Object) {
			id = value.id;
			mapWidth = value.mapWidth;
			mapHeight = value.mapHeight;
			tileWidth = value.tileWidth;
			tileHeight = value.tileHeight;
			maxWidth = value.maxWidth;
			maxHeight = value.maxHeight;
		}
		
		public function get maxTileX():int {
			return Math.ceil(maxWidth / tileWidth);
		}
		
		public function get maxTileY():int {
			return Math.ceil(maxHeight / tileHeight);
		}
		
		public function get thumbnailPath():String {
			var fileName:String = id + ".jpg";
			return Resources.DIR_MAP + "thumbnails/" + fileName; 
		}
		
		public function getTilePath(tileX:int, tileY:int):String {
			var fileName:String = tileY + "_" + tileX + ".jpg";
			return Resources.DIR_MAP + "tiles/" + id + "/" + fileName;
		}
	}
}