package a3lbmonkeybrain.motorcortex.locators {
	import a3lbmonkeybrain.motorcortex.refresh.Refreshable;
	import a3lbmonkeybrain.motorcortex.run.RunEvent;
	import a3lbmonkeybrain.motorcortex.run.Runnable;
	
	import flash.errors.IllegalOperationError;
	import flash.events.Event;
	/**
	 * Dispatched when this locator starts or restarts.
	 *
	 * @eventType a3lbmonkeybrain.motorcortex.run.RunEvent.START
	 * @see #running
	 */
	[Event(name="start",type="a3lbmonkeybrain.motorcortex.run.RunEvent")]
	/**
	 * Dispatched when this locator stops (that is, pauses).
	 *
	 * @eventType a3lbmonkeybrain.motorcortex.run.RunEvent.STOP
	 * @see #running
	 */
	[Event(name="stop",type="a3lbmonkeybrain.motorcortex.run.RunEvent")]
	/**
	 * A locator that can be stopped and restarted. This can be used to optimize locator-based applications.
	 * <p>
	 * Note that a paused locator can still be updated by an external process (i.e., through the
	 * <code>x</code>, <code>y</code>, and <code>point</code> properties).
	 * </p>
	 * 
	 * @author T. Michael Keesey
	 */
	internal class RunnableLocator extends BasicLocator implements Refreshable, Runnable {
		/**
		 * @private 
		 */
		private var _running:Boolean = true;
		/**
		 * Creates a new instance.
		 *  
		 * @param x	Initial horizontal coordinate.
		 * @param y Initial vertical coordinate.
		 * @see	#x
		 * @see	#y
		 */
		public function RunnableLocator(x:Number = 0.0, y:Number = 0.0) {
			super(x, y);
		}
		[Bindable(event="start")]
		[Bindable(event="stop")]
		/**
		 * @inheritDoc
		 */
		public function get running():Boolean {
			return _running;
		}
		/**
		 * @inheritDoc
		 */
		public function set running(value:Boolean):void {
			if (_running != value) {
				_running = value;
				if (_running) {
					refresh(new RunEvent(_running));
				}
				dispatchEvent(new RunEvent(_running));
			}
		}
		/**
		 * Refreshes the locator. Called by <code>refresh</code>.
		 * <p>
		 * Must be overridden by subclasses.
		 * </p>
		 * 
		 * @param event
		 * 		[optional] - Dispatched event that triggered the refresh.
		 */
		protected function performRefresh(event:Event):void {
			throw new IllegalOperationError("RunnableLocator.performRefresh() must be overridden.");
		}
		/**
		 * @inheritDoc
		 */
		public final function refresh(event:Event = null):void {
			if (running) {
				performRefresh(event);
			}
		}
	}
}