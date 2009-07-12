package a3lbmonkeybrain.motorcortex.beacon {
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * Beacon that uses a timer's <code>timer</code> events.
	 * 
	 * @author T. Michael Keesey
	 * @see	flash.utils.Timer
	 * @see	flash.events.TimerEvent#TIMER
	 */
	public class TimerBeacon extends ProxyBeacon
	{
		/**
		 * Creates a new instance.
		 * 
		 * @param proxy
		 *		Timer. This beacon dispatches a <code>beacon</code> event every time <code>proxy</code>
		 * 		dispatches a <code>timer</code> event. 
		 * @param useWeakReference
		 * 		If true, allows <code>proxy</code> to be garbage-collected if there are no other references
		 * 		to it.
		 * @see	flash.utils.Timer
		 * @see	flash.events.TimerEvent#TIMER
		 * @see	flash.events.IEventDispatcher#addEventListener()
		 */
		public function TimerBeacon(proxy:Timer, useWeakReference:Boolean = true)
		{
			super(proxy, TimerEvent.TIMER, useWeakReference);
		}
	}
}