package a3lbmonkeybrain.motorcortex.beacon
{
	import a3lbmonkeybrain.motorcortex.run.RunEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.utils.getTimer;
	/**
	 * Dispatched at regular intervals by this beacon.
	 *
	 * @eventType a3lbmonkeybrain.motorcortex.beacon.BeaconEvent.BEACON
	 */
	[Event(name="beacon",type="flash.events.Event")]
	/**
	 * Dispatched when this process starts or restarts.
	 *
	 * @eventType a3lbmonkeybrain.motorcortex.run.RunEvent.START
	 * @see #running
	 */
	[Event(name="start",type="a3lbmonkeybrain.motorcortex.run.RunEvent")]
	/**
	 * Dispatched when this process stops (that is, pauses).
	 *
	 * @eventType a3lbmonkeybrain.motorcortex.run.RunEvent.STOP
	 * @see #running
	 */
	[Event(name="stop",type="a3lbmonkeybrain.motorcortex.run.RunEvent")]
	/**
	 * A beacon that dispatches <code>beacon</code> events whenever another event dispatcher dispatches
	 * a certain type of event.
	 * 
	 * @author T. Michael Keesey
	 * @see	Beacon
	 */
	public class ProxyBeacon extends EventDispatcher implements Beacon
	{
		/**
		 * @private 
		 */
		private var _running:Boolean = true;
		/**
		 * @private 
		 */
		private var lastBeaconTime:uint;
		/**
		 * @private 
		 */
		private var now:uint;
		/**
		 * @private 
		 */
		private var pauseTime:uint = 0;
		/**
		 * @private 
		 */
		private var startTime:uint;
		/**
		 * Creates a new instance.
		 * 
		 * @param proxy
		 *		Event dispatcher. This beacon dispatches a <code>beacon</code> event every time <code>proxy</code>
		 * 		dispatches an event of the type specified by <code>eventType</code>.
		 * @eventType
		 * 		The type of event to listen for. <code>proxy</code> should dispatch this type of event at regular
		 * 		intervals. 
		 * @param useWeakReference
		 * 		If true, allows <code>proxy</code> to be garbage-collected if there are no other references
		 * 		to it.
		 * @see	flash.events.Event
		 * @see	flash.events.IEventDispatcher
		 * @see	flash.events.IEventDispatcher#addEventListener()
		 */
		public function AbstractProxyBeacon(proxy:IEventDispatcher, eventType:String, useWeakReference:Boolean = true)
		{
			super();
			lastBeaconTime = startTime = getTimer();
			addEventListener(proxy, onProxyEvent, false, 0, useWeakReference);
		}
		/**
		 * @inheritDoc
		 */
		public function get beaconTime():uint
		{
			if (paused)
				return pauseTime - lastBeaconTime;
			if (now == 0)
				return getTimer() - lastBeaconTime;
			return now - lastBeaconTime;
		}
		/**
		 * @inheritDoc
		 */
		public function get totalTime():uint
		{
			if (paused)
				return pauseTime - startTime;
			if (now == 0)
				return getTimer() - startTime;
			return now - startTime;
		}
		[Bindable(event="start")]
		[Bindable(event="stop")]
		/**
		 * @inheritDoc
		 */
		public function get running():Boolean
		{
			return _running;
		}
		/**
		 * @inheritDoc
		 */
		public function set running(value:Boolean):void
		{
			if (_running != value)
			{
				_running = value;
				if (_running)
				{
					var pauseLength:uint = getTimer() - pauseTime;
					startTime += pauseLength;
					lastBeaconTime += pauseLength;
					pauseTime = 0;
					paused = false;
				}
				else
				{
					pauseTime = getTimer();
					paused = true;
				}
				dispatchEvent(new RunEvent(_running));
			}
		}
		/**
		 * Responds to the proxy event by dispatching a <code>beacon</code> event and then updating
		 * <code>beaconTime</code> and <code>totalTime</code>.
		 * 
		 * @see	#beaconTime
		 */
		protected function onProxyEvent(event:Event):void
		{
			if (_running)
			{
				now = getTimer();
				dispatchEvent(new BeaconEvent(beaconTime, totalTime));
				lastBeaconTime = now;
				now = 0;
			}
		}
	}
}