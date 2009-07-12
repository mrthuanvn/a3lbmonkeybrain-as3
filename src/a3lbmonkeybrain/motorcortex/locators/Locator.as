package a3lbmonkeybrain.motorcortex.locators {
	import a3lbmonkeybrain.motorcortex.constraints.Constraint;
	
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	/**
	 * Dispatched when the <code>constraint</code> property changes. 
	 * 
	 * @eventType	a3lbmonkeybrain.motorcortex.constraintst.ConstraintEvent.CONSTRAINT_CHANGE
	 * @see	#constraint
	 */
	[Event(name="constraintChange",type="a3lbmonkeybrain.motorcortex.constraintst.ConstraintEvent")]
	/**
	 * Dispatched when the <code>x</code> or <code>y</code> property changes. Also signals simultaneous changes
	 * in the <code>point</code> property.
	 * 
	 * @eventType	a3lbmonkeybrain.motorcortex.locators.LocatorEvent.MOVE
	 * @see	#point
	 * @see	#x
	 * @see	#y
	 */
	[Event(name="move",type="a3lbmonkeybrain.motorcortex.locators.LocatorEventType")]
	/**
	 * Interface for objects that store a two-dimensional point and dispatch events whenever that point moves.
	 * <p>
	 * Also has functionality for constraining the point (the <code>constraint</code> property).
	 * </p>
	 * 
	 * @author T. Michael Keesey
	 * @see	#constraint
	 */
	public interface Locator extends IEventDispatcher
	{
		[Bindable(event="constraintChange")]
		/**
		 * An object that constrains the point that this object represents.
		 * If <code>null</code>, this object's point is unconstrained.
		 * 
		 * @default	null
		 * @see a3lbmonkeybrain.motorcortex.constraints
		 * @see a3lbmonkeybrain.motorcortex.constraints.IConstraint
		 */
		function get constraint():Constraint;
		/**
		 * @private
		 */
		function set constraint(value:Constraint):void;
		[Bindable(event="move")]
		/**
		 * The point that this object currently represents.
		 * <p>
		 * Note that setting the properties of this field will not change it. That is, this code will
		 * have no effect:
		 * <pre>
		 * var l:Locator = new Locator(0, 0);
		 * l.point.x = 100;
		 * trace(l.point); // traces "(x=0, y=0)"
		 * </pre>
		 * However, the field as a whole can be set:
		 * <pre>
		 * var l:Locator = new Locator(0, 0);
		 * l.point = new Point(100, 0);
		 * trace(l.point); // traces "(x=100, y=0)"
		 * </pre>
		 * </p>
		 * <p>
		 * Setting this field is usually more efficient than setting <code>x</code> and <code>y</code> separately.
		 * </p>
		 * 
		 * @default	(x=0, y=0)
		 * @see	#x
		 * @see	#y
		 */
		function get point():Point;
		/**
		 * @private
		 */
		function set point(value:Point):void;
		[Bindable(event="move")]
		/**
		 * The horizontal coordinate of the point that this object currently represents.
		 * <p>
		 * This field may be set to change the point that this object represents.
		 * </p>
		 * 
		 * @default	0
		 * @see	#point
		 * @see	#y
		 */
		function get x():Number;
		/**
		 * @private
		 */
		function set x(value:Number):void;
		[Bindable(event="move")]
		/**
		 * The vertical coordinate of the point that this object currently represents.
		 * <p>
		 * This field may be set to change the point that this object represents.
		 * </p>
		 * 
		 * @default	0
		 * @see	#point
		 * @see	#y
		 */
		function get y():Number;
		/**
		 * @private
		 */
		function set y(value:Number):void;
	}
}