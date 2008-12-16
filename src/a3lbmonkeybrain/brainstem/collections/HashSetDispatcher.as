package a3lbmonkeybrain.brainstem.collections
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * Dispatched whenever the content of this set changes.
	 * 
	 * @eventType flash.events.Event.CHANGE
	 * @see http://livedocs.adobe.com/flex/3/langref/flash/events/Event.html
	 * 		flash.events.Event
	 * @see http://livedocs.adobe.com/flex/3/langref/flash/events/Event.html#CHANGE
	 * 		flash.events.Event.CHANGE
	 */
	[Event(name = "change", type = "flash.events.Event")]
	/**
	 * A mutable set which dispatches an event whenever its content is changed.
	 * <p>
	 * All properties are bindable.
	 * </p>
	 *  
	 * @author T. Michael Keesey
	 * @see #event:change
	 */
	public class HashSetDispatcher extends HashSet implements IEventDispatcher
	{
		/**
		 * The dispatcher used to dispatch <code>change</code> events. 
		 * 
		 * @see #event:change
		 */
		protected var dispatcher:IEventDispatcher;
		/**
		 * Creates a new (empty) instance. 
		 */
		public function HashSetDispatcher()
		{
			super();
			dispatcher = new EventDispatcher(this);
		}
		[Bindable(event = "change")]
		/**
		 * @inheritDoc
		 */
		override public function get empty():Boolean
		{
			return _size == 0;
		}
		[Bindable(event = "change")]
		/**
		 * @inheritDoc
		 */
		override public function get singleMember():Object
		{
			return super.singleMember;
		}
		[Bindable(event = "change")]
		/**
		 * @inheritDoc
		 */
		override public function get size():int
		{
			return _size;
		}
		/**
		 * @inheritDoc
		 */
		override public function add(member:Object):void
		{
			const s:int = _size;
			super.add(member);
			if (_size != s && hasEventListener(Event.CHANGE))
				dispatchEvent(new Event(Event.CHANGE));
		}
		/**
		 * Registers an event listener with this set so that the listener receives notification of content changes.
		 * 
		 * @param type
		 * 		The type of event.
		 * @param listener
		 * 		The listener function that processes the event. This function must accept an event object as its only argument
		 * 		and should return nothing.
		 * @param useCapture
		 * 		Determines whether the listener works in the capture phase or the target and bubbling phases.
		 * @param priority
		 * 		The priority level of the event listener.
		 * @param useWeakReference
		 * 		Determines whether the reference to the listener is strong or weak.
		 * @see #event:change
		 * @see http://livedocs.adobe.com/flex/3/langref/flash/events/IEventDispatcher.html#addEventListener()
		 * 		flash.events.IEventDispatcher#addEventListener()
		 */
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		/**
		 * @inheritDoc
		 */
		override public function addMembers(value:Object):void
		{
			const s:int = _size;
			super.addMembers(value);
			if (_size != s && hasEventListener(Event.CHANGE))
				dispatchEvent(new Event(Event.CHANGE));
		}
		/**
		 * @inheritDoc
		 */
		override public function clear():void
		{
			if (_size != 0)
			{
				super.clear();
				if (hasEventListener(Event.CHANGE))
					dispatchEvent(new Event(Event.CHANGE));
			}
		}
		/**
		 * Dispatches an event into the event flow.
		 *  
		 * @param event
		 * 		The event object dispatched into the event flow.
		 * @return 
		 * 		A value of <code>true</code> unless <code>preventDefault()</code> is called on the event, in which case it returns <code>false</code>.
		 * @see #event:change
		 * @see http://livedocs.adobe.com/flex/3/langref/flash/events/IEventDispatcher.html#dispatchEvent()
		 * 		flash.events.IEventDispatcher#dispatchEvent()
		 */
		public function dispatchEvent(event:Event):Boolean
		{
			return dispatcher.dispatchEvent(event);
		}
		/**
		 * Checks whether this object has any listeners registered for a specific type of event. 
		 * 
		 * @param type
		 * 		The type of event.
		 * @return 
		 * 		A value of <code>true</code> if a listener of the specified type is registered; <code>false</code> otherwise. 
		 * @see #event:change
		 * @see http://livedocs.adobe.com/flex/3/langref/flash/events/IEventDispatcher.html#hasEventListener()
		 * 		flash.events.IEventDispatcher#hasEventListener()
		 */
		public function hasEventListener(type:String):Boolean
		{
			return dispatcher.hasEventListener(type);
		}
		/**
		 * @inheritDoc
		 */
		override public function remove(member:Object):void
		{
			const s:int = _size;
			super.remove(member);
			if (_size != s && hasEventListener(Event.CHANGE))
				dispatchEvent(new Event(Event.CHANGE));
		}
		/**
		 * Removes a listener from this object. 
		 * 
		 * @param type
		 * 		The type of event.
		 * @param listener
		 * 		The listener function to remove.
		 * @param useCapture
		 * 		Specifies whether the listener was registered for the capture phase or the target and bubbling phases.
		 * @see #event:change
		 * @see http://livedocs.adobe.com/flex/3/langref/flash/events/IEventDispatcher.html#removeEventListener()
		 * 		flash.events.IEventDispatcher#removeEventListener()
		 */
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		/**
		 * @inheritDoc
		 */
		override public function removeMembers(value:Object):void
		{
			const s:int = _size;
			super.removeMembers(value);
			if (_size != s && hasEventListener(Event.CHANGE))
				dispatchEvent(new Event(Event.CHANGE));
		}
		/**
		 * Sets the content of this set to the content of another collection.
		 * 
		 * @param value
		 * 		A finite collection. May be an implementation of <code>FiniteCollection</code> or an object whose members can
		 * 		be iterated over using a <code>for each..in</code> loop.
		 * @throws ArgumentError
		 * 		<code>ArgumentError</code> - If <code>value</code> is a nonfinite collection.
		 * @see Collection
		 * @see FiniteCollection
		 * @see http://livedocs.adobe.com/flex/3/langref/statements.html#for_each..in
		 * 		for each..in
		 */
		public function setTo(value:Object):void
		{
			if (value is Collection && !(value is FiniteCollection))
				throw new ArgumentError("Cannot set a finite set's content to the content of a nonfinite collection.");
			if (!value is FiniteSet)
				value = HashSet.fromObject(value);
			if (!equals(value))
			{
				super.clear();
				super.addMembers(value);
				if (hasEventListener(Event.CHANGE))
					dispatchEvent(new Event(Event.CHANGE));
			}
		}
		/**
		 * Checks whether an event listener is registered with this object or any of its ancestors for the specified event type. 
		 * 
		 * @param type
		 * 		The type of event.
		 * @return 
		 * 		A value of <code>true</code> if a listener of the specified type will be triggered; <code>false</code> otherwise. 
		 * @see #event:change
		 * @see http://livedocs.adobe.com/flex/3/langref/flash/events/IEventDispatcher.html#willTrigger()
		 * 		flash.events.IEventDispatcher#willTrigger()
		 */
		public function willTrigger(type:String):Boolean
		{
			return dispatcher.willTrigger(type);
		}
	}
}