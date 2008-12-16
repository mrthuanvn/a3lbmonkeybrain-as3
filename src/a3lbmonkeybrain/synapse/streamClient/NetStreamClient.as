package a3lbmonkeybrain.synapse.streamClient
{
	import flash.events.EventDispatcher;
	import flash.net.NetStream;
	
	/**
	 * Dispatched whenever a cue point is reached in the stream.
	 *
	 * @eventType a3lbmonkeybrain.stream.CuePointEvent.CUE_POINT
	 */
	[Event(name = "cuePoint", type = "a3lbmonkeybrain.stream.CuePointEvent")]
	/**
	 * Dispatched when image data is received.
	 *
	 * @eventType a3lbmonkeybrain.stream.ImageDataEvent.IMAGE_DATA
	 */
	[Event(name = "imageData", type = "a3lbmonkeybrain.stream.ImageDataEvent")]
	/**
	 * Dispatched once, when metadata is received.
	 *
	 * @eventType a3lbmonkeybrain.stream.MetaDataEvent.META_DATA
	 */
	[Event(name = "metaData", type = "a3lbmonkeybrain.stream.MetaDataEvent")]
	/**
	 * Dispatched when play status information is received.
	 *
	 * @eventType a3lbmonkeybrain.stream.PlayStatusEvent.PLAY_STATUS
	 */
	[Event(name = "playStatus", type = "a3lbmonkeybrain.stream.PlayStatusEvent")]
	/**
	 * Dispatched when text data is received.
	 *
	 * @eventType a3lbmonkeybrain.stream.TextDataEvent.TEXT_DATA
	 */
	[Event(name = "textData", type = "a3lbmonkeybrain.stream.TextDataEvent")]
	/**
	 * Provides an event dispatcher API for <code>NetStream</code> handlers.
	 * <p>
	 * To use this class, you can use the following code:
	 * </p>
	 * <pre>
	 * import flash.net.NetConnection;
	 * import flash.net.NetStream;
	 * import a3lbmonkeybrain.synapse.streamClient.~~;
	 * 
	 * var connection:NetConnection = new NetConnection();
	 * connection.connect(null);
	 * var stream:NetStream = new NetStream(connection);
	 * var client:NetStreamClient = NetStreamClient.createForNetStream(stream);
	 * </pre>
	 * <p>
	 * Once this is set up, you can listen for events from the client. For example:
	 * </p>
	 * <pre>
	 * client.addEventListener(CuePointEvent.CUE_POINT, onCuePoint);
	 * function onCuePoint(event:CuePointEvent):void
	 * {
	 *     trace(event.cuePoint);
	 * }
	 * </pre>
	 * 
	 * @author T. Michael Keesey
	 * @see flash.net.NetStream#client
	 */
	public class NetStreamClient extends EventDispatcher
	{
		private var _eventsBubble:Boolean = false;
		private var _eventsCancelable:Boolean = false;
		private var _netStream:NetStream;
		private var _metaData:MetaData;
		/**
		 * Creates a new instance.
		 * 
		 * @param netStream
		 * 		<code>NetStream</code> object to attach the client to. Retrievable as <code>netStream</code>.
		 * @see #netStream
		 * @see flash.net.NetStream#client
		 */
		public function NetStreamClient(netStream:NetStream = null)
		{
			super();
			if (netStream != null)
			{
				_netStream = netStream;
				netStream.client = this;
			}
		}
		/**
		 * Determines how events dispatched by this object set their <code>Event.bubbles</code> property.
		 * 
		 * @defaultValue false
		 * @see #eventsCancelable
		 * @see flash.events.Event#bubbles
		 */
		public function get eventsBubble():Boolean
		{
			return _eventsBubble;
		}
		/**
		 * @private
		 */
		public function set eventsBubble(value:Boolean):void
		{
			_eventsBubble = value;
		}
		/**
		 * Determines how events dispatched by this object set their <code>Event.cancelable</code> property.
		 * 
		 * @defaultValue false
		 * @see #eventsBubble
		 * @see flash.events.Event#cancelable
		 */
		public function get eventsCancelable():Boolean
		{
			return _eventsCancelable;
		}
		/**
		 * @private
		 */
		public function set eventsCancelable(value:Boolean):void
		{
			_eventsCancelable = value;
		}
		/**
		 * The metadata received by this client. If <code>null</code>, then no metadata has been received yet.
		 */
		public function get metaData():MetaData
		{
			return _metaData;
		}
		/**
		 * The stream that this client is attached to. Can only be set with the constructor.
		 * 
		 * @see #NetStreamClient
		 */
		public function get netStream():NetStream
		{
			return _netStream;
		}
		/**
		 * Handler for cue point events.
		 * 
		 * @param info
		 * 		Cue point information.
		 * @see #event:cuePoint
		 * @see flash.net.NetStream#onCuePoint
		 */
		public function onCuePoint(info:Object):void
		{
			if (eventsBubble || hasEventListener(CuePointEvent.CUE_POINT))
				dispatchEvent(new CuePointEvent(eventsBubble, eventsCancelable, info));
		}
		/**
		 * Handler for image data events.
		 * 
		 * @param info
		 * 		Image data.
		 * @see #event:imageData
		 * @see flash.net.NetStream#ImageDataEvent
		 */
		public function onImageData(info:Object):void
		{
			if (eventsBubble || hasEventListener(ImageDataEvent.IMAGE_DATA))
				dispatchEvent(new ImageDataEvent(eventsBubble, eventsCancelable, info));
		}
		/**
		 * Handler for metadata events.
		 * 
		 * @param info
		 * 		Metadata.
		 * @see #event:metaData
		 * @see flash.net.NetStream#onMetaData
		 */
		public function onMetaData(info:Object):void
		{
			const event:MetaDataEvent = new MetaDataEvent(eventsBubble, eventsCancelable, info);
			_metaData = event.metaData;
			if (eventsBubble || hasEventListener(MetaDataEvent.META_DATA))
				dispatchEvent(event);
		}
		/**
		 * Handler for play status events.
		 * 
		 * @param info
		 * 		Play status information.
		 * @see #event:playStatus
		 * @see flash.net.NetStream#onPlayStatus
		 */
		public function onPlayStatus(info:Object):void
		{
			if (eventsBubble || hasEventListener(PlayStatusEvent.PLAY_STATUS))
				dispatchEvent(new PlayStatusEvent(eventsBubble, eventsCancelable, info));
		}
		/**
		 * Handler for text data events.
		 * 
		 * @param info
		 * 		Text data.
		 * @see #event:textData
		 * @see flash.net.NetStream#onTextData
		 */
		public function onTextData(info:Object):void
		{
			if (eventsBubble || hasEventListener(TextDataEvent.TEXT_DATA))
				dispatchEvent(new TextDataEvent(eventsBubble, eventsCancelable, info));
		}
		/**
		 * @inheritDoc
		 */
		override public function toString():String
		{
			return "[NetStreamClient metaData=" + metaData + "]";
		}
	}
}