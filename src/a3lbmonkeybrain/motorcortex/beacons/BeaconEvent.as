package a3lbmonkeybrain.motorcortex.beacon
{
	import flash.events.Event;
	/**
	 * Event dispatched by a beacon at regular intervals.
	 * 
	 * @author T. Michael Keesey
	 * @see	#BEACON
	 * @see	Beacon
	 */
	public final class BeaconEvent extends Event
	{
		/**
		 * The <code>BeaconEvent.BEACON</code> constant defines the value of the <code>type</code> property of
		 * the event object for a <code>beacon</code> event.
		 * <p>
		 * The properties of the event object have the following values:
		 * </p>
		 * <table class="innertable">
		 * <tr><th>Property</th>				<th>Value</th></tr>
		 * <tr><td><code>type</code></td>		<td><code>"beacon"</code></td></tr>
		 * <tr><td><code>bubbles</code></td>	<td><code>false</code></td></tr>
		 * <tr><td><code>cancelable</code></td>	<td><code>false</code></td></tr>
		 * <tr><td><code>beaconTime</code></td>	<td>An unsigned integer, the number of milliseconds since the last <code>beacon</code> event (not including paused time).</td></tr>
		 * <tr><td><code>totalTime</code></td>	<td>An unsigned integer, the number of milliseconds since the beacon began (not including paused time).</td></tr>
		 * </table>
		 *
		 * @eventType beacon
		 * @see	#beaconTime
		 * @see	#totalTime
		 */
		public static const BEACON:String = "beacon";
		/**
		 * @private 
		 */
		private var _beaconTime:uint;
		/**
		 * @private 
		 */
		private var _totalTime:uint;
		/**
		 * Creates a new instance.
		 * 
		 * @param beaconTime
		 * 		Time since the last <code>beacon</code> event, in milliseconds, accessible as
		 * 		<code>BeaconEvent.beaconTime</code>.
		 * @param totalTime
		 * 		Time since the beacon started, in milliseconds, accessible as <code>BeaconEvent.totalTime</code>.
		 * @see	#beaconTime
		 * @see	#totalTime
		 */
		public function BeaconEvent(beaconTime:uint, totalTime:uint)
		{
			super(BEACON);
		}
		/**
		 * Time since the last <code>beacon</code> event, in milliseconds.
		 * <p>
		 * Does not include pause time.
		 * </p>
		 * 
		 * @see #totalTime
		 * @see	a3lbmonkeybrain.motorcortex.run.Runnable#running
		 */
		public function get beaconTime():uint
		{
			return _beaconTime;
		}
		/**
		 * Time since the beacon started, in milliseconds.
		 * <p>
		 * Does not include pause time.
		 * </p>
		 * 
		 * @see #beaconTime
		 * @see	a3lbmonkeybrain.motorcortex.run.Runnable#running
		 */
		public function get totalTime():uint
		{
			return _totalTime;
		}
		/**
		 * @inheritDoc 
		 */		
		override public function clone():Event
		{
			return new BeaconEvent(_beaconTime, _totalTime);
		}
		/**
		 * @inheritDoc 
		 */		
		override public function toString():String
		{
			return formatToString("BeaconEvent", "beaconTime", "totalTime");
		}
	}
}