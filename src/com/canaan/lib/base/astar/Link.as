package com.canaan.lib.base.astar
{
	public class Link
	{
		public var node:Node;
		public var cost:Number;
		
		public function Link(node:Node, cost:Number)
		{
			this.node = node;
			this.cost = cost;
		}
	}
}