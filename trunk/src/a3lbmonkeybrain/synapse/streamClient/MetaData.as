package a3lbmonkeybrain.synapse.streamClient
{
	/**
	 * Encapsulates stream metadata.
	 *  
	 * @author T. Michael Keesey
	 * @see MetaDataEvent#metaData
	 * @see NetStreamClient#metaData
	 */
	public final class MetaData extends AbstractNetStreamInfo
	{
		/**
		 * Creates a new instance.
		 *  
		 * @param info
		 * 		Metadata.
		 */
		public function MetaData(info:Object)
		{
			super(info);
		}
 		/**
 		 * Integer representing the codec used by the audio stream.
 		 * <p>
 		 * Examples:
 		 * <ul>
 		 * <li>0 = Uncompressed</li>
 		 * <li>1 = ADPCM</li>
 		 * <li>2 = MP3</li>
 		 * <li>5 = NellyMoser</li>
 		 * <li>6 = NellyMoser</li>
 		 * </ul>
 		 * </p>
 		 * 
 		 * @defaultValue 0
 		 */ 		
 		public function get audioCodecID():uint
 		{
			if (info.hasOwnProperty("audiocodecid"))
				return uint(info.audiocodecid);
			if (info.hasOwnProperty("audioCodecID"))
				return uint(info.audioCodecID);
			return 0;
 		}
 		/**
 		 * Data rate for the audio stream, in kilobits per second. 
 		 * 
 		 * @defaultValue 0
 		 */
 		public function get audioDataRate():uint
 		{
			if (info.hasOwnProperty("audiodatarate"))
				return uint(info.audiodatarate);
			if (info.hasOwnProperty("audioDataRate"))
				return uint(info.audioDataRate);
			return 0;
 		}
 		/**
 		 * Audio delay, in seconds.
 		 * 
 		 * @defaultValue 0
 		 */
 		public function get audioDelay():Number
 		{
			if (info.hasOwnProperty("audiodelay"))
				return Number(info.audiodelay);
			if (info.hasOwnProperty("audioDelay"))
				return Number(info.audioDelay);
			return 0;
 		}
 		/**
 		 * Tells whether the last video tag is a key frame.
 		 * 
 		 * @see flash.net.NetStream#seek()
 		 */
 		public function get canSeekToEnd():Boolean
 		{
			if (info.hasOwnProperty("canSeekToEnd"))
				return String(info.canSeekToEnd).toLowerCase() == "true";
			if (info.hasOwnProperty("canseektoend"))
				return String(info.canseektoend).toLowerCase() == "true";
			return false;
 		}
 		/**
		 * Duration of the video stream, in milliseconds.
		 */
		public function get duration():uint
		{
			if (info.hasOwnProperty("duration"))
				return uint(info.duration);
			return 0;
		}
		/**
		 * Framerate of the video stream, in frames per second. 
		 */
		public function get framerate():Number
		{
			if (info.hasOwnProperty("framerate"))
				return Number(info.framerate);
			return 0;
		}
		/**
		 * Height of the video display, in pixels.
		 */
		public function get height():uint
		{
			if (info.hasOwnProperty("height"))
				return uint(info.height);
			return 0;
		}
 		/**
 		 * Integer representing the codec used by the video stream.
 		 * <p>
 		 * Examples:
 		 * <ul>
 		 * <li>0 = Uncompressed</li>
 		 * <li>2 = Sorenson H.263</li>
 		 * <li>3 = Screen Video</li>
 		 * <li>4 = On2 VP6</li>
 		 * <li>5 = On2 VP6</li>
 		 * <li>6 = Screen Video V2</li>
 		 * </ul>
 		 * </p>
 		 * 
 		 * @defaultValue 0
 		 */ 		
 		public function get videoCodecID():uint
 		{
			if (info.hasOwnProperty("videocodecid"))
				return uint(info.videocodecid);
			if (info.hasOwnProperty("videoCodecID"))
				return Number(info.videoCodecID);
			return 0;
 		}
 		/**
 		 * Data rate for the video stream, in kilobits per second. 
 		 * 
 		 * @defaultValue 0
 		 */
 		public function get videoDataRate():uint
 		{
			if (info.hasOwnProperty("videodatarate"))
				return uint(info.videodatarate);
			if (info.hasOwnProperty("videoDataRate"))
				return uint(info.videoDataRate);
			return 0;
 		}
		/**
		 * Width of the video display, in pixels.
		 */
		public function get width():uint
		{
			if (info.hasOwnProperty("width"))
				return uint(info.width);
			return 0;
		}
	}
}