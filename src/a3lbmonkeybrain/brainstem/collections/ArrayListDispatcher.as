package a3lbmonkeybrain.brainstem.collections
{
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	/**
	 * Dispatched whenever the content of this list changes.
	 * 
	 * @eventType flash.events.Event.CHANGE
	 * @see http://livedocs.adobe.com/flex/3/langref/flash/events/Event.html
	 * 		flash.events.Event
	 * @see http://livedocs.adobe.com/flex/3/langref/flash/events/Event.html#CHANGE
	 * 		flash.events.Event.CHANGE
	 */
	[Event(name = "change", type = "flash.events.Event")]
	public class ArrayListDispatcher extends ArrayList implements IEventDispatcher
	{
		protected var blockRemoveDispatch:Boolean = false;
		/**
		 * The dispatcher used to dispatch <code>change</code> events. 
		 * 
		 * @see #event:change
		 */
		protected var dispatcher:IEventDispatcher;
		/**
		 * Creates a new instance. 
		 */
		public function ArrayListDispatcher()
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
			return members.length == 0;
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
			return members.length;
		}
		override public function add(member:Object):void
		{
			super.add(member);
			if (hasEventListener(Event.CHANGE))
				dispatchEvent(new Event(Event.CHANGE));
		}
		override public function addMembers(value:Object):void
		{
			const s:int = size;
			super.addMembers(value);
			if (size != s && hasEventListener(Event.CHANGE))
				dispatchEvent(new Event(Event.CHANGE));
		}
		public function addEventListener(type:String, listener:Function, useCapture:Boolean=false, priority:int=0, useWeakReference:Boolean=false):void
		{
			dispatcher.addEventListener(type, listener, useCapture, priority, useWeakReference);
		}
		public function dispatchEvent(event:Event):Boolean
		{
			return dispatchEvent(event);
		}
		public function hasEventListener(type:String):Boolean
		{
			return dispatcher.hasEventListener(type);
		}
		override public function remove(member:Object):void
		{
			var s:int;
			const d:Boolean = !blockRemoveDispatch && hasEventListener(Event.CHANGE);
			if (d)
				s = size;
			super.remove(member);
			if (d && s != size)
				dispatchEvent(new Event(Event.CHANGE));
		}
		override public function removeAt(index:int):void
		{
			super.removeAt(index);
			if (hasEventListener(Event.CHANGE))
				dispatchEvent(new Event(Event.CHANGE));
		}
		override public function removeMembers(value:Object):void
		{
			blockRemoveDispatch = true;
			const s:int = size;
			super.removeMembers(value);
			blockRemoveDispatch = false;
			if (s != size && hasEventListener(Event.CHANGE))
				dispatchEvent(new Event(Event.CHANGE));
		}
		public function removeEventListener(type:String, listener:Function, useCapture:Boolean=false):void
		{
			dispatcher.removeEventListener(type, listener, useCapture);
		}
		public function willTrigger(type:String):Boolean
		{
			return dispatcher.willTrigger(type);
		}
		
	}
}