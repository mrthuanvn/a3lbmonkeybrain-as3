package a3lbmonkeybrain.synapse.streamClient
{
	/**
	 * Encapsulates play status information.
	 * 
	 * @author T. Michael Keesey
	 * @see PlayStatusEvent#playStatus
	 */
	public final class PlayStatus extends AbstractNetStreamInfo
	{
		/**
		 * Creates a new instance.
		 *  
		 * @param info
		 * 		Play status information.
		 */
		public function PlayStatus(info:Object)
		{
			super(info);
		}
		/**
		 * Number of bytes loaded so far. 
		 */
		public function get bytes():uint
		{
			if (info.hasOwnProperty("bytes"))
				return uint(info.bytes);
			return 0;
		}
		/**
		 * Code for the type of play status event.
		 *  
		 * @see PlayStatusCode
		 * @see PlayStatusCode#COMPLETE
		 * @see PlayStatusCode#SWITCH
		 */
		public function get code():String
		{
			if (info.hasOwnProperty("code"))
				return info.code as String;
			return null;
		}
		/**
		 * Duration, in seconds, to this point. 
		 */
		public function get duration():Number
		{
			if (info.hasOwnProperty("duration"))
				return Number(info.duration);
			return 0;
		}
		/**
		 * Level of the event.
		 * 
		 * @see PlayStatusLevel 
		 * @see PlayStatusLevel#STATUS
		 */
		public function get level():String
		{
			if (info.hasOwnProperty("level"))
				return info.level as String;
			return null;
		}
	}
}