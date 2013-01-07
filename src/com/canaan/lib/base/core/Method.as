package com.canaan.lib.base.core
{
	public class Method
	{
		private var _func:Function;
		private var _args:Array;
		
		public function Method(func:Function, args:Array = null)
		{
			_func = func;
			_args = args;
		}
		
		public function set func(value:Function):void {
			_func = value;
		}

		public function get func():Function {
			return _func;
		}
		
		public function set args(value:Array):void {
			_args = value;
		}
		
		public function get args():Array {
			return _args;
		}
		
		public function apply():* {
			if (_func != null) {
				return _func.apply(null, _args);
			}
		}
		
		public function applyWith(data:Array):* {
			if (data == null) {
				return apply();
			}
			if (_func != null) {
				return _func.apply(null, _args ? _args.concat(data) : data);
			}
		}
	}
}