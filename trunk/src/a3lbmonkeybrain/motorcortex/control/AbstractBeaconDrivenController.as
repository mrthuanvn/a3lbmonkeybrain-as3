package a3lbmonkeybrain.motorcortex.control
{
	import a3lbmonkeybrain.motorcortex.beacon.Beacon;
	import a3lbmonkeybrain.motorcortex.beacon.BeaconEvent;
	import a3lbmonkeybrain.motorcortex.refresh.Refreshable;
	import a3lbmonkeybrain.motorcortex.run.RunEvent;
	import a3lbmonkeybrain.motorcortex.run.Runnable;
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	/**
	 * Dispatched when the controller is restarted.
	 *
	 * @eventType a3lbmonkeybrain.motorcortex.run.RunEvent.START
	 * @see #running
	 */
	[Event(name="start",type="a3lbmonkeybrain.motorcortex.run.RunEvent")]
	/**
	 * Dispatched when the controller is stopped.
	 *
	 * @eventType a3lbmonkeybrain.motorcortex.run.RunEvent.STOP
	 * @see #running
	 */
	[Event(name="stop",type="a3lbmonkeybrain.motorcortex.run.RunEvent")]
	/**
	 * Controls a Boolean value which has a certain chance of being <code>true</code> or <code>false</code>.
	 * 
	 * @author T. Michael Keesey
	 * @see #probability
	 * @see	#value
	 */
	internal class AbstractBeaconDrivenController extends EventDispatcher implements Refreshable, Runnable
	{
		/**
		 * @private 
		 */
		private var _beacon:Beacon;
		/**
		 * @private 
		 */
		private var _running:Boolean = true;
		/**
		 * Creates a new instance.
		 */
		public function AbstractBeaconDrivenController()
		{
			super();
		}
		/**
		 * The beacon which refreshes this controller.
		 * <p>
		 * This controller uses a weak reference to listen to a beacon, so that if nothing else refers to the
		 * beacon, it will be garbage-collected.
		 * </p>
		 * 
		 * @see	#refresh()
		 * @see	a3lbmonkeybrain.motorcortex.beacon
		 * @see	a3lbmonkeybrain.motorcortex.beacon.BeaconEvent#BEACON
		 */
		public final function set beacon(value:Beacon):void
		{
			if (_beacon != value)
			{
				if (_beacon != null)
					_beacon.removeEventListener(BeaconEvent.BEACON, refresh);
				_beacon = value;
				if (_beacon != null)
					_beacon.addEventListener(BeaconEvent.BEACON, refresh, false, int.MAX_VALUE, true);
			}
		}
		[Bindable(event="start")]
		[Bindable(event="stop")]
		/**
		 * @inheritDoc
		 */
		public final function get running():Boolean
		{
			return _running;
		}
		/**
		 * @inheritDoc
		 */
		public final function set running(value:Boolean):void
		{
			if (_running != value)
			{
				_running = value;
				dispatchEvent(new RunEvent(_running));
			}
		}
		/**
		 * @inheritDoc
		 */
		public function refresh(event:Event = null):void
		{
			throw new IllegalOperationError("AbstractBeaconDrivenController.refresh() must be overridden in concrete subclasses.");
		}
	}
}