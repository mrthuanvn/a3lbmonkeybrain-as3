package a3lbmonkeybrain.synapse.streamClient
{
	/**
	 * Encapsulates text data.
	 *  
	 * @author T. Michael Keesey
	 * @see TextDataEvent#textData
	 */
	public final class TextData extends AbstractNetStreamInfo
	{
		/**
		 * Creates a new instance.
		 *  
		 * @param info
		 * 		Text data.
		 */
		public function TextData(info:Object)
		{
			super(info);
		}
	}
}