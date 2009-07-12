package a3lbmonkeybrain.motorcortex.connectors
{
	/**
	 * Interface for a class which uses a display object to connect two locators.
	 * <p>
	 * Includes settings for motion blur.
	 * </p>
	 * 
	 * @author T. Michael Keesey
	 * @see	DisplayObjectConnector
	 * @see	a3lbmonkeybrain.motorcortex.locators.Locator
	 * @see	flash.display.DisplayObject
	 */
	public interface DisplayObjectConnector
	{
		/**
		 * The maximum amount that this connector can stretch. If 1, there will be no stretching at all.
		 * If 2, this connector can stretch to twice its normal height and half its normal width, or vice versa.
		 * <p>
		 * Cannot be set to a value lower than 1.
		 * </p>
		 * 
		 * @defaultValue Number.POSITIVE_INFINITY
		 * @see	Number#POSITIVE_INFINITY
		 */
		function get maxStretch():Number;
		/**
		 * @private
		 */
		function set maxStretch(value:Number):void
		/**
		 * The point, offset from the display object's center, that should be placed over <code>targetA</code>.
		 * <p>
		 * Cannot be the same as <code>pointB</code>.
		 * </p>
		 * 
		 * @throws	ArgumentError
		 * 		If set to the same point as <code>pointB</code>.
		 * @see	#pointB
		 * @see	#targetA
		 */
		function get pointA():Point;
		/**
		 * @private
		 */
		function set pointA(value:Point):void;
		/**
		 * The point, offset from the display object's center, that should be placed over <code>targetB</code>.
		 * <p>
		 * Cannot be the same as <code>pointA</code>.
		 * </p>
		 * 
		 * @throws	ArgumentError
		 * 		If set to the same point as <code>pointA</code>.
		 * @see	#pointA
		 * @see	#targetB
		 */
		function get pointB():Point;
		/**
		 * @private
		 */
		function set pointB(value:Point):void;
		/**
		 * The locator that indicates where <code>pointA</code> should be.
		 * <p>
		 * If <code>targetA</code> and <code>targetB</code> are the same, this will simply attach
		 * the display object at <code>pointA</code>.
		 * </p>
		 * 
		 * @see	#pointA
		 * @see	a3lbmonkeybrain.motorcortex.locators.Locator
		 */
		function get targetA():Locator;
		/**
		 * @private
		 */
		function set targetA(value:Locator):void;
		/**
		 * The locator that indicates where <code>pointB</code> should be.
		 * <p>
		 * If <code>targetA</code> and <code>targetB</code> are the same, this will simply attach
		 * the display object at <code>pointA</code>.
		 * </p>
		 * 
		 * @see	#pointB
		 * @see	a3lbmonkeybrain.motorcortex.locators.Locator
		 */
		function get targetB():Locator;
		/**
		 * @private
		 */
		function set targetB(value:Locator):void;
	}
}