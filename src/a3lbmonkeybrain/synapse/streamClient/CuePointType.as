package a3lbmonkeybrain.synapse.streamClient
{
	/**
	 * Static class with constants for <code>CuePoint.type</code>. 
	 * 
	 * @author T. Michael Keesey
	 * @see CuePoint#type
	 */
	public final class CuePointType
	{
		/**
		 * Signifies an <code>event</code> cue point. 
		 */
		public static const EVENT:String = "event";
		/**
		 * Signifies a <code>navigation</code> cue point. 
		 */
		public static const NAVIGATION:String = "navigation";
		/**
		 * Do not invoke. 
		 * 
		 * @throws TypeError
		 * 		<code>TypeError</code>: Always.
		 * @private
		 */
		public function CuePointType()
		{
			throw new TypeError();
		}
	}
}