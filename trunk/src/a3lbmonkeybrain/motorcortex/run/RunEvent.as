package a3lbmonkeybrain.motorcortex.run {
	import flash.events.Event;
	/**
	 * Event dispatched by a <code>Runnable</code> object.
	 * 
	 * @author T. Michael Keesey
	 * @see	#START
	 * @see	#STOP
	 * @see	Runnable
	 */
	public final class RunEvent extends Event {
		/**
		 * The <code>RunEvent.START</code> constant defines the value of the <code>type</code> property of
		 * the event object for a <code>start</code> event.
		 * <p>
		 * The properties of the event object have the following values:
		 * </p>
		 * <table class="innertable">
		 * <tr><th>Property</th>				<th>Value</th></tr>
		 * <tr><td><code>type</code></td>		<td><code>"start"</code></td></tr>
		 * <tr><td><code>bubbles</code></td>	<td><code>false</code></td></tr>
		 * <tr><td><code>cancelable</code></td>	<td><code>false</code></td></tr>
		 * </table>
		 *
		 * @eventType start
		 * @see	Runnable#running
		 */
		public static const START:String = "start";
		/**
		 * The <code>RunEvent.STOP</code> constant defines the value of the <code>type</code> property of
		 * the event object for a <code>stop</code> event.
		 * <p>
		 * The properties of the event object have the following values:
		 * </p>
		 * <table class="innertable">
		 * <tr><th>Property</th>				<th>Value</th></tr>
		 * <tr><td><code>type</code></td>		<td><code>"stop"</code></td></tr>
		 * <tr><td><code>bubbles</code></td>	<td><code>false</code></td></tr>
		 * <tr><td><code>cancelable</code></td>	<td><code>false</code></td></tr>
		 * </table>
		 *
		 * @eventType stop
		 * @see	Runnable#running
		 */
		public static const STOP:String = "stop";
		/**
		 * Creates a new instance.
		 *  
		 * @param running
		 * 		Boolean value telling whether the related process is running or not. If <code>true</code>,
		 * 		this event will have the type <code>"start"</code>. If <code>false</code>, this event will have
		 * 		the type <code>"stop"</code>.
		 * @see	#START
		 * @see	#STOP
		 * @see	Runnable#running 
		 */
		public function RunEvent(running:Boolean) {
			super(running ? START : STOP);
		}
		/**
		 * @inheritDoc
		 */
		override public function clone():Event {
			return new RunEvent(type == START);
		} 
		/**
		 * @inheritDoc
		 */
		override public function toString():String {
			return formatToString("RunEvent", "type");
		}
	}
}