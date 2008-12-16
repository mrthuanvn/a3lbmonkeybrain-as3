package a3lbmonkeybrain.synapse.streamClient
{
	import flash.events.Event;

	/**
	 * Event that is dispatched when play status is received from a video stream.
	 *  
	 * @author T. Michael Keesey
	 * @see NetStreamClient#event:playStatus
	 */
	public final class PlayStatusEvent extends AbstractNetStreamEvent
	{
		/**
		 * Constant storing the <code>type</code> value for all <code>PlayStatusEvent</code> objects.
		 * 
		 * @eventType playStatus
		 * @see #type
		 */
		public static const PLAY_STATUS:String = "playStatus";
		private var _playStatus:PlayStatus;
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
		public function PlayStatusEvent(bubbles:Boolean = false, cancelable:Boolean = false, info:Object = null)
		{
			super(PLAY_STATUS, bubbles, cancelable, info);
			_playStatus = new PlayStatus(info);
		}
		/**
		 * Play status information. 
		 */
		public function get playStatus():PlayStatus
		{
			return _playStatus;
		}
		/**
		 * @inheritDoc 
		 */
		override public function clone():Event
		{
			return new PlayStatusEvent(bubbles, cancelable, info);
		}
	}
}