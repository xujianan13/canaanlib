package com.canaan.lib.base.events
{
	public class EventManager extends CEventDispatcher
	{
		private static var canInstantiate:Boolean;
		private static var instance:EventManager;
		
		public function EventManager()
		{
			if (!canInstantiate) {
				throw new Error("Can not instantiate, use getInstance() instead.");
			}
		}
		
		
		public static function getInstance():EventManager {
			if (instance == null) {
				canInstantiate = true;
				instance = new EventManager();
				canInstantiate = false;
			}
			return instance;
		}
	}
}