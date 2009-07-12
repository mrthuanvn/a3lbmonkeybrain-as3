package a3lbmonkeybrain.motorcortex.locators {
	import a3lbmonkeybrain.motorcortex.constraints.Constraint;
	
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	/**
	 * Dispatched when the <code>constraint</code> property changes. 
	 * 
	 * @eventType	a3lbmonkeybrain.motorcortex.locators.LocatorEventType.CONSTRAINT_CHANGE
	 * @see	#constraint
	 */
	[Event(name="constraintChange",type="flash.events.Event")]
	/**
	 * Dispatched when the <code>x</code> or <code>y</code> property changes. Also signals simultaneous changes
	 * in the <code>point</code> property.
	 * 
	 * @eventType	a3lbmonkeybrain.motorcortex.locators.LocatorEventType.MOVE
	 * @see	#point
	 * @see	#x
	 * @see	#y
	 */
	[Event(name="move",type="flash.events.Event")]
	/**
	 *Basic object that stores a two-dimensional point and dispatches events whenever that point moves.
	 * <p>
	 * Also has functionality for constraining the point (the <code>constraint</code> property).
	 * </p>
	 * 
	 * @author T. Michael Keesey
	 * @see	#constraint
	 */
	public class BasicLocator extends EventDispatcher implements Locator
	{
		/**
		 * @private
		 */
		private var _constraint:Constraint;
		/**
		 * @private
		 */
		protected var _x:Number;
		/**
		 * @private
		 */
		protected var _y:Number;
		/**
		 * Creates a new instance.
		 *  
		 * @param x
		 * 		Initial horizontal coordinate.
		 * @param y
		 * 		Initial vertical coordinate.
		 * @see	#x
		 * @see	#y
		 */
		public function BasicLocator(x:Number = 0.0, y:Number = 0.0) {
			super();
			_x = x;
			_y = y;
			addEventListener(LocatorEventType.CONSTRAINT_CHANGE, onConstraintChange, false, int.MAX_VALUE);
		}
		[Bindable(event="constraintChange")]
		/**
		 * @inheritDoc
		 */
		public final function get constraint():Constraint {
			return _constraint;
		}
		/**
		 * @private
		 */
		public function set constraint(value:Constraint):void {
			if (_constraint != value) {
				if (_constraint) {
					_constraint.removeEventListener(LocatorEventType.CONSTRAINT_CHANGE, dispatchEvent);
				}
				_constraint = value;
				if (_constraint) {
					_constraint.addEventListener(LocatorEventType.CONSTRAINT_CHANGE, dispatchEvent);
				}
				dispatchEvent(new Event(LocatorEventType.CONSTRAINT_CHANGE));
			}
		}
		[Bindable(event="move")]
		/**
		 * @inheritDoc
		 */
		public final function get point():Point {
			return new Point(_x, _y);
		}
		/**
		 * @private
		 */
		public final function set point(value:Point):void {
			if (_constraint != null) {
				value = _constraint.constrainPoint(value);
			}
			if (_x != value.x || _y != value.y) {
				_x = value.x;
				_y = value.y;
				dispatchEvent(new Event(LocatorEventType.MOVE));
			}
		}
		[Bindable(event="move")]
		/**
		 * @inheritDoc
		 */
		public final function get x():Number {
			return _x;
		}
		/**
		 * @private
		 */
		public final function set x(value:Number):void {
			if (_constraint) {
				value = _constraint.constrainPoint(new Point(value, _y)).x;
			}
			if (_x != value) {
				_x = value;
				dispatchEvent(new Event(LocatorEventType.MOVE));
			}
		}
		[Bindable(event="move")]
		/**
		 * @inheritDoc
		 */
		public final function get y():Number {
			return _y;
		}
		/**
		 * @private
		 */
		public final function set y(value:Number):void {
			if (_constraint) {
				value = _constraint.constrainPoint(new Point(_x, value)).y;
			}
			if (_y != value) {
				_y = value;
				dispatchEvent(new Event(LocatorEventType.MOVE));
			}
		}
		/**
		 * Updates the point that this locator represents when the constraint changes.
		 * 
		 * @param event
		 * 		Event dispatched by this object (highest priority).
		 * @see	#constraint
		 * @see	#point
		 */
		private function onConstraintChange(event:Event):void {
			if (_constraint) {
				point = point;
			}
		}
	}
}