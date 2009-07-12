package a3lbmonkeybrain.motorcortex.locators {
	import a3lbmonkeybrain.motorcortex.refresh.Refreshable;
	/**
	 * Locator that tracks a joint linked to two other locators.
	 * 
	 * @author T. Michael Keesey
	 */
	public interface JointLocator extends Locator, Refreshable {
		// :TODO: Check CW and CCW
		/**
		 * The orientation of the joint. If -1, falls counterclockwise to the line segment between
		 * <code>origin</code> and <code>target</code>. If 1, falls clockwise to the line segment between
		 * <code>origin</code> and <code>target</code>. If this property is set to any negative number,
		 * it will be constrained to -1. If set to any other value, it will be constrained to 1.
		 * 
		 * @see #origin
		 * @see #target
		 */
		function get orientation():int;
		/**
		 * @private
		 */
		function set orientation(value:int):void;
		/**
		 * The locator which the segments are anchored to (e.g., a shoulder or a hip).
		 * 
		 * @see #target
		 */
		function get origin():Locator;
		/**
		 * @private
		 */
		function set origin(value:Locator):void;
		/**
		 * The locator that the segments are attempting to reach (e.g., a wrist or ankle).
		 * 
		 * @see #origin
		 */
		function get target():Locator;
		/**
		 * @private
		 */
		function set target(value:Locator):void;
	}
}