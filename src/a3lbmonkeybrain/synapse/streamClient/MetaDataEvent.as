package a3lbmonkeybrain.synapse.streamClient
{
	import flash.events.Event;
	
	/**
	 * Event that is dispatched when metadata is received from a stream.
	 *  
	 * @author T. Michael Keesey
	 * @see NetStreamClient#event:metaData
	 */
	public final class MetaDataEvent extends AbstractNetStreamEvent
	{
		/**
		 * Constant storing the <code>type</code> value for all <code>MetaDataEvent</code> objects.
		 * 
		 * @eventType metaData
		 * @see #type
		 */
		public static const META_DATA:String = "metaData";
		private var _metaData:MetaData;
		/**
		 * Creates a new instance.
		 *  
		 * @param bubbles
		 * 		Indicates whether this event is a bubbling event.
		 * @param cancelable
		 * 		Indicates whether the behavior associated with this event can be prevented.
		 * @param info
		 * 		Information object provided by a <code>NetStream</code> handler function.
		 * @see #bubbles
		 * @see #cancelable
		 * @see #info
		 */
		public function MetaDataEvent(bubbles:Boolean = false, cancelable:Boolean = false, info:Object = null)
		{
			super(META_DATA, bubbles, cancelable, info);
			_metaData = new MetaData(info);
		}
		/**
		 * Metadata. 
		 */
		public function get metaData():MetaData
		{
			return _metaData;
		}
		/**
		 * @inheritDoc 
		 */
		override public function clone():Event
		{
			return new MetaDataEvent(bubbles, cancelable, info);
		}
	}
}