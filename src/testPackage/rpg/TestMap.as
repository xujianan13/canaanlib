package testPackage.rpg
{
	import com.canaan.lib.base.core.Application;
	import com.canaan.lib.base.core.Method;
	import com.canaan.lib.rpg.core.map.Map;
	import com.canaan.lib.rpg.core.model.map.MapVo;
	
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
		private var mapVo:MapVo;
		private var keyCode:int;
		private var keyDown:Boolean;
		
		public function TestMap()
		{
			Application.initialize(this, new Method(initializeComplete));
		}
		
		private function initializeComplete():void {
			mapVo = new MapVo();
			mapVo.id = "111";
			mapVo.mapWidth = 1000;
			mapVo.mapHeight = 600;
			mapVo.tileWidth = 320;
			mapVo.tileHeight = 360;
			mapVo.maxWidth = 3200;
			mapVo.maxHeight = 700;
			map = new Map();
			map.initialize(mapVo);
			this.addChild(map.drawBuffer);
			stage.addEventListener(MouseEvent.CLICK, onClick);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			stage.addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			stage.addEventListener(Event.RESIZE, onResize);
		}
		
		private function onResize(event:Event):void {
			map.changeMapSize(stage.stageWidth, stage.stageHeight);
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
//			map.moveTo(Math.random() * 3200, Math.random() * 720);
//			trace(map.center);
			trace(map.getScreenPosition(1000, 1000));
//			trace(map.getMapPosition(mouseX, mouseY));
		}
	}
}