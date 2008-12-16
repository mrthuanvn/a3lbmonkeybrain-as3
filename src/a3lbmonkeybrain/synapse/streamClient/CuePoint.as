package a3lbmonkeybrain.synapse.streamClient
{
	/**
	 * Encapsulates cue point data.
	 *  
	 * @author T. Michael Keesey
	 * @see CuePointEvent#cuePoint
	 */
	public final class CuePoint extends AbstractNetStreamInfo
	{
		/**
		 * Creates a new instance.
		 *  
		 * @param info
		 * 		Cue point information.
		 */
		public function CuePoint(info:Object)
		{
			super(info);
		}
		/**
		 * The name given to the cue point when it was embedded in the video file.
		 */
		public function get name():String
		{
			if (info.hasOwnProperty("name"))
				return info.name as String;
			return null;
		}
		/**
		 * A associative array of name/value pair strings specified for this cue point. Any valid string can be used for the parameter name or value.
		 */
		public function get parameters():Object
		{
			if (info.hasOwnProperty("parameters"))
				return info.parameters as Object;
			return null;
		}
		/**
		 * The time, in seconds, which the cue point occurred at in the video file during playback.
		 */
		public function get time():Number
		{
			if (info.hasOwnProperty("time"))
				return Number(info.time);
			return NaN;
		}
		/**
		 * The type of cue point that was reached.
		 * 
		 * @see CuePointType
		 * @see CuePointType#EVENT
		 * @see CuePointType#NAVIGATION
		 */
		public function get type():String
		{
			if (info.hasOwnProperty("type"))
				return info.type as String;
			return null;
		}
	}
}