package a3lbmonkeybrain.visualcortex.menus
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	[Event(name = "change", type = "flash.events.Event")]
	public class MenuControllerList extends EventDispatcher implements MenuController
	{
		protected const _controllers:Array = [];
		public function MenuControllerList()
		{
			super();
		}
		public final function set controllers(value:Array):void
		{
			while (_controllers.length)
				_controllers.pop();
			for each (var controller:MenuController in value)
			{
				_controllers.push(controller);
				controller.addEventListener(Event.CHANGE, dispatchEvent);
			}
		}
		[Bindable(event = "change")]
		public final function get data():MenuDataItem
		{
			var data:MenuDataItem = new MenuDataItem();
			data.children.removeAll();
			for each (var controller:MenuController in _controllers)
			{
				var controllerData:MenuDataItem = controller.data;
				if (controllerData != null)
					data.children.addItem(controllerData);
			}
			return data;
		}
		public final function handleItem(item:MenuDataItem):Boolean
		{
			for each (var controller:MenuController in _controllers)
			{
				if (controller.handleItem(item))
					return true;
			}
			return false;
		}
	}
}