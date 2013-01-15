package testPackage.rpg
{
	import com.canaan.lib.base.core.Config;
	import com.canaan.lib.rpg.core.map.Map;
	import com.canaan.lib.rpg.core.model.MapVo;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	
	[SWF(width="1000", height="600")]
	public class TestMap extends Sprite
	{
		private var map:Map;
		private var keyCode:int;
		private var keyDown:Boolean;
		
		public function TestMap()
		{
			stage.focus = this;
			Config.setConfig("locale", "zh_CN");
			var mapData:MapVo = new MapVo();
			mapData.id = "111";
			mapData.mapWidth = 1000;
			mapData.mapHeight = 600;
			mapData.tileWidth = 320;
			mapData.tileHeight = 360;
			mapData.maxWidth = 3200;
			mapData.maxHeight = 700;
			map = new Map();
			map.initialize(mapData);
			this.addChild(map.drawBuffer);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
		}
		
		private function onKeyDown(event:KeyboardEvent):void {
			keyDown = true;
			keyCode = event.keyCode;
		}
		
		private function onKeyUp(event:KeyboardEvent):void {
			keyDown = false;
		}
		
		private function enterFrameHandler(event:Event):void {
			if (!keyDown) {
				return;
			}
			var c:Point = map.center;
			if (keyCode == Keyboard.LEFT) {
				map.moveTo(c.x - 5, c.y);
			} else if (keyCode == Keyboard.RIGHT) {
				map.moveTo(c.x + 5, c.y);
			} else if (keyCode == Keyboard.UP) {
				map.moveTo(c.x, c.y - 3);
			} else if (keyCode == Keyboard.DOWN) {
				map.moveTo(c.x, c.y + 3);
			}
//			map.render();
		}
		
		private function onClick(event:MouseEvent):void {
			map.moveTo(Math.random() * 3200, Math.random() * 720);
		}
	}
}