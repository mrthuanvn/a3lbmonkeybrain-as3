package a3lbmonkeybrain.motorcortex.run {
	import flash.events.IEventDispatcher;
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
	 * Interface for processes which can be stopped and restarted.
	 *  
	 * @author T. Michael Keesey
	 */
	public interface Runnable extends IEventDispatcher {
		[Bindable(event="start")]
		[Bindable(event="stop")]
		/**
		 * Tells whether this process is currently active. Setting this property to <code>true</code> will restart
		 * this process if it has stopped (or was never started). Setting this property to <code>false</code> will
		 * stop this process if it is running.
		 */
		function get running():Boolean;
		/**
		 * @private
		 */
		function set running(value:Boolean):void;
	}
}