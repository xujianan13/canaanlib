package com.canaan.lib.base.abstract
{
	import com.canaan.lib.base.events.CEventDispatcher;
	import com.canaan.lib.base.interfaces.IDispose;
	import com.canaan.lib.base.interfaces.IModel;
	import com.canaan.lib.base.managers.SocketManager;
	import com.canaan.lib.base.net.SocketResult;
	
	public class AbstractModel extends CEventDispatcher implements IModel, IDispose
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
					SocketManager.getInstance().registerHandler(command, handleCommand);
				}
			}
		}
		
		protected function listCommandInterests():Array {
			return null;
		}
		
		protected function handleCommand(result:SocketResult):void {
			
		}

		public function dispose():void {
			for each (var command:int in _commands) {
				SocketManager.getInstance().deleteHandler(command, handleCommand);
			}
			_initialized = false;
		}
		
		public function get initialized():Boolean {
			return _initialized;
		}
	}
}