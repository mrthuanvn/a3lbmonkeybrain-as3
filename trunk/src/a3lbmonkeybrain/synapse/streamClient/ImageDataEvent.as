package a3lbmonkeybrain.synapse.streamClient
{
	import flash.events.Event;
	
	/**
	 * Event that is dispatched when image data is received from a stream.
	 *  
	 * @author T. Michael Keesey
	 * @see NetStreamClient#event:imageData
	 */
	public final class ImageDataEvent extends AbstractNetStreamEvent
	{
		/**
		 * Constant storing the <code>type</code> value for all <code>ImageDataEvent</code> objects.
		 * 
		 * @eventType imageData
		 * @see #type
		 */
		public static const IMAGE_DATA:String = "imageData";
		private var _imageData:ImageData;
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
		public function ImageDataEvent(bubbles:Boolean = false, cancelable:Boolean = false, info:Object = null)
		{
			super(IMAGE_DATA, bubbles, cancelable, info);
			_imageData = new ImageData(info);
		}
		/**
		 * Image data.
		 */
		public function get imageData():ImageData
		{
			return _imageData;
		}
		/**
		 * @inheritDoc 
		 */
		override public function clone():Event
		{
			return new ImageDataEvent(bubbles, cancelable, info);
		}
	}
}