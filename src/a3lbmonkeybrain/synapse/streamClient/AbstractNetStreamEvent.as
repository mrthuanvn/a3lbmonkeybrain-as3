package a3lbmonkeybrain.synapse.streamClient
{
	import a3lbmonkeybrain.brainstem.core.findClassName;
	import a3lbmonkeybrain.brainstem.errors.AbstractMethodError;
	
	import flash.events.Event;

	/**
	 * Abstract superclass for <code>NetStreamClient</code> events.
	 * <p>
	 * This class should not be extended by classes in other packages.
	 * </p>
	 * 
	 * @author T. Michael Keesey
	 * @see NetStreamClient
	 */
	public class AbstractNetStreamEvent extends Event
	{
		private var _info:Object;
		/**
		 * Creates a new instance.
		 *  
		 * @param type
		 * 		The type of this event.
		 * @param bubbles
		 * 		Indicates whether this event is a bubbling event.
		 * @param cancelable
		 * 		Indicates whether the behavior associated with this event can be prevented.
		 * @param info
		 * 		Information object provided by a <code>NetStream</code> handler function.
		 * @see #bubbles
		 * @see #cancelable
		 * @see #info
		 * @see #type
		 * @see flash.net.NetStream
		 */
		public function AbstractNetStreamEvent(type:String, bubbles:Boolean = false, cancelable:Boolean = false,
			info:Object = null)
		{
			super(type, bubbles, cancelable);
			_info = (info == null) ? {} : info;
		}
		/**
		 * Information object provided by a <code>NetStream</code> handler function.
		 */
		protected final function get info():Object
		{
			return _info;
		}
		/**
		 * @inheritDoc 
		 */
		override public function clone():Event
		{
			throw new AbstractMethodError();
		}
		/**
		 * @inheritDoc 
		 */
		override public final function toString():String
		{
			return formatToString(findClassName(this), "bubbles", "cancelable", "eventPhase", type);
		}
	}
}