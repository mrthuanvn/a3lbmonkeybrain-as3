package a3lbmonkeybrain.synapse.streamClient
{
	import flash.utils.ByteArray;
	
	/**
	 * Encapsulates image data.
	 * 
	 * @author T. Michael Keesey
	 * @see ImageDataEvent#imageData
	 */
	public final class ImageData extends AbstractNetStreamInfo
	{
		/**
		 * Creates a new instance.
		 *  
		 * @param info
		 * 		Image data.
		 */
		public function ImageData(info:Object)
		{
			super(info);
		}
		/**
		 * The image data as a <code>ByteArray</code> object. May be <code>null</code>.
		 * 
		 * @see flash.display.Loader#loadBytes()
		 */
		public function get data():ByteArray
		{
			if (info.hasOwnProperty("data") && info.data is ByteArray)
				return info.data as ByteArray;
			return null;
		}
	}
}