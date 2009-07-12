package a3lbmonkeybrain.motorcortex.locators {
	/**
	 * Static constants for event types used by locators.
	 * 
	 * @author T. Michael Keesey
	 * @see	Locator
	 */
	public final class LocatorEventType {
		/**
		 * The <code>LocatorEventType.CONSTRAINT_CHANGE</code> constant defines the value of the
		 * <code>type</code> property of the event object for a <code>constraintChange</code> event.
		 * <p>
		 * The properties of the event object have the following values:
		 * </p>
		 * <table class="innertable">
		 * <tr><th>Property</th>				<th>Value</th></tr>
		 * <tr><td><code>type</code></td>		<td><code>"constraintChange"</code></td></tr>
		 * <tr><td><code>bubbles</code></td>	<td><code>false</code></td></tr>
		 * <tr><td><code>cancelable</code></td>	<td><code>false</code></td></tr>
		 * </table>
		 *
		 * @eventType constraintChange
		 * @see Locator#constraint 
		 */
		public static const CONSTRAINT_CHANGE:String = "constraintChange";
		/**
		 * Defines the value of the <code>type</code> property of the event for a <code>destinationAway</code> event.
		 * <p>
		 * The properties of this event have the following values:
		 * </p>
		 * <table class="innertable">
		 * <tr><th>Property</th>				<th>Value</th></tr>
		 * <tr><td><code>bubbles</code></td>	<td><code>false</code></td></tr>
		 * <tr><td><code>cancelable</code></td>	<td><code>false</code>; there is no default behavior to cancel.</td></tr>
		 * <tr><td><code>type</code></td>		<td><code>&quot;destinationAway&quot;</code></td></tr>
		 * </table>
		 * 
		 * @see DestinedLocator#atDestination
		 */
		public static const DESTINATION_AWAY:String = "destinationAway";
		/**
		 * Defines the value of the <code>type</code> property of the event for a <code>destinationReached</code> event.
		 * <p>
		 * The properties of this event have the following values:
		 * </p>
		 * <table class="innertable">
		 * <tr><th>Property</th>				<th>Value</th></tr>
		 * <tr><td><code>bubbles</code></td>	<td><code>false</code></td></tr>
		 * <tr><td><code>cancelable</code></td>	<td><code>false</code>; there is no default behavior to cancel.</td></tr>
		 * <tr><td><code>type</code></td>		<td><code>&quot;destinationReached&quot;</code></td></tr>
		 * </table>  
		 * 
		 * @see DestinedLocator#atDestination
		 */
		public static const DESTINATION_REACHED:String = "destinationReached";
		/**
		 * Defines the value of the <code>type</code> property of the event for a <code>move</code> event.
		 * <p>
		 * The properties of this event have the following values:
		 * </p>
		 * <table class="innertable">
		 * <tr><th>Property</th>				<th>Value</th></tr>
		 * <tr><td><code>bubbles</code></td>	<td><code>false</code></td></tr>
		 * <tr><td><code>cancelable</code></td>	<td><code>false</code>; there is no default behavior to cancel.</td></tr>
		 * <tr><td><code>type</code></td>		<td><code>&quot;move&quot;</code></td></tr>
		 * </table>  
		 * 
		 * @see Locator#point
		 * @see Locator#x
		 * @see Locator#y
		 */
		public static const MOVE:String = "move";
	}
}