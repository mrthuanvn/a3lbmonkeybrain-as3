package a3lbmonkeybrain.motorcortex.beacon
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * Timer-based beacon that creates its own timer. Optionally, this timer can be used to update the display
	 * after every <code>timer</code> event.
	 * 
	 * @author T. Michael Keesey
	 */
	public class AutoTimerBeacon extends TimerBeacon
	{
		/**
		 * Creates a new instance.
		 * 
		 * @param delay
		 * 		The delay, in milliseconds, between <code>timer</code> events.
		 * @param updateAfter
		 * 		If set to <code>true</code>, this beacon will update the display on every <code>timer</code>
		 * 		while it is running.
		 * @see #running
		 * @see flash.utils.Timer#delay
		 */		
		public function AutoTimerBeacon(delay:uint, updateAfter:Boolean = false)
		{
			super(createTimer(delay, updateAfter), false);
		}
		/**
		 * Creates this beacon's timer.
		 * 
		 * @private 
		 */
		private function createTimer(delay:uint, updateAfter:Boolean):Timer
		{
			var timer:Timer = new Timer(delay);
			timer.start();
			if (updateAfter)
				timer.addEventListener(TimerEvent.TIMER, this.updateAfter);
			return timer;
		}
		/**
		 * Updates the display after a timer event.
		 * 
		 * @private 
		 */
		private function updateAfter(event:TimerEvent):void
		{
			if (running) event.updateAfterEvent();
		}
	}
}