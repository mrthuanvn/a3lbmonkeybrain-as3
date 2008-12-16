package a3lbmonkeybrain.hippocampus.domain
{
	import a3lbmonkeybrain.brainstem.core.findClass;
	import a3lbmonkeybrain.brainstem.core.findClassName;
	import a3lbmonkeybrain.brainstem.filter.filterType;
	import a3lbmonkeybrain.brainstem.relate.Equality;
	import a3lbmonkeybrain.brainstem.relate.OrderSort;
	import a3lbmonkeybrain.brainstem.strings.trim;
	import a3lbmonkeybrain.hippocampus.text.Writers;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.utils.getQualifiedClassName;
	
	import mx.collections.ArrayCollection;
	import mx.core.IUID;
	import mx.events.PropertyChangeEvent;
	import mx.utils.UIDUtil;
	
	[Bindable]
	[Event(name = "propertyChange", type = "mx.events.PropertyChangeEvent")]
	/**
	 * A basic implementation of <code>Persistent</code> which may be extended for specific value objects.
	 *  
	 * @author T. Michael Keesey
	 * @see Persistent
	 */
	public class AbstractPersistent extends EventDispatcher implements Persistent
	{
		private static const uidHash:Object = {};
		private const pendingPropertyEvents:Array = [];
		private var _id:uint;
		private var _uid:String;
		private var _version:uint;
		/**
		 * Creates a new instance.
		 */
		public function AbstractPersistent()
		{
			super();
		}
		/**
		 * @inheritDoc
		 */
		public final function get id():uint
		{
			return _id;
		}
		/**
		 * @private
		 */
		public final function set id(value:uint):void
		{
			_id = assessPropertyValue("id", value) as uint;
			if (value != 0)
				_uid = null;
			flushPendingPropertyEvents();
		}
		[Transient]
		/**
		 * @inheritDoc
		 */
		public final function get uid():String
		{
			if (_id == 0)
			{
				if (_uid == null)
					_uid = UIDUtil.createUID();
				return _uid;
			}
			const id:String = getQualifiedClassName(this) + "#" + id;
			const current:* = uidHash[id];
			if (current is String)
				return current as String;
			const uid:String = UIDUtil.createUID();
			uidHash[id] = uid;
			return uid;
		}
		/**
		 * @private
		 */
		public final function set uid(value:String):void
		{
			// Do nothing.
		}
		/**
		 * @inheritDoc
		 */
		public final function get version():uint
		{
			return _version;
		}
		/**
		 * @private
		 */
		public final function set version(value:uint):void
		{
			_version = assessPropertyValue("version", value) as uint;
			flushPendingPropertyEvents();
		}
		/**
		 * Assesses the new value of a property. If warranted, stacks an event to dispatch after the
		 * value is updated. The events can be dispatched by calling <code>flushpendingEvents()</code>.
		 * <p>
		 * This method and <code>flushPendingEvents()</code> can be called by setter functions to ensure
		 * that events are dispatched when a property changes. Updating a property should dispatch a
		 * <code>PropertyChangeEvent</code> instance.
		 * </p>
		 * <p>
		 * <code>Equality.equals()</code> is used to determine if the values are the same. Implementing
		 * <code>Equatable</code> allows custom equating.
		 * </p>
		 * <p>
		 * Example:
		 * <pre>
		 * package primates.anthropoidea
		 * {
		 *  import a3lbmonkeybrain.hippocampus.domain.AbstractEntity;
		 * 
		 *  [Bindable]
		 *  [RemoteClass(alias = &quot;primates.anthropoidea.Gorilla&quot;)]
		 * 	public class Gorilla extends AbstractEntity
		 *  {
		 * 		private var _name:String;
		 * 		[Bindable(event = &quot;nameChange&quot;)]
		 * 		public function get name():String
		 * 		{
		 * 			return _name;
		 * 		}
		 * 		public function set name(value:String):void
		 * 		{
		 * 			_name = assessPropertyValue(&quot;name&quot;, value) as String;
		 * 			flushPendingEvents();
		 * 		}
		 *  }
		 * }
		 * </pre>
		 * </p>
		 * 
		 * @param property
		 * 		The name of the property (for example, <code>&quot;name&quot;</code>).
		 * @param newValue
		 * 		The new value for the property.
		 * @return
		 * 		The new value for the property, or the old value if no change is needed.
		 * @see #event:propertyChange
		 * @see #flushPendingEvents()
		 * @see mx.events.PropertyChangeEvent
		 * @see a3lbmonkeybrain.brainstem.relate.Equality
		 * @see a3lbmonkeybrain.brainstem.relate.Equatable
		 * @see a3lbmonkeybrain.brainstem.relate.Equality#equals
		 */
		protected final function assessPropertyValue(property:String, newValue:Object):Object
		{
			const oldValue:Object = this[property];
			if (!Equality.equal(newValue, oldValue))
			{
				pendingPropertyEvents.push(PropertyChangeEvent.createUpdateEvent(this, property,
					oldValue, newValue));
				return newValue;
			}
			return oldValue;
		}
		protected static function createEntityCollection(entityClass:Class):ArrayCollection
		{
			const collection:ArrayCollection = new ArrayCollection();
			collection.filterFunction = filterType(entityClass);
			collection.sort = OrderSort.uniqueSort;
			return collection;
		}
		/**
		 * @inheritDoc
		 */
		public final function equals(value:Object):Boolean
		{
			if (this == value)
				return true;
			if (_id == 0)
				return false;
			if (value is Persistent)
			{
				if (findClass(this) == findClass(value))
					return _id == Persistent(value).id;
			}
			return false;
		}
		/**
		 * @inheritDoc
		 */
		public function findOrder(value:Object):int
		{
			if (this == value)
				return 0;
			if (value is Persistent)
			{
				const otherID:uint = Persistent(value).id;
				if (_id == otherID)
				{
					if (_id == 0)
					{
						const otherUID:String = IUID(value).uid;
						if (uid == otherUID)
							return 0;
						if (uid < otherUID)
							return -1;
						return 1;
					}
				}
				if (_id < otherID)
					return -1;
				return 1;
			}
			return 0;
		}
		/**
		 * Dispatches any pending property change events. See <code>assessPropertyValue()</code> for
		 * how to use.
		 * 
		 * @see #assessPropertyValue()
		 */
		protected final function flushPendingPropertyEvents():void
		{
			var event:*;
			while ((event = pendingPropertyEvents.shift()) is Event)
			{
				if (event.bubbles || hasEventListener(event.type))
					dispatchEvent(event as Event);
			}
		}
		/**
		 * @inheritDoc
		 */
		override public final function toString():String
		{
			var s:String = "[" + findClassName(this);
			if (_id > 0)
				s += " #" + _id + "." + _version;
			else
				s += "*";
			const written:String = trim(Writers.writeText(this));
			if (written.length > 0)
				s += " " + written;
			s += "]";
			return s;
		}
	}
}