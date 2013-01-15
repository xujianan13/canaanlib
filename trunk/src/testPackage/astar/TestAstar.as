package testPackage.astar
{
	import com.canaan.lib.base.astar.AStar;
	import com.canaan.lib.base.astar.Node;
	
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;

	public class TestAstar extends Sprite
	{
		private var _cellSize:int = 20;
		private var astar:AStar;
		private var _player:Sprite;
		private var _index:int;
		private var _path:Vector.<Node>;
		private var _isWalking:Boolean;
		
		public function TestAstar()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			makeAstar();
			makePlayer();
			stage.addEventListener(MouseEvent.CLICK, stage_mouseClickHandler);
		}
		
		private function makeAstar():void {
			astar = new AStar();
			var array:Array = [];
			for (var i:int = 0; i < 30; i++) {
				array[i] = [];
				for (var j:int = 0; j < 30; j++) {
					array[i][j] = 0;
				}
			}
			for (var k:int = 0; k < 200; k++) {
				array[int(Math.random() * 30)][int(Math.random() * 30)] = 1;
			}
			astar.initializeGrid(array);
			drawGrid();
		}
		
		/**
		 * 创建玩家
		 */
		private function makePlayer():void {
			_player = new Sprite();
			_player.graphics.beginFill(0xff0000);
			_player.graphics.drawCircle(0, 0, 5);
			_player.graphics.endFill();
			_player.x = int(Math.random() * 30) * _cellSize - _cellSize * .5;
			_player.y = int(Math.random() * 30) * _cellSize - _cellSize * .5;
			addChild(_player);
		}
		
		/**
		 * 绘制网格
		 */
		private function drawGrid():void {
			graphics.clear();
			for (var i:int = 0; i < astar.grid.numCols; i++) {
				for (var j:int = 0; j < astar.grid.numRows; j++) {
					var node:Node = astar.grid.getNode(i, j);
					graphics.lineStyle(0);
					graphics.beginFill(getColor(node));
					graphics.drawRect(i * _cellSize, j * _cellSize, _cellSize, _cellSize);
				}
			}
		}
		
		/**
		 * 为不同节点设置颜色
		 */
		private function getColor(node:Node):uint {
			if (!node.walkable)
				return 0x000000;
			if (node == astar.grid.startNode)
				return 0x666666;
			if (node == astar.grid.endNode)
				return 0x666666;
			return 0xFFFFFF;
		}
		
		private function stage_mouseClickHandler(event:MouseEvent):void {
			if (this._isWalking)
				return;
			var ex:int = int(mouseX / _cellSize);
			var ey:int = int(mouseY / _cellSize);
			var sx:int = int(_player.x / _cellSize);
			var sy:int = int(_player.y / _cellSize);
			_path = astar.find(sx, sy, ex, ey);
			drawGrid();
			if (_path) {
				_index = 0;
				addEventListener(Event.ENTER_FRAME, enterFrameHandler);
			}
		}

		private function enterFrameHandler(event:Event):void {
			_isWalking = true;
			var targetX:Number = _path[_index].x * _cellSize + _cellSize * .5;
			var targetY:Number = _path[_index].y * _cellSize + _cellSize * .5;
			var dx:Number = targetX - _player.x;
			var dy:Number = targetY - _player.y;
			var dist:Number = Math.sqrt(dx * dx + dy * dy);
			if (dist < 1) {
				_index++;
				if(_index >= _path.length) {
					_isWalking = false;
					removeEventListener(Event.ENTER_FRAME, enterFrameHandler);
				}
			} else {
				_player.x += dx * .5;
				_player.y += dy * .5;
			}
		}
	}
}