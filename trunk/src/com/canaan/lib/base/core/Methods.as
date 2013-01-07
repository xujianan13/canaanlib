package com.canaan.lib.base.core
{
	public class Methods
	{
		private var _methods:Vector.<Function>;
		private var _args:Vector.<Array>;
		
		public function Methods()
		{
			_methods = new Vector.<Function>();
			_args = new Vector.<Array>();
		}
		
		public function register(func:Function, args:Array = null):void {
			var index:int = _methods.indexOf(func);
			if (index == -1) {
				_methods.push(func);
				_args.push(args);
			} else {
				_args.splice(index, 1, args);
			}
		}
		
		public function del(func:Function):void {
			var index:int = _methods.indexOf(func);
			if (index != -1) {
				_methods.splice(index, 1);
				_args.splice(index, 1);
			}
		}
		
		public function apply():void {
			var func:Function;
			var args:Array;
			for (var i:int = 0; i < _methods.length; i++) {
				func = _methods[i];
				args = _args[i];
				func.apply(null, args);
			}
		}
	}
}