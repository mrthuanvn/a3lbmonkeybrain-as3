package a3lbmonkeybrain.motorcortex.beacon
{
	import a3lbmonkeybrain.motorcortex.run.Runnable;
	/**
	 * Dispatched at regular intervals by this beacon.
	 *
	 * @eventType a3lbmonkeybrain.motorcortex.beacon.BeaconEvent.BEACON
	 */
	[Event(name="beacon",type="a3lbmonkeybrain.motorcortex.beacon.BeaconEvent")]
	/**
	 * An object that regularly dispatches events that can be used to update refreshable objects.
	 * 
	 * @author T. Michael Keesey
	 * @see a3lbmonkeybrain.motorcortex.refresh.Refreshable
	 */
	public interface Beacon extends Runnable
	{
		/**
		 * The number of milliseconds since the last <code>beacon</code> event.
		 * <p>
		 * Does not include paused time.
		 * </p>
		 * 
		 * @see	#running
		 * @see	#totalTime
		 */		
		function get beaconTime():uint;
		/**
		 * The number of milliseconds since this beacon began.
		 * <p>
		 * Does not include paused time.
		 * </p>
		 * 
		 * @see	#beaconTime
		 * @see	#running
		 */		
		function get totalTime():uint;
	}
}