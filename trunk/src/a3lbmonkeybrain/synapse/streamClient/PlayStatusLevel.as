package a3lbmonkeybrain.synapse.streamClient
{
	/**
	 * Static class with constants for <code>PlayStatus.level</code>.
	 *  
	 * @author T. Michael Keesey
	 * @see PlayStatus#level
	 */
	public final class PlayStatusLevel
	{
		/**
		 * Indicates a status event. 
		 */
		public static const STATUS:String = "status";
		/**
		 * Do not invoke. 
		 * 
		 * @throws TypeError
		 * 		<code>TypeError</code>: Always.
		 * @private
		 */
		public function PlayStatusLevel()
		{
			throw new TypeError();
		}
	}
}