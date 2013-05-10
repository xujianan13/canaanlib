package com.canaan.lib.base.abstract
{
	import com.canaan.lib.base.events.CEventDispatcher;
	import com.canaan.lib.base.interfaces.IModel;
	import com.canaan.lib.base.net.ServerResult;
	
	public class AbstractModel extends CEventDispatcher implements IModel
	{
		protected var _initialized:Boolean;
		protected var _commands:Array;
		
		public function AbstractModel()
		{
			registerCommandInterests();
		}
		
		protected function registerCommandInterests():void {
			_commands = listCommandInterests();
			if (_commands != null && _commands.length != 0) {
				for each (var command:int in _commands) {
					registerHandler(command);
				}
			}
		}
		
		protected function listCommandInterests():Array {
			return null;
		}
		
		protected function handleCommand(result:ServerResult):void {
			
		}
		
		protected function registerHandler(command:int):void {
			
		}
		
		protected function deleteHandler(command:int):void {
			
		}

		public function dispose():void {
			for each (var command:int in _commands) {
				deleteHandler(command);
			}
			_initialized = false;
		}
		
		public function get initialized():Boolean {
			return _initialized;
		}
	}
}