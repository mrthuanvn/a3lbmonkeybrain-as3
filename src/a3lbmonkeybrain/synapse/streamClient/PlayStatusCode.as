package a3lbmonkeybrain.synapse.streamClient
{
	/**
	 * Static class with constants for <code>PlayStatus.code</code>.
	 *  
	 * @author T. Michael Keesey
	 * @see PlayStatus#code
	 */
	public final class PlayStatusCode
	{
		/**
		 * Signifies a completion event. 
		 */
		public static const COMPLETE:String = "NetStream.Play.Complete";
		/**
		 * Signifies a stream-switching event. 
		 */
		public static const SWITCH:String = "NetStream.Play.Switch";
		/**
		 * Do not invoke. 
		 * 
		 * @throws TypeError
		 * 		<code>TypeError</code>: Always.
		 * @private
		 */
		public function PlayStatusCode()
		{
			throw new TypeError();
		}
	}
}