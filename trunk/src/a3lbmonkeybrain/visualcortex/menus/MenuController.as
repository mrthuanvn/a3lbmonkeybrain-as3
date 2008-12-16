package a3lbmonkeybrain.visualcortex.menus
{
	import flash.events.IEventDispatcher;
	
	[Event(name = "change", type = "flash.events.Event")]
	public interface MenuController extends IEventDispatcher
	{
		function get data():MenuDataItem;
		function handleItem(item:MenuDataItem):Boolean;
	}
}