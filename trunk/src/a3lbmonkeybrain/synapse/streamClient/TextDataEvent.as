package a3lbmonkeybrain.synapse.streamClient
{
	import flash.events.Event;
	
	/**
	 * Event that is dispatched when text data is received from a stream.
	 *  
	 * @author T. Michael Keesey
	 * @see NetStreamClient#event:textData
	 */
	public final class TextDataEvent extends AbstractNetStreamEvent
	{
		/**
		 * Constant storing the <code>type</code> value for all <code>TextDataEvent</code> objects.
		 * 
		 * @eventType textData
		 * @see #type
		 */
		public static const TEXT_DATA:String = "textData";
		private var _textData:TextData;
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
		public function TextDataEvent(bubbles:Boolean = false, cancelable:Boolean = false, info:Object = null)
		{
			super(TEXT_DATA, bubbles, cancelable, info);
			_textData = new TextData(info);
		}
		/**
		 * Text data.
		 */
		public function get textData():TextData
		{
			return _textData;
		}
		/**
		 * @inheritDoc 
		 */
		override public function clone():Event
		{
			return new TextDataEvent(bubbles, cancelable, info);
		}
	}
}