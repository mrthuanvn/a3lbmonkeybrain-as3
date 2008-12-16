package a3lbmonkeybrain.visualcortex.menus
{
	import a3lbmonkeybrain.brainstem.filter.filterType;
	
	import flash.events.EventDispatcher;
	
	import mx.collections.ArrayCollection;
	import mx.core.IPropertyChangeNotifier;
	import mx.events.PropertyChangeEvent;
	import mx.utils.UIDUtil;
	
	[Bindable]
	[Event(name = "propertyChange", type = "mx.events.PropertyChangeEvent")]
	public final class MenuDataItem extends EventDispatcher implements IPropertyChangeNotifier
	{
		public static const SEPARATOR:MenuDataItem = createSeparator();
		private const _children:ArrayCollection = new ArrayCollection;
		private var _controller:MenuController;
		private var _data:Object;
		private var _enabled:Boolean = true;
		private var _groupName:String = "";
		private var _label:String = "";
		private var _toggled:Boolean = false;
		private var _type:String = "normal";
		private var _uid:String = UIDUtil.createUID();
		public function MenuDataItem()
		{
			super();
			_children.filterFunction = filterType(MenuDataItem);
		}
		public function get children():ArrayCollection
		{
			return _children;
		}
		public function set children(value:ArrayCollection):void
		{
			_children.source = value ? value.source : [];
			_children.refresh();
		}
		public function get controller():MenuController
		{
			return _controller;
		}
		public function set controller(value:MenuController):void
		{
			if (_controller != value)
			{
				const oldValue:Object = _controller;
				_controller = value;
				dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "controller", oldValue, value));
			}
		}
		public function get data():Object
		{
			return _data;
		}
		public function set data(value:Object):void
		{
			if (_data != value)
			{
				const oldValue:Object = _data;
				_data = value;
				dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "data", oldValue, value));
			}
		}
		public function get enabled():Object
		{
			return _enabled;
		}
		public function set enabled(value:Object):void
		{
			if (_enabled != value)
			{
				const oldValue:Object = _enabled;
				_enabled = value;
				dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "enabled", oldValue, value));
			}
		}
		public function get groupName():String
		{
			return _groupName;
		}
		public function set groupName(value:String):void
		{
			if (_groupName != value)
			{
				const oldValue:Object = _groupName;
				_groupName = value;
				dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "groupName", oldValue, value));
			}
		}
		public function get label():String
		{
			return _label;
		}
		public function set label(value:String):void
		{
			if (_label != value)
			{
				const oldValue:Object = _label;
				_label = value;
				dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "label", oldValue, value));
			}
		}
		public function get toggled():Boolean
		{
			return _toggled;
		}
		public function set toggled(value:Boolean):void
		{
			if (_toggled != value)
			{
				_toggled = value;
				dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "label", !value, value));
			}
		}
		public function get type():String
		{
			return _type;
		}
		public function set type(value:String):void
		{
			if (_type != value)
			{
				const oldValue:Object = _type;
				_type = value;
				dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "type", oldValue, value));
			}
		}
		public function get uid():String
		{
			return _uid;
		}
		public function set uid(value:String):void
		{
			if (_uid != value)
			{
				const oldValue:Object = _controller;
				_uid = value;
				dispatchEvent(PropertyChangeEvent.createUpdateEvent(this, "uid", oldValue, value));
			}
		}
		private static function createSeparator():MenuDataItem
		{
			const item:MenuDataItem = new MenuDataItem();
			item.type = MenuDataItemType.SEPARATOR;
			return item;
		}
	}
}