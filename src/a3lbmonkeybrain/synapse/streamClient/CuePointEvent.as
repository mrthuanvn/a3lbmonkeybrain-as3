package a3lbmonkeybrain.synapse.streamClient
{
	import flash.events.Event;
	
	/**
	 * Event that is dispatched when a cue point is reached in a video stream.
	 *  
	 * @author T. Michael Keesey
	 * @see NetStreamClient#event:cuePoint
	 */
	public final class CuePointEvent extends AbstractNetStreamEvent
	{
		/**
		 * Constant storing the <code>type</code> value for all <code>CuePointEvent</code> objects.
		 * 
		 * @eventType cuePoint
		 * @see #type
		 */
		public static const CUE_POINT:String = "cuePoint";
		private var _cuePoint:CuePoint;
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
		public function CuePointEvent(bubbles:Boolean = false, cancelable:Boolean = false, info:Object = null)
		{
			super(CUE_POINT, bubbles, cancelable, info);
			_cuePoint = new CuePoint(info);
		}
		/**
		 * Cue point information.
		 */
		public function get cuePoint():CuePoint
		{
			return _cuePoint;
		}
		/**
		 * @inheritDoc 
		 */
		override public function clone():Event
		{
			return new CuePointEvent(bubbles, cancelable, info);
		}
	}
}