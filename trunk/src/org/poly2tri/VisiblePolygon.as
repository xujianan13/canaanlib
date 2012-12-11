/*
* Some code from @author 白连忱, thx for his post!
* http://uh.9ria.com/link.php?url=http://bbs.9ria.com/viewthread.php%3Ftid%3D49841
*/

package org.poly2tri {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import org.poly2tri.Edge;
	import org.poly2tri.Point;
	import org.poly2tri.Sweep;
	import org.poly2tri.SweepContext;
	import org.poly2tri.Triangle;

	public class VisiblePolygon {
		protected var sweepContext:SweepContext;
		protected var sweep:Sweep;
		protected var triangulated:Boolean;

		public function VisiblePolygon() {
			this.reset();
		}
		
		public function addPolyline(polyline:Vector.<Point>):void {
			this.sweepContext.addPolyline(polyline);
		}

		public function addHole(polyline:Vector.<Point>):void {
			this.sweepContext.addHole(polyline);
		}

		public function reset():void {
			this.sweepContext = new SweepContext();
			this.sweep = new Sweep(sweepContext);
			this.triangulated = false;
		}
		
		protected function performTriangulationOnce():void {
			if (this.triangulated) return;
			this.triangulated = true;
			this.sweep.triangulate();
		}
		
		static public function parseVectorPoints(str:String, dx:Number = 0.0, dy:Number = 0.0):Vector.<Point> {
			var points:Vector.<Point> = new Vector.<Point>();
			for each (var xy_str:String in str.split(',')) {
				var xyl:Array = xy_str.replace(/^\s+/, '').replace(/\s+$/, '').split(' ');
				points.push(new Point(parseFloat(xyl[0]) + dx, parseFloat(xyl[1]) + dy));
			}
			return points;
		}
		
		public function drawShape(container : Sprite):void {
			var g : Graphics = container.graphics;
			var t:Triangle;
			var pl:Vector.<Point>;
			
			performTriangulationOnce();

			var l : int = this.sweepContext.triangles.length;
			for( var i : int = 0; i < l; i++){
				t = this.sweepContext.triangles[i];
				pl = t.points;
				g.lineStyle(1, 0x0000FF, 1);
				g.beginFill(0x33CCFF);
				{
					g.moveTo(pl[0].x, pl[0].y);
					g.lineTo(pl[1].x, pl[1].y);
					g.lineTo(pl[2].x, pl[2].y);
					g.lineTo(pl[0].x, pl[0].y);
				}
				g.endFill();

				var te : TextField = new TextField();
				te.selectable = false;
				te.text = i.toString();
				var ce : Point = t.getCenterPoint();
				te.x = ce.x;
				te.y = ce.y;

				t._index = i;
				t.calculate();

				container.addChild(te);
			}

			g.lineStyle(2, 0x00FF00, 1);
			for each (var e:Edge in this.sweepContext.edge_list) {
				g.moveTo(e.p.x, e.p.y);
				g.lineTo(e.q.x, e.q.y);
			}
		}

		public function findPath(start : Point, end : Point, g : Graphics) : Vector.<Point> {
			var startTri : Triangle = findTriangleContainer(start);
			var endTri : Triangle = findTriangleContainer(end);

			if(!startTri || !endTri) {
				return null;
			}

			var res : Vector.<Point> = new Vector.<Point>();
			if(startTri == endTri) {
				res.push(start);
				res.push(end);

				return res;
			}else{
				openList = new Heap(sweepContext.triangles.length, function(a : Triangle, b : Triangle) : int { return b.f - a.f; });
				closeList = new Array();

				pathSessionId ++;

				res = aStar(startTri, start, endTri, end);
				g.lineStyle(0.1, 0xCC0000);
				g.moveTo(res[0].x, res[0].y);
				for(var i : int = 1; i < res.length; i++){
					g.lineTo(res[i].x, res[i].y);	
				}
			}

			return null;
		}

		private var openList : Heap;
		private var closeList : Array;
		private var pathSessionId : int = 0;

		public function aStar(startTri : Triangle, startPt : Point, endTri : Triangle, endPt : Point) : Vector.<Point> {
			openList.clear();
			closeList.length = 0;

			openList.put(endTri);
			endTri.f = 0;
			endTri.h = 0;
			endTri.isOpen = false;
			endTri.parent = null;
			endTri.sessionId = pathSessionId;

			var foundPath : Boolean = false;
			var currNode : Triangle;
			var adjacentTmp : Triangle;

			while ( openList.size > 0){
				currNode = openList.pop();
				closeList.push(currNode);

				if(currNode == startTri) {
					foundPath = true;
					break;
				}

				var adjacentId : int;

				for(var i : int = 0; i < 3; i++) {
					adjacentTmp = currNode.neighbors[i];
					if(adjacentTmp == null || adjacentTmp.interior == false){
						continue;
					}

					if(adjacentTmp) {
						adjacentTmp.m_ArrivalWall = null;

						if(adjacentTmp.sessionId != pathSessionId){

							adjacentTmp.sessionId = pathSessionId;
							adjacentTmp.parent = currNode;
							adjacentTmp.isOpen = true;
							
							adjacentTmp.computeHeuristic(startPt);
							adjacentTmp.f = currNode.f + adjacentTmp.m_WallDistance[Math.abs(i - currNode.arrival)];

							openList.put(adjacentTmp);
							adjacentTmp.setAndGetArrivalWall(currNode._index);
						} else {
							if(adjacentTmp.isOpen){
								if(currNode.f + adjacentTmp.m_WallDistance[Math.abs(i - currNode.arrival)] < adjacentTmp.f){
									adjacentTmp.f = currNode.f;
									adjacentTmp.parent = currNode;

									adjacentTmp.setAndGetArrivalWall(currNode._index);
								}
							} else {
								adjacentTmp = null;
								continue;
							}
						}
					}
				}
			}

			var path : Vector.<Triangle> = new Vector.<Triangle>();	
			var s : Triangle = closeList[closeList.length - 1];		

			while(s.parent != null){
				path.push(s);
				s.m_ArrivalWall = s.getNeighborEdge(s.parent);
				s = s.parent;
			}

			path.push(endTri);

			if(path == null || path.length == 0) return null;

			/*for(var j : int = 0; j < path.length; j++){
				trace("path index: " + path[j]._index + " cross: " + path[j].m_ArrivalWall);
			}*/

			var result : Vector.<Point> = new Vector.<Point>;
			result.push(startPt);

			if(path.length == 1) {
				result.push(endPt);
				return result;
			}

			var wp : WayPoint = new WayPoint(path[0], startPt);

			while( !wp.point.equals(endPt) ) {
				wp = getFurthestWayPoint(wp, path, endPt);
				result.push(wp.point);
			}

			return result;

		}

		private function getFurthestWayPoint(wp : WayPoint, path : Vector.<Triangle>, endPt : Point) : WayPoint {
			var startPt : Point = wp.point;
			var tri : Triangle = wp.triangle;

			var l : int = path.length;


			var startIndex : int = path.indexOf(tri);

			var lastCW : int = startIndex;
			var lastCCW :int = startIndex;

			trace("new loop: " + tri._index);

			if(startIndex == l - 1){
				return new WayPoint(tri, endPt);
			}

			var ptA : Point = tri.m_ArrivalWall.p;
			var ptB : Point = tri.m_ArrivalWall.q;

			if(ptA.equals(startPt) || ptB.equals(startPt)) {
				trace("illegal start");
				return new WayPoint(path[startIndex + 1], startPt);
			}

			var reverse : int = Edge.classifyPoint(ptA, startPt, ptB);
			var edgeA : Line;
			var edgeB : Line;			

			if(reverse < 0) {
				edgeA = new Line(startPt, ptB);
				edgeB = new Line(startPt, ptA);
			}else{
				edgeA = new Line(startPt, ptA);
				edgeB = new Line(startPt, ptB);
			}

			//trace("edgeA : " + edgeA + " | edgeB : " + edgeB);

			for(var i : int = startIndex + 1; i < path.length; i++){
				tri = path[i];

				trace("test: " + tri._index);
				var testPtA : Point;
				var testPtB : Point;

				if( i < l - 1 ){
					reverse = Edge.classifyPoint(tri.m_ArrivalWall.p, startPt, tri.m_ArrivalWall.q);

					if(reverse < 0){
						testPtA = tri.m_ArrivalWall.q;
						testPtB = tri.m_ArrivalWall.p;
					}else{
						testPtA = tri.m_ArrivalWall.p;
						testPtB = tri.m_ArrivalWall.q;
					}
				}else{
					testPtA = endPt;
					testPtB = endPt;
				}

				var r0 : int = 0;
				var r1 : int = 0;


				if(!edgeA.q.equals(testPtA)){
					if( Edge.classifyPoint(testPtB, edgeA.p, edgeA.q) > 0 ) {
						trace("RETURN CW: " + lastCW);
						return new WayPoint(path[lastCW + 1], edgeA.q);
					}

					r0 = Edge.classifyPoint(testPtA, edgeA.p, edgeA.q); 

					if(r0 < 0) {
						trace("UPDATE CW");
						edgeA.q = testPtA;
						lastCW = i;
					}
				}

				if(!edgeB.q.equals(testPtB)){
					if( Edge.classifyPoint(testPtA, edgeB.p, edgeB.q) < 0 ) {
						trace("RETURN CCW: " + lastCCW);
						return new WayPoint(path[lastCCW + 1], edgeB.q);
					}

					r1 = Edge.classifyPoint(testPtB, edgeB.p, edgeB.q); 
					//trace( tri._index + " | r1: " + r1 + " | " + testPtB + " | " + edgeB.q);

					if(r1 > 0) {
						trace("UPDATE CCW");
						edgeB.q = testPtB;
						lastCCW = i;
					}
				}
					
			}
//			var outEdge : Edge = tri.m_ArrivalWall;
//
//			if(startIndex == path.length - 1){
//				return new WayPoint(tri, endPt);
//			}
//
//			var lastPtA : Point = outEdge.p;
//			var lastPtB : Point = outEdge.q;
//
//			var testPtA : Point;
//			var testPtB : Point;
//
//			for( var i : int = startIndex + 1; i < path.length; i++){
//				tri = path[i];
//				outEdge = tri.m_ArrivalWall;
//
//				trace("next:" + tri._index + ":" + tri.m_ArrivalWall);
//
//				if( i == path.length - 1){
//					testPtA = endPt;
//					testPtB = endPt;
//					trace("it's the last triangle.");
//				}else{
//					testPtA = outEdge.p;
//					testPtB = outEdge.q;
//				}
//
//				trace(lastPtA + "===" + lastPtB);
//				var c0 : int = Edge.classifyPoint(lastPtA, startPt, lastPtB ); 
//				var c1 : int = Edge.classifyPoint(testPtA, startPt, testPtB ); 
//
//				var a : Point;
//				var b : Point;
//				var c : Point;
//				var d : Point;
//
//				if(c0 < 0) {
//					a = lastPtB; 
//					b = lastPtA;
//				}else{
//					a = lastPtA;
//					b = lastPtB;
//				}
//
//				if(c1 < 0) {
//					c = testPtB;	
//					d = testPtA;	
//				}else{
//					c = testPtA;
//					d = testPtB;
//				}
//
//				var r0 : int = Edge.classifyPoint(c, startPt, a); 
//				var r1 : int = Edge.classifyPoint(d, startPt, b); 
//
//				trace("r0: " + r0 + " | " + "r1: " + r1);
//				trace("a: " + a + " | " + "b: " + b);
//				trace("c: " + c + " | " + "d: " + d);
//
//				if( !a.equals(c) ) {
//					if(r1 < 0) {
//						trace("return b");
//						return new WayPoint(tri, b);
//					}
//					if(r0 <= 0) {
//						trace("CCW");
//						lastPtA = c;
//						lastPtB = d;
//					}
//				}
//
//				if( !b.equals(d) ) {
//					if(r0 > 0){
//						trace("return a"); 
//						return new WayPoint(tri, a);
//					}
//
//					if(r1 >= 0) {
//						trace("CW");
//						lastPtB = d;
//						lastPtA = c;
//					}
//				}
//
//				lastTri = tri;
//
//				/*if(r0 <= 0){
//					trace("CCW");
//					if(r1 < 0){
//						trace("Add Way Point");
//						return new WayPoint(lastTri, b); 
//					}
//
//					lastPtA = c;
//					lastTri = tri;
//				}
//
//				if(r1 >= 0){
//					trace("CW");
//					if(r0 > 0){
//						trace("Add Way Point");
//						return new WayPoint(lastTri, a);
//					}
//
//					lastPtB = d;
//					lastTri = tri;
//				}*/
//
//				/*if(!lastPtA.equals(testPtA)){
//					if(Edge.classifyPoint(testPtA, startPt, lastPtB ) == -1)
//					{
//						return new WayPoint(lastTri, lastPtB);
//					}else if(Edge.classifyPoint(testPtA, startPt, lastPtA) != 1){
//						trace("go straight");
//						lastPtA = testPtA;
//						lastTri = tri;
//						lastLineA.q = lastPtA;
//					}
//				}
//
//				if(!lastPtB.equals(testPtB)) {
//					if(Edge.classifyPoint(testPtB, startPt, lastPtA) == 1){
//						return new WayPoint(lastTri, lastPtA);
//					}else if(Edge.classifyPoint(testPtB, startPt, lastPtB) != -1){
//						lastPtB = testPtB;
//						lastTri = tri;
//						lastLineB.q = lastPtB;
//					}
//				}*/
//
//			}
//
//			trace("direct to");

			return new WayPoint(path[path.length - 1], endPt);
		}

		public function findTriangleContainer(pt : Point) : Triangle {
			var l : int = sweepContext.triangles.length; 
			for (var i : int = 0; i < l; i++){
				var tri : Triangle = sweepContext.triangles[i];
				if(tri.isPointInside(pt)){
					return tri;
				}
			}

			return null;
		}

	}
}

import org.poly2tri.Point;
import org.poly2tri.Triangle;
internal class WayPoint {
	public var triangle : Triangle;
	public var point : Point;

	public function WayPoint(tri : Triangle, pt : Point) : void {
		this.triangle = tri;
		this.point = pt;
	}
}

internal class Line {
	public var p : Point;
	public var q : Point;

	public function Line(pt0 : Point, pt1 : Point) : void {
		p = pt0;
		q = pt1;
	}

	public function toString() : String {
		return "Line: " + p + " : " + q + ";";
	}
}
