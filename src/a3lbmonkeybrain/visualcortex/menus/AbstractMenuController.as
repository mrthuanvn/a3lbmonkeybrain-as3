package a3lbmonkeybrain.visualcortex.menus
{
	import a3lbmonkeybrain.brainstem.errors.AbstractMethodError;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	
	import mx.utils.UIDUtil;
	
	[Event(name = "change", type = "flash.events.Event")]
	public class AbstractMenuController extends EventDispatcher implements MenuController
	{
		protected const menuID:String = UIDUtil.createUID();
		public function AbstractMenuController()
		{
			super();
		}
		[Bindable(event = "change")]
		public function get data():MenuDataItem
		{
			throw new AbstractMethodError();
		}
		protected final function dispatchChange(event:Event = null):void
		{
			if (hasEventListener(Event.CHANGE))
				dispatchEvent(new Event(Event.CHANGE));
		}
		public final function handleItem(item:MenuDataItem):Boolean
		{
			/*
			try
			{
			*/
			if (item.controller == this)
			{
				processItem(item);
				return true;
			}
			/*
			}
			catch (e:Error)
			{
				trace("[WARNING]", e);
			}
			*/
			return false;
		}
		protected function processItem(item:MenuDataItem):void
		{
			throw new AbstractMethodError();
		}
	}
}