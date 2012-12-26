package com.canaan.lib.base.astar
{
	public class AStar
	{
		private var _open:Vector.<Node>;				// 待考察表
		private var _closed:Vector.<Node>;				// 已考察表
		private var _grid:Grid;							// 网格
		private var _startNode:Node;					// 开始节点
		private var _endNode:Node;						// 终点节点
		private var _path:Vector.<Node>;				// 路径（节点列表）
		private var _heuristic:Function = diagonal;		// 估价方法(对角线估价法)
		//private var _heuristic:Function = manhattan;	// 估价方法(曼哈顿估价法)
		//private var _heuristic:Function = euclidian;	// 估价方法(几何估价法)
		private var _straightCost:Number = 1.0;			// 水平距离
		private var _diagCost:Number = Math.SQRT2;		// 对角线距离
		
		public function AStar()
		{
			
		}

		/**
		 * 寻路方法
		 * 方法创建了一个空的待考察表/已考察表，然后从_grid中获取起点，终点节点值。
		 * 在计算出起点的代价后，跳到search方法开始循环，直到终点节点，返回路径。
		 * 因为g值的定义是从起点到当前点的消耗，这时起点就是当前点，让当前节点的g值为0。
		 */
		public function findPath(grid:Grid):Boolean {
			_grid = grid;
			_open = new Vector.<Node>();
			_closed = new Vector.<Node>();
			_startNode = _grid.startNode;
			_endNode = _grid.endNode;
			_startNode.g = 0;
			_startNode.h = _heuristic(_startNode);
			_startNode.f = _startNode.g + _startNode.h;
			return search();
		}
		
		/**
		 * 挨个计算起点节点一直到终点节点，计算出最佳路径。
		 */
		public function search():Boolean {
			if (!_endNode.walkable) {
				return false;
			}
			// 设置当前节点为起始点
			var node:Node = _startNode;
			while (node != _endNode) {
				// 首先找到当前节点的x，y值（不是实际意义的xy坐标，是节点在网格中的行列数），然后分别从x-1到x+1，y-1到y+1.
				// 通过Math.min和Math.max确保了检查的节点永远在网格里面。
				var startX:int = Math.max(0, node.x - 1);
				var endX:int = Math.min(_grid.numCols - 1, node.x + 1);
				var startY:int = Math.max(0, node.y - 1);
				var endY:int = Math.min(_grid.numRows - 1, node.y + 1);
				// 遍历起始点周围的8个点
				for (var i:int = startX; i <= endX; i++) {
					for (var j:int = startY; j <= endY; j++) {
						var test:Node = _grid.getNode(i, j);
						// 对于每一个节点来说，如果它是当前节点或不可通过的，或者临接节点都不能通过，那么就跳过该节点就忽略它，直接跳到下一个
						if (test == node || !test.walkable || (!_grid.getNode(node.x, test.y).walkable && !_grid.getNode(test.x, node.y).walkable)) {
							continue;
						}
						var cost:Number = _straightCost;
						// 如果是对角点则设置代价为_diagCost;
						if (!((node.x == test.x) || (node.y == test.y))) {
							cost = _diagCost;
						}
						var g:Number = node.g + cost * test.costMultiplier;
						var h:Number = _heuristic(test);
						var f:Number = g + h;
						// 如果一个节点在待考察表/已考察表里，因为它已经被考察过了，所以我们不需要再考察。
						// 不过这次计算出的结果有可能小于你之前计算的结果。
						// 所以，就算一个节点在待考察表/已考察表里面，最好还是比较一下当前值和之前值之间的大小。
						// 具体做法是比较测试节点的总代价与以前计算出来的总代价。
						// 如果以前的大，我们就找到了更好的节点，我们就需要重新给测试点的f，g，h赋值。
						// 同时，我们还要把测试点的父节点设为当前点。这就要我们向后追溯。
						if (isOpen(test) || isClosed(test)) {
							if (test.f > f) {
								test.f = f;
								test.g = g;
								test.h = h;
								test.parent = node;
							}
						}
						// 如果测试节点不再待考察表/已考察表里面，我们只需要赋值给f，g，h和父节点。
						// 然后把测试点加到待考察表，然后是下一个测试点，找出最佳点。
						else {
							test.f = f;
							test.g = g;
							test.h = h;
							test.parent = node;
							_open.push(test);
						}
					}
				}
				
				// 调试输出_open里都有哪些点
				// for(var o:int = 0; o < _open.length; o++) {
				// 	 trace(_open[i].toString());
				// }

				// 将当前节点放入已考察表
				_closed.push(node);
				// 检查待考察表里面有没有节点。
				if (!_open.length) {
					return false;
				}
				// 选择待考察表里代价最小的点作为新的起点
//				_open.sortOn("f", Array.NUMERIC);
				_open.sort(sortFunc);
				node = _open.shift() as Node;
			}
			buildPath();
			return true;
		}
		
		private function sortFunc(nodeA:Node, nodeB:Node):int {
			if (nodeA.f > nodeB.f) {
				return 1;
			} else if (nodeA.f < nodeB.f) {
				return -1;
			}
			return 0;
		}
		
		/**
		 * 创建路径
		 */
		private function buildPath():void {
			_path = new Vector.<Node>();
			// 向路径中加入终点
			var node:Node = _endNode;
			_path.push(node);
			// 循环加入所有父节点
			while (node != _startNode) {
				node = node.parent;
				_path.unshift(node);
			}
		}
		
		/**
		 * 判断指定节点是否存在于待考察点集合中
		 */
		private function isOpen(node:Node):Boolean {
			for (var i:int = 0; i < _open.length; i++) {
				if (_open[i] == node) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * 判断指定节点是否存在于已考察点集合中
		 */
		private function isClosed(node:Node):Boolean {
			for (var i:int = 0; i < _closed.length; i++) {
				if (_closed[i] == node) {
					return true;
				}
			}
			return false;
		}
		
		/**
		 * 曼哈顿估价法(Manhattan heuristic)
		 * 它忽略所有的对角移动，只添加起点节点和终点节点之间的行、列数目。
		 */
		private function manhattan(node:Node):Number {
			return Math.abs(node.x - _endNode.x) * _straightCost + Math.abs(node.y + _endNode.y) * _straightCost;
		}
		
		/**
		 * 几何估价法(Euclidian heuristic)
		 * 计算出两点之间的直线距离，本质公式为勾股定理A²+B²=C²。
		 */
		private function euclidian(node:Node):Number {
			var dx:Number = node.x - _endNode.x;
			var dy:Number = node.y - _endNode.y;
			return Math.sqrt(dx * dx + dy * dy) * _straightCost;
		}
		
		/**
		 * 角线估价法(Diagonal heuristic)
		 * 三个估价方法里面最精确的，如果没有障碍，它将返回实际的消耗。
		 */
		private function diagonal(node:Node):Number {
			var dx:Number = Math.abs(node.x - _endNode.x);
			var dy:Number = Math.abs(node.y - _endNode.y);
			var diag:Number = Math.min(dx, dy);
			var straight:Number = dx + dy;
			return _diagCost * diag + _straightCost * (straight - 2 * diag);
		}
		
		/**
		 * 返回路径
		 */
		public function get path():Vector.<Node> {
			return _path;
		}
		
		/**
		 * 返回以考察点集合
		 */
		public function get open():Vector.<Node> {
			return _open;
		}
		
		/**
		 * 返回待考察点几何
		 */
		public function get closed():Vector.<Node> {
			return _closed;
		}
		
		/**
		 * 返回所有被计算过的节点(辅助函数)
		 */
		public function get visited():Vector.<Node> {
			return _closed.concat(_open);
		}
	}
}